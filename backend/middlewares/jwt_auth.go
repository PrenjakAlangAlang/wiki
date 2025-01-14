package middleware

import (
	"context"
	"fmt"
	"net/http"
	"strings"
	"time"

	"github.com/golang-jwt/jwt/v5"
)

// jwtKey adalah kunci rahasia untuk penandatanganan JWT
var jwtKey = []byte("wiki") // Ganti dengan kunci rahasia Anda

// Claims adalah struktur untuk klaim token JWT
type Claims struct {
	ID   int  `json:"id"`   // ID pengguna, tipe data int
	Role int  `json:"role"` // Role pengguna, tipe data int
	jwt.RegisteredClaims        // Klaim terdaftar seperti 'exp', 'iat', dll.
}

// ContextKey adalah tipe baru untuk key di context
type ContextKey string

// UserContextKey adalah key context untuk menyimpan klaim pengguna
const UserContextKey ContextKey = "user"

// JWTAuth adalah middleware untuk memvalidasi token JWT
func JWTAuth(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		// Ambil header Authorization dari request
		authHeader := r.Header.Get("Authorization")
		if authHeader == "" {
			// Jika header Authorization tidak ada
			fmt.Println("Authorization header is missing")
			http.Error(w, "Unauthorized: Missing Authorization header", http.StatusUnauthorized)
			return
		}

		// Periksa format header Authorization (harus dimulai dengan "Bearer ")
		if !strings.HasPrefix(authHeader, "Bearer ") {
			fmt.Println("Authorization header is malformed:", authHeader)
			http.Error(w, "Unauthorized: Malformed Authorization header", http.StatusUnauthorized)
			return
		}

		// Ambil token JWT dari header Authorization
		tokenString := strings.TrimPrefix(authHeader, "Bearer ")
		claims := &Claims{} // Membuat klaim kosong untuk diisi dengan informasi dari token

		// Parsing token JWT dan verifikasi tanda tangan
		token, err := jwt.ParseWithClaims(tokenString, claims, func(token *jwt.Token) (interface{}, error) {
			// Pastikan token menggunakan metode penandatanganan HMAC
			if _, ok := token.Method.(*jwt.SigningMethodHMAC); !ok {
				fmt.Printf("Unexpected signing method: %v\n", token.Header["alg"])
				return nil, fmt.Errorf("unexpected signing method: %v", token.Header["alg"])
			}
			return jwtKey, nil
		})

		// Cek jika ada error parsing token
		if err != nil {
			fmt.Println("Error parsing token:", err)
			http.Error(w, "Unauthorized: Invalid token", http.StatusUnauthorized)
			return
		}

		// Periksa apakah token valid
		if !token.Valid {
			fmt.Println("Token is invalid")
			http.Error(w, "Unauthorized: Invalid token", http.StatusUnauthorized)
			return
		}

		// Validasi klaim `exp` (token belum expired)
		if claims.ExpiresAt == nil || claims.ExpiresAt.Time.Before(time.Now()) {
			fmt.Println("Token has expired")
			http.Error(w, "Unauthorized: Token has expired", http.StatusUnauthorized)
			return
		}

		// Validasi klaim ID (contoh tambahan)
		if claims.ID == 0 {
			fmt.Println("Claims ID is missing or invalid")
			http.Error(w, "Unauthorized: Invalid claims", http.StatusUnauthorized)
			return
		}

		// Log klaim untuk debugging
		fmt.Printf("Token is valid. User ID: %d, Role: %d\n", claims.ID, claims.Role)

		// Simpan klaim pengguna dalam context untuk digunakan di handler berikutnya
		ctx := context.WithValue(r.Context(), UserContextKey, claims)
		next.ServeHTTP(w, r.WithContext(ctx)) // Lanjutkan ke handler berikutnya dengan context baru
	})
}
