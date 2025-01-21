package middleware

import (
	"database/sql"
	"fmt"
	"log"
	"net/http"
)

// DB adalah objek koneksi ke database
var DB *sql.DB

func RoleAuthMiddleware(requiredPermission string, next http.Handler) http.Handler {
    return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
        userClaims, ok := r.Context().Value(UserContextKey).(*Claims)
        if !ok {
            http.Error(w, "User claims not found", http.StatusUnauthorized)
            return
        }

        // Log the role to ensure correct role is being used
        log.Printf("Fetching permissions for role: %v", userClaims.Role)

        // Ambil permissions untuk role yang sesuai dari database
        permissions, err := getPermissionsForRole(userClaims.Role)
        if err != nil {
            log.Printf("Failed to get permissions: %v", err)  // Log error lebih detail
            http.Error(w, "Failed to get permissions", http.StatusInternalServerError)
            return
        }

        // Log permissions untuk memastikan kita mendapatkannya dengan benar
        log.Printf("Permissions for role %v: %v", userClaims.Role, permissions)

        // Periksa apakah user memiliki permission yang dibutuhkan
        hasPermission := false
        for _, permission := range permissions {
            if permission == requiredPermission {
                hasPermission = true
                break
            }
        }

        if !hasPermission {
            http.Error(w, "You do not have the required permission to access this resource", http.StatusForbidden)
            return
        }

        next.ServeHTTP(w, r)
    })
}



func getPermissionsForRole(roleID int) ([]string, error) {
    if DB == nil {
        return nil, fmt.Errorf("database connection is not initialized")
    }

    log.Printf("Executing query for role ID %d", roleID)  // Log query execution

    // Query untuk mengambil permissions berdasarkan role_id
    query := `
        SELECT p.name
        FROM permissions p
        JOIN role_permissions rp ON rp.permission_id = p.id
        WHERE rp.role_id = ?
    `
    rows, err := DB.Query(query, roleID)
    if err != nil {
        return nil, fmt.Errorf("failed to query permissions: %w", err)
    }
    defer rows.Close()

    var permissions []string
    for rows.Next() {
        var permission string
        if err := rows.Scan(&permission); err != nil {
            log.Println("Error scanning permission:", err)
            continue
        }
        permissions = append(permissions, permission)
    }

    if err := rows.Err(); err != nil {
        return nil, fmt.Errorf("error reading rows: %w", err)
    }

    // Pastikan ada permissions yang ditemukan
    if len(permissions) == 0 {
        return nil, fmt.Errorf("no permissions found for role ID: %d", roleID)
    }

    return permissions, nil
}


