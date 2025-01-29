package entities

// RolePermission mewakili relasi antara role dan permission
type RolePermission struct {
	RoleID      int `json:"role_id"`
	PermissionID int `json:"permission_id"`
}
