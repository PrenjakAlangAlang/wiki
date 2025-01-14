package main

import (
	contentcontroller "backend/controllers"
	historycontroller "backend/controllers"
	instancecontroller "backend/controllers"
	rolecontroller "backend/controllers"
	subheadingcontroller "backend/controllers"
	usercontroller "backend/controllers"
	middleware "backend/middlewares"
	"log"
	"net/http"

	"github.com/gorilla/handlers"
	"github.com/gorilla/mux"
	 
	
)

func main() {
	// Inisialisasi router
	r := mux.NewRouter()

	// Konfigurasi CORS
	cors := handlers.CORS(
		handlers.AllowedOrigins([]string{"http://localhost:3001"}), // Frontend URL
		handlers.AllowedMethods([]string{"GET", "POST", "PUT", "DELETE", "OPTIONS"}),
		handlers.AllowedHeaders([]string{"Content-Type", "Authorization", "X-Requested-With", "Accept"}),
		handlers.AllowCredentials(), // Izinkan penggunaan credentials (cookies, dll.)
	)

// Endpoint dengan middleware JWT dan RoleAuth untuk role 1 dan 2
r.Handle("/api", middleware.JWTAuth(middleware.RoleAuthMiddleware([]int{1, 2, 3, 4}, http.HandlerFunc(contentcontroller.GetIdTitleAllContents)))).Methods("GET")
r.Handle("/api/content", middleware.JWTAuth(middleware.RoleAuthMiddleware([]int{1, 2, 3, 4}, http.HandlerFunc(contentcontroller.SearchContent)))).Methods("GET")
r.Handle("/api/content/{id}", middleware.JWTAuth(middleware.RoleAuthMiddleware([]int{1, 2, 3, 4}, http.HandlerFunc(contentcontroller.GetContentByID)))).Methods("GET")
r.Handle("/api/content/edit/{id}", middleware.JWTAuth(middleware.RoleAuthMiddleware([]int{1, 2, 3, 4}, http.HandlerFunc(contentcontroller.EditContentByID)))).Methods("PUT")
r.Handle("/api/content/add", middleware.JWTAuth(middleware.RoleAuthMiddleware([]int{1, 2, 3, 4}, http.HandlerFunc(contentcontroller.CreateContent)))).Methods("POST")
r.Handle("/api/subheading/add/{id}", middleware.JWTAuth(middleware.RoleAuthMiddleware([]int{1, 2, 3, 4}, http.HandlerFunc(subheadingcontroller.CreateSubheading)))).Methods("POST")
r.Handle("/api/subheading/delete/{id}", middleware.JWTAuth(middleware.RoleAuthMiddleware([]int{1, 2, 3, 4}, http.HandlerFunc(contentcontroller.DeleteSubheadingByID)))).Methods("DELETE")
r.Handle("/api/content/delete/{id}", middleware.JWTAuth(middleware.RoleAuthMiddleware([]int{1, 2, 3, 4}, http.HandlerFunc(contentcontroller.DeleteContent)))).Methods("DELETE")
r.Handle("/api/contents/user/{id}", middleware.JWTAuth(middleware.RoleAuthMiddleware([]int{1, 2, 3, 4}, http.HandlerFunc(contentcontroller.GetUserContents)))).Methods("GET")
r.Handle("/api/instances", middleware.JWTAuth(middleware.RoleAuthMiddleware([]int{1, 2, 3, 4}, http.HandlerFunc(instancecontroller.GetInstances)))).Methods("GET")
r.Handle("/api/user/{id}", middleware.JWTAuth(middleware.RoleAuthMiddleware([]int{1, 2, 3, 4}, http.HandlerFunc(usercontroller.GetUserByID)))).Methods("GET")
r.Handle("/api/users", middleware.JWTAuth(middleware.RoleAuthMiddleware([]int{1, 2, 3, 4}, http.HandlerFunc(usercontroller.GetAllUsers)))).Methods("GET")
r.Handle("/api/roles", middleware.JWTAuth(middleware.RoleAuthMiddleware([]int{1, 2, 3, 4}, http.HandlerFunc(rolecontroller.GetRoles)))).Methods("GET")
r.Handle("/api/createuser", middleware.JWTAuth(middleware.RoleAuthMiddleware([]int{1, 2, 3, 4}, http.HandlerFunc(usercontroller.CreateUser)))).Methods("POST")
r.Handle("/api/user/edit/{id}", middleware.JWTAuth(middleware.RoleAuthMiddleware([]int{1, 2, 3, 4}, http.HandlerFunc(usercontroller.EditUserById)))).Methods("PUT")
r.Handle("/api/user/{id}", middleware.JWTAuth(middleware.RoleAuthMiddleware([]int{1, 2, 3, 4}, http.HandlerFunc(usercontroller.DeleteUser)))).Methods("DELETE")
r.Handle("/api/history/add", middleware.JWTAuth(middleware.RoleAuthMiddleware([]int{1, 2, 3, 4}, http.HandlerFunc(historycontroller.AddHistory)))).Methods("POST")
r.Handle("/api/history/user/{id}", middleware.JWTAuth(middleware.RoleAuthMiddleware([]int{1, 2, 3, 4}, http.HandlerFunc(historycontroller.GetByIdUser)))).Methods("GET")
r.Handle("/api/latest-editor-name/{contentId}", middleware.JWTAuth(middleware.RoleAuthMiddleware([]int{1, 2, 3, 4}, http.HandlerFunc(historycontroller.GetLatestEditorNameByContentId)))).Methods("GET")

// Endpoint tanpa middleware untuk login
r.HandleFunc("/api/login", usercontroller.Login).Methods("POST")

	// Jalankan server dengan middleware CORS
	log.Println("Server is running on port 3000")
	if err := http.ListenAndServe(":3000", cors(r)); err != nil {
		log.Fatalf("Failed to start server: %v", err)
	}
}