package middleware

import (
	"context"
	"fmt"
	"net/http"
	"strings"

	"github.com/golang-jwt/jwt/v5"
)

var jwtKey = []byte("wiki") 

// Claims adalah struktur untuk klaim token JWT
type Claims struct {
	ID     int  `json:"id"`
	Role   string  `json:"role"`
	RoleID int64 `json:"role_id"` // Menambahkan field role_id
	jwt.RegisteredClaims
}

// ContextKey adalah tipe baru untuk key di context
type ContextKey string

// UserContextKey adalah key context untuk menyimpan klaim pengguna
const UserContextKey ContextKey = "user"

// JWTAuth adalah middleware untuk memvalidasi token JWT
func JWTAuth(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		// Mengecualikan pengecekan token untuk endpoint login
		if r.URL.Path == "/login" {
			next.ServeHTTP(w, r)
			return
		}

		// Periksa apakah Authorization header ada
		authHeader := r.Header.Get("Authorization")

		// Jika tidak ada header Authorization, beri respons error
		if authHeader == "" {
			http.Error(w, "Authorization header is missing", http.StatusUnauthorized)
			return
		}

		// Pastikan header dimulai dengan Bearer
		if !strings.HasPrefix(authHeader, "Bearer ") {
			http.Error(w, "Authorization header must be in the form of 'Bearer {token}'", http.StatusUnauthorized)
			return
		}

		// Ambil token dari header
		tokenString := strings.TrimPrefix(authHeader, "Bearer ")
		claims := &Claims{}

		// Parsing token dengan klaim
		token, err := jwt.ParseWithClaims(tokenString, claims, func(token *jwt.Token) (interface{}, error) {
			// Verifikasi metode penandatanganan token
			if _, ok := token.Method.(*jwt.SigningMethodHMAC); !ok {
				return nil, fmt.Errorf("unexpected signing method: %v", token.Header["alg"])
			}
			return jwtKey, nil
		})

		// Jika terjadi error atau token tidak valid, beri respons error
		if err != nil || !token.Valid {
			http.Error(w, "Invalid or expired token", http.StatusUnauthorized)
			return
		}

		// Jika token valid, simpan klaim dalam context
		ctx := context.WithValue(r.Context(), UserContextKey, claims)

		// Lanjutkan dengan request yang sudah dibekali context
		next.ServeHTTP(w, r.WithContext(ctx))
	})
}
