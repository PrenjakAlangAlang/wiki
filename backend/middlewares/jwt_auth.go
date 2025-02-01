package middleware

import (
	"context"
	"crypto/aes"
	"crypto/cipher"
	"encoding/base64"
	"fmt"
	"net/http"
	"strings"

	"github.com/golang-jwt/jwt/v5"
)

// Kunci untuk JWT dan AES
var jwtKey = []byte("wiki")
var encryptionKey = []byte("myverystrongpasswordo32bitlength") // Pastikan panjangnya 32 byte

// Claims adalah struktur untuk klaim token JWT
type Claims struct {
	ID     int    `json:"id"`
	Role   string `json:"role"`
	RoleID int64  `json:"role_id"` // Menambahkan field role_id
	Permissions []string `json:"permissions"`
	jwt.RegisteredClaims
}

// ContextKey adalah tipe baru untuk key di context
type ContextKey string

// UserContextKey adalah key context untuk menyimpan klaim pengguna
const UserContextKey ContextKey = "user"

// decryptToken mendekripsi token JWT yang terenkripsi dengan AES-GCM
func decryptToken(encryptedToken string) (string, error) {
	decoded, err := base64.StdEncoding.DecodeString(encryptedToken)
	if err != nil {
		return "", fmt.Errorf("failed to decode base64 token: %v", err)
	}

	block, err := aes.NewCipher(encryptionKey)
	if err != nil {
		return "", fmt.Errorf("failed to create AES cipher: %v", err)
	}

	aesGCM, err := cipher.NewGCM(block)
	if err != nil {
		return "", fmt.Errorf("failed to create GCM mode: %v", err)
	}

	nonceSize := aesGCM.NonceSize()
	if len(decoded) < nonceSize {
		return "", fmt.Errorf("invalid encrypted token format")
	}

	nonce := decoded[:nonceSize]
	ciphertext := decoded[nonceSize:]

	plaintext, err := aesGCM.Open(nil, nonce, ciphertext, nil)
	if err != nil {
		return "", fmt.Errorf("failed to decrypt token: %v", err)
	}

	return string(plaintext), nil
}


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

		if authHeader == "" {
			http.Error(w, "Authorization header is missing", http.StatusUnauthorized)
			return
		}

		// Pastikan header dimulai dengan Bearer
		if !strings.HasPrefix(authHeader, "Bearer ") {
			http.Error(w, "Authorization header must be in the form of 'Bearer {token}'", http.StatusUnauthorized)
			return
		}

		// Ambil token dari header dan dekripsi terlebih dahulu
		encryptedToken := strings.TrimPrefix(authHeader, "Bearer ")
		tokenString, err := decryptToken(encryptedToken)
		if err != nil {
			http.Error(w, "Failed to decrypt token", http.StatusUnauthorized)
			return
		}

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
