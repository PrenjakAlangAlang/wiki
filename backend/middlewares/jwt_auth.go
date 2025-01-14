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

		// Fungsi untuk memberikan role default
		assignDefaultRole := func(w http.ResponseWriter, r *http.Request) {
			defaultClaims := &Claims{
				ID:   0, // ID 0 untuk pengguna anonim
				Role: 4, // Role 4 untuk pengguna tidak terdaftar
			}
			// Simpan klaim pengguna dengan role default (role 4)
			ctx := context.WithValue(r.Context(), UserContextKey, defaultClaims)
			next.ServeHTTP(w, r.WithContext(ctx))
		}

		// Jika header Authorization tidak ada, beri role default
		if authHeader == "" {
			fmt.Println("No Authorization header, assigning default role (role 4).")
			assignDefaultRole(w, r)
			return
		}

		// Periksa format header Authorization (harus dimulai dengan "Bearer ")
		if !strings.HasPrefix(authHeader, "Bearer ") {
			fmt.Println("Malformed Authorization header. Assigning default role.")
			assignDefaultRole(w, r)
			return
		}

		// Ambil token JWT dari header Authorization
		tokenString := strings.TrimPrefix(authHeader, "Bearer ")
		claims := &Claims{} // Klaim kosong untuk diisi dengan informasi dari token

		// Parsing token JWT dan verifikasi tanda tangan
		token, err := jwt.ParseWithClaims(tokenString, claims, func(token *jwt.Token) (interface{}, error) {
			// Pastikan token menggunakan metode penandatanganan HMAC
			if _, ok := token.Method.(*jwt.SigningMethodHMAC); !ok {
				fmt.Printf("Unexpected signing method: %v\n", token.Header["alg"])
				return nil, fmt.Errorf("unexpected signing method: %v", token.Header["alg"])
			}
			return jwtKey, nil
		})

		// Cek jika ada error parsing token atau token tidak valid
		if err != nil || !token.Valid {
			fmt.Println("Invalid or expired token. Assigning default role.")
			assignDefaultRole(w, r)
			return
		}

		// Validasi klaim `exp` (token belum expired)
		if claims.ExpiresAt == nil || claims.ExpiresAt.Time.Before(time.Now()) {
			// Jika token sudah expired, beri pemberitahuan
			fmt.Println("Token has expired, assigning default role (role 4).")
			http.Error(w, "Your session has expired. Please login again.", http.StatusUnauthorized)
			assignDefaultRole(w, r)
			return
		}

		// Validasi klaim ID (contoh tambahan)
		if claims.ID == 0 {
			fmt.Println("Claims ID is missing or invalid. Assigning default role.")
			assignDefaultRole(w, r)
			return
		}

		// Token valid, simpan klaim pengguna dalam context
		fmt.Printf("Token is valid. User ID: %d, Role: %d\n", claims.ID, claims.Role)
		ctx := context.WithValue(r.Context(), UserContextKey, claims)
		next.ServeHTTP(w, r.WithContext(ctx)) // Lanjutkan ke handler berikutnya dengan context baru
	})
}
