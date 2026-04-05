// 用户认证和会话管理模块
class AuthManager {
    constructor() {
        this.currentUser = null;
        this.token = null;
        this.apiBaseUrl = '/api';
        this.init();
    }

    // 初始化认证状态
    init() {
        this.token = localStorage.getItem('auth_token');
        const userData = localStorage.getItem('user_data');
        if (userData) {
            this.currentUser = JSON.parse(userData);
        }
    }

    // 检查用户是否已登录
    isAuthenticated() {
        return !!this.token && !!this.currentUser;
    }

    // 用户登录
    async login(username, password) {
        try {
            const response = await this.apiCall('/auth/login', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ username, password })
            });

            if (response.success) {
                this.token = response.data.token;
                this.currentUser = response.data.user;
                
                // 保存到本地存储
                localStorage.setItem('auth_token', this.token);
                localStorage.setItem('user_data', JSON.stringify(this.currentUser));
                
                return { success: true, user: this.currentUser };
            } else {
                return { success: false, message: response.message };
            }
        } catch (error) {
            console.error('登录失败:', error);
            return { success: false, message: '网络错误，请稍后再试' };
        }
    }

    // 用户登出
    logout() {
        this.token = null;
        this.currentUser = null;
        localStorage.removeItem('auth_token');
        localStorage.removeItem('user_data');
        
        // 跳转到登录页面
        window.location.href = '/login.html';
    }

    // 获取当前用户ID
    getCurrentUserId() {
        return this.currentUser ? this.currentUser.id : null;
    }

    // 获取当前用户信息
    getCurrentUser() {
        return this.currentUser;
    }

    // 统一的API调用方法
    async apiCall(endpoint, options = {}) {
        const url = `${this.apiBaseUrl}${endpoint}`;
        
        // 添加认证头
        const headers = {
            'Content-Type': 'application/json',
            ...options.headers
        };
        
        if (this.token) {
            headers['Authorization'] = `Bearer ${this.token}`;
        }

        try {
            const response = await fetch(url, {
                ...options,
                headers
            });

            // 检查认证状态
            if (response.status === 401) {
                this.logout();
                throw new Error('认证已过期，请重新登录');
            }

            const data = await response.json();
            return data;
        } catch (error) {
            console.error('API调用失败:', error);
            throw error;
        }
    }

    // 检查会话有效性
    async checkSession() {
        if (!this.isAuthenticated()) {
            return false;
        }

        try {
            const response = await this.apiCall('/auth/verify');
            return response.success;
        } catch (error) {
            return false;
        }
    }

    // 刷新token
    async refreshToken() {
        try {
            const response = await this.apiCall('/auth/refresh', {
                method: 'POST'
            });

            if (response.success) {
                this.token = response.data.token;
                localStorage.setItem('auth_token', this.token);
                return true;
            }
        } catch (error) {
            console.error('Token刷新失败:', error);
        }
        return false;
    }
}

// 创建全局认证管理器实例
window.authManager = new AuthManager();