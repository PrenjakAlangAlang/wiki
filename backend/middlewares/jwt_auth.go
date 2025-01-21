package middleware

import (
	"context"
	"fmt"
	"net/http"
	"strings"
	"time"

	"github.com/golang-jwt/jwt/v5"
)

var jwtKey = []byte("wiki") // Ganti dengan kunci rahasia Anda

// Claims adalah struktur untuk klaim token JWT
type Claims struct {
	ID   int  `json:"id"`
	Role int  `json:"role"`
	jwt.RegisteredClaims
}

// ContextKey adalah tipe baru untuk key di context
type ContextKey string

// UserContextKey adalah key context untuk menyimpan klaim pengguna
const UserContextKey ContextKey = "user"

// JWTAuth adalah middleware untuk memvalidasi token JWT
func JWTAuth(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		authHeader := r.Header.Get("Authorization")

		assignDefaultRole := func(w http.ResponseWriter, r *http.Request) {
			defaultClaims := &Claims{
				ID:   0,
				Role: 4,
			}
			ctx := context.WithValue(r.Context(), UserContextKey, defaultClaims)
			next.ServeHTTP(w, r.WithContext(ctx))
		}

		if authHeader == "" {
			assignDefaultRole(w, r)
			return
		}

		if !strings.HasPrefix(authHeader, "Bearer ") {
			assignDefaultRole(w, r)
			return
		}

		tokenString := strings.TrimPrefix(authHeader, "Bearer ")
		claims := &Claims{}

		token, err := jwt.ParseWithClaims(tokenString, claims, func(token *jwt.Token) (interface{}, error) {
			if _, ok := token.Method.(*jwt.SigningMethodHMAC); !ok {
				return nil, fmt.Errorf("unexpected signing method: %v", token.Header["alg"])
			}
			return jwtKey, nil
		})

		if err != nil || !token.Valid {
			assignDefaultRole(w, r)
			return
		}

		if claims.ExpiresAt == nil || claims.ExpiresAt.Time.Before(time.Now()) {
			http.Error(w, "Your session has expired. Please login again.", http.StatusUnauthorized)
			assignDefaultRole(w, r)
			return
		}

		ctx := context.WithValue(r.Context(), UserContextKey, claims)
		next.ServeHTTP(w, r.WithContext(ctx))
	})
}
