// 聊天API服务模块
class ChatApiService {
    constructor() {
        this.authManager = window.authManager;
    }

    // 验证用户认证状态
    validateAuth() {
        if (!this.authManager.isAuthenticated()) {
            throw new Error('用户未登录');
        }
    }

    // 获取好友列表
    async getFriendList() {
        this.validateAuth();
        
        try {
            const response = await this.authManager.apiCall('/friend/list');
            if (response.success) {
                return response.data;
            } else {
                throw new Error(response.message || '获取好友列表失败');
            }
        } catch (error) {
            console.error('获取好友列表失败:', error);
            throw error;
        }
    }

    // 添加好友
    async addFriend(friendId, remark = '') {
        this.validateAuth();
        
        // 输入验证
        if (!friendId || friendId.trim() === '') {
            throw new Error('好友ID不能为空');
        }

        if (friendId === this.authManager.getCurrentUserId()) {
            throw new Error('不能添加自己为好友');
        }

        try {
            const response = await this.authManager.apiCall('/friend/add', {
                method: 'POST',
                body: JSON.stringify({
                    friendId: friendId.trim(),
                    remark: remark.trim()
                })
            });

            return response;
        } catch (error) {
            console.error('添加好友失败:', error);
            throw error;
        }
    }

    // 搜索用户
    async searchUser(keyword) {
        this.validateAuth();
        
        if (!keyword || keyword.trim() === '') {
            throw new Error('搜索关键词不能为空');
        }

        try {
            const response = await this.authManager.apiCall(`/user/search?keyword=${encodeURIComponent(keyword.trim())}`);
            if (response.success) {
                return response.data;
            } else {
                throw new Error(response.message || '搜索用户失败');
            }
        } catch (error) {
            console.error('搜索用户失败:', error);
            throw error;
        }
    }

    // 获取用户信息
    async getUserInfo(userId = null) {
        this.validateAuth();
        
        const targetUserId = userId || this.authManager.getCurrentUserId();
        
        try {
            const response = await this.authManager.apiCall(`/user/info/${targetUserId}`);
            if (response.success) {
                return response.data;
            } else {
                throw new Error(response.message || '获取用户信息失败');
            }
        } catch (error) {
            console.error('获取用户信息失败:', error);
            throw error;
        }
    }

    // 创建群聊
    async createGroup(groupName, memberIds = []) {
        this.validateAuth();
        
        if (!groupName || groupName.trim() === '') {
            throw new Error('群聊名称不能为空');
        }

        if (groupName.trim().length > 20) {
            throw new Error('群聊名称不能超过20个字符');
        }

        try {
            const response = await this.authManager.apiCall('/chat/group/create', {
                method: 'POST',
                body: JSON.stringify({
                    groupName: groupName.trim(),
                    memberIds: memberIds
                })
            });

            return response;
        } catch (error) {
            console.error('创建群聊失败:', error);
            throw error;
        }
    }

    // 获取群聊列表
    async getGroupList() {
        this.validateAuth();
        
        try {
            const response = await this.authManager.apiCall('/chat/group/list');
            if (response.success) {
                return response.data;
            } else {
                throw new Error(response.message || '获取群聊列表失败');
            }
        } catch (error) {
            console.error('获取群聊列表失败:', error);
            throw error;
        }
    }

    // 邀请好友加入群聊
    async inviteToGroup(groupId, friendIds) {
        this.validateAuth();
        
        if (!groupId) {
            throw new Error('群聊ID不能为空');
        }

        if (!friendIds || friendIds.length === 0) {
            throw new Error('请选择要邀请的好友');
        }

        try {
            const response = await this.authManager.apiCall('/chat/group/invite', {
                method: 'POST',
                body: JSON.stringify({
                    groupId: groupId,
                    friendIds: friendIds
                })
            });

            return response;
        } catch (error) {
            console.error('邀请好友加入群聊失败:', error);
            throw error;
        }
    }

    // 发送消息
    async sendMessage(chatId, content, messageType = 'text') {
        this.validateAuth();
        
        if (!content || content.trim() === '') {
            throw new Error('消息内容不能为空');
        }

        if (content.trim().length > 1000) {
            throw new Error('消息内容不能超过1000个字符');
        }

        try {
            const response = await this.authManager.apiCall('/chat/message/send', {
                method: 'POST',
                body: JSON.stringify({
                    chatId: chatId,
                    content: content.trim(),
                    messageType: messageType
                })
            });

            return response;
        } catch (error) {
            console.error('发送消息失败:', error);
            throw error;
        }
    }

    // 获取聊天记录
    async getChatHistory(chatId, page = 1, pageSize = 20) {
        this.validateAuth();
        
        try {
            const response = await this.authManager.apiCall(`/chat/message/history?chatId=${chatId}&page=${page}&pageSize=${pageSize}`);
            if (response.success) {
                return response.data;
            } else {
                throw new Error(response.message || '获取聊天记录失败');
            }
        } catch (error) {
            console.error('获取聊天记录失败:', error);
            throw error;
        }
    }

    // 处理好友请求
    async handleFriendRequest(requestId, action) {
        this.validateAuth();
        
        if (!['accept', 'reject'].includes(action)) {
            throw new Error('无效的操作类型');
        }

        try {
            const response = await this.authManager.apiCall('/friend/request/handle', {
                method: 'POST',
                body: JSON.stringify({
                    requestId: requestId,
                    action: action
                })
            });

            return response;
        } catch (error) {
            console.error('处理好友请求失败:', error);
            throw error;
        }
    }

    // 获取好友请求列表
    async getFriendRequests() {
        this.validateAuth();
        
        try {
            const response = await this.authManager.apiCall('/friend/request/list');
            if (response.success) {
                return response.data;
            } else {
                throw new Error(response.message || '获取好友请求列表失败');
            }
        } catch (error) {
            console.error('获取好友请求列表失败:', error);
            throw error;
        }
    }
}

// 创建全局聊天API服务实例
window.chatApiService = new ChatApiService();