import axios from 'axios';

// Create axios instance
const api = axios.create({
  baseURL: 'http://localhost:3000/api',
  timeout: 5000,
});

let isAlertShown = false; 

// Add response interceptor
api.interceptors.response.use(
  (response) => response,
  async (error) => {
    const originalRequest = error.config;
    
    if (error.response?.status === 401 && !originalRequest._retry) {
      originalRequest._retry = true;
      
      // Show alert message before redirect
      if (!isAlertShown) {
        isAlertShown = true; // Set agar tidak tampil lagi
        alert("Sesi Anda telah berakhir karena token habis. Silakan masuk kembali.");
      }
      
      try {
        // Get guest token
        const guestResponse = await api.get('/guest');
        const { token, role, role_id, permissions } = guestResponse.data;
        
        // Store new guest credentials
        localStorage.setItem('token', token);
        localStorage.setItem('user', JSON.stringify({ role, role_id, permissions }));
        
        // Force redirect to home page
        const currentPath = window.location.pathname;
        if (currentPath !== '/') {
          window.location.replace('/');
          return Promise.reject(new Error('Redirecting to home page'));
        }
        
        // Only retry the request if we're already on the home page
        originalRequest.headers.Authorization = `Bearer ${token}`;
        return api(originalRequest);
      } catch (e) {
        console.error('Failed to get guest token:', e);
        // Force redirect even if guest token fails
        if (window.location.pathname !== '/') {
          window.location.replace('/');
        }
        return Promise.reject(error);
      }
    }
    return Promise.reject(error);
  }
);

// Request interceptor
api.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem('token');
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }
    config.headers['Content-Type'] = 'application/json';
    config.headers['Accept'] = 'application/json';
    return config;
  },
  (error) => Promise.reject(error)
)

export const apiService = {
  // Auth related
  getGuestToken: () => api.get('/guest'),
  decodeToken: (encrypted_token) => api.post('/decode', { encrypted_token }),
  login: (credentials) => api.post('/login', credentials),
  
  // Content related
  getActiveContents: () => api.get('/active'),
  getContentById: (id) => api.get(`/content/${id}`),
  createContent: (data) => api.post('/content/add', data),
  editContent: (id, data) => api.put(`/content/edit/${id}`, data),
  deleteContent: (id) => api.put(`/content/delete/${id}`),
  searchContent: (params) => api.get('/content', { params }),
  getUserContents: (userId) => api.get(`/contents/user/${userId}`),
  
  // Additional endpoints from main.go
  getNotRejectedContents: () => api.get('/notReject'),
  getDrafts: () => api.get('/draft'),
  createSubheading: (id, data) => api.post(`/subheading/add/${id}`, data),
  deleteSubheading: (id) => api.delete(`/subheading/delete/${id}`),
  getInstances: () => api.get('/instances'),
  getUserById: (id) => api.get(`/user/${id}`),
  getAllUsers: () => api.get('/users'),
  getRoles: () => api.get('/roles'),
  createUser: (data) => api.post('/createuser', data),
  editUser: (id, data) => api.put(`/user/edit/${id}`, data),
  deleteUser: (id) => api.delete(`/user/${id}`),
  addHistory: (data) => api.post('/history/add', data),
  getHistoryByUserId: (id) => api.get(`/history/user/${id}`),
  getLatestEditorNameByContentId: (contentId) => api.get(`/latest-editor-name/${contentId}`),
  approveContent: (id) => api.put(`/content/approve/${id}`),
  rejectContent: (id) => api.put(`/content/reject/${id}`),
  getPermissions: () => api.get('/permissions'),
  getPermissionsByRole: () => api.get('/role_permissions'),
  getRolePermissions: (role_id) => api.get(`/roles/${role_id}/permissions`),
  addPermissionToRole: (role_id, permission_id) => api.post(`/roles/${role_id}/permissions/add/${permission_id}`),
  removePermissionFromRole: (role_id, permission_id) => api.delete(`/roles/${role_id}/permissions/delete/${permission_id}`),
  getContentViewCount: (id) => api.get(`/content/viewcount/${id}`),
  resubmitRejectedContent: (id) => api.put(`/content/resubmit/${id}`),
  incrementViewCount: (id) => api.put(`/content/increment-viewcount/${id}`),
};

export default api;