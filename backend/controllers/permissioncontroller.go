package controllers

import (
	"backend/models"
	"encoding/json"
	"fmt"
	"net/http"
)

var permissionModel = models.NewPermissionModel()

func GetPermissionList(w http.ResponseWriter, r *http.Request) {
	permission, err := permissionModel.GetAllPermissionList()
	if err != nil {
		http.Error(w, fmt.Sprintf("Error retrieving permission: %v", err), http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(permission)
}
