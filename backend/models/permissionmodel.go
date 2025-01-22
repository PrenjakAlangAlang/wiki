package models

import (
	"backend/config"
	"backend/entities"
	"database/sql"
	"fmt"
)

type PermissionModel struct {
	conn *sql.DB
}

func NewPermissionModel() *PermissionModel {
	conn, err := config.DBConnection()
	if err != nil {
		panic(err)
	}
	return &PermissionModel{conn: conn}
}

func (p *PermissionModel) GetAllPermissionList() ([]entities.Instance, error) {
	query := "SELECT id, name FROM permissions"
	rows, err := p.conn.Query(query)
	if err != nil {
		return nil, fmt.Errorf("failed to fetch permissions: %v", err)
	}
	defer rows.Close()

	var permissions []entities.Instance
	for rows.Next() {
		var instance entities.Instance
		if err := rows.Scan(&instance.Id, &instance.Name); err != nil {
			return nil, fmt.Errorf("failed to get permissions: %v", err)
		}
		permissions = append(permissions, instance)
	}
	return permissions, nil
}
