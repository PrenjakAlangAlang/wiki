package middleware

import (
	"fmt"
	"net/http"

)

// RoleAuthMiddleware adalah middleware untuk memverifikasi peran pengguna
func RoleAuthMiddleware(allowedRoles []int, next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		// Ambil klaim pengguna dari context
		claims, ok := r.Context().Value(UserContextKey).(*Claims)
		if !ok || claims == nil {
			http.Error(w, "Unauthorized: Missing or invalid claims", http.StatusUnauthorized)
			return
		}

		// Ambil role dari klaim token
		userRole := claims.Role

		// Periksa apakah role pengguna ada dalam allowedRoles
		for _, role := range allowedRoles {
			if userRole == role {
				// Jika role cocok, lanjutkan ke handler berikutnya
				fmt.Println("Akses diizinkan untuk role:", userRole)
				next.ServeHTTP(w, r) // Panggil handler berikutnya
				return
			}
		}

		// Jika role tidak cocok, beri respons error
		http.Error(w, "Forbidden: You do not have the correct role", http.StatusForbidden)
	})
}
