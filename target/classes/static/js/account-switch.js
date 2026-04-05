// 账户切换功能前端实现
// 基于项目现有架构的前端集成

class AccountSwitchManager {
    constructor() {
        this.baseUrl = window.location.origin;
        this.apiBase = '/api/account-switch';
        this.currentUser = null;
        this.boundAccounts = [];
        this.isModalOpen = false;
        
        this.init();
    }
    
    // 初始化
    init() {
        this.loadCurrentUser();
        this.setupEventListeners();
    }
    
    // 加载当前用户信息
    loadCurrentUser() {
        const userInfo = localStorage.getItem('userInfo');
        const token = localStorage.getItem('token');
        
        if (userInfo && token) {
            this.currentUser = JSON.parse(userInfo);
            this.token = token;
        }
    }
    
    // 设置事件监听器
    setupEventListeners() {
        // 切换账户按钮点击事件
        const switchBtn = document.getElementById('switchAccountBtn');
        if (switchBtn) {
            switchBtn.addEventListener('click', () => this.showAccountCardsModal());
        }
        
        // 模态框关闭事件
        document.addEventListener('click', (e) => {
            if (e.target.classList.contains('modal-overlay')) {
                this.closeAllModals();
            }
        });
        
        // ESC键关闭模态框
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape' && this.isModalOpen) {
                this.closeAllModals();
            }
        });
    }
    
    // 显示账户卡片模态框
    async showAccountCardsModal() {
        if (!this.checkLoginStatus()) {
            this.showLoginPrompt();
            return;
        }
        
        try {
            await this.loadBoundAccounts();
            this.renderAccountCards();
            this.showModal('accountCardsModal');
        } catch (error) {
            console.error('加载绑定账户失败:', error);
            this.showError('加载账户列表失败');
        }
    }
    
    // 加载已绑定账户列表
    async loadBoundAccounts() {
        const response = await this.apiRequest('GET', '/bound-accounts');
        
        if (response.code === 200) {
            this.boundAccounts = response.data.accounts || [];
        } else {
            throw new Error(response.msg || '加载失败');
        }
    }
    
    // 渲染账户卡片
    renderAccountCards() {
        const container = document.getElementById('accountCardsList');
        const addBtn = document.getElementById('addAccountCard');
        
        if (!container) return;
        
        container.innerHTML = '';
        
        // 渲染已绑定的账户卡片
        this.boundAccounts.forEach((account, index) => {
            const card = this.createAccountCard(account, index);
            container.appendChild(card);
        });
        
        // 显示/隐藏添加按钮
        if (addBtn) {
            addBtn.style.display = this.boundAccounts.length < 3 ? 'flex' : 'none';
        }
    }
    
    // 创建账户卡片
    createAccountCard(account, index) {
        const card = document.createElement('div');
        card.className = 'account-card';
        card.dataset.userId = account.userId;
        
        const avatarText = account.nickname ? account.nickname.charAt(0) : account.phone.slice(-1);
        
        card.innerHTML = `
            <div class="account-card-avatar">${avatarText}</div>
            <div class="account-card-info">
                <div class="account-card-name">${account.nickname || '用户' + account.phone.slice(-4)}</div>
                <div class="account-card-phone">${account.phone}</div>
            </div>
            <div class="account-card-actions">
                <button class="btn-switch" onclick="accountSwitchManager.switchToAccount(${account.userId})">切换</button>
                <button class="btn-unbind" onclick="accountSwitchManager.unbindAccount(${account.userId}, ${index})">解绑</button>
            </div>
        `;
        
        return card;
    }
    
    // 切换账户
    async switchToAccount(targetUserId) {
        if (!this.checkLoginStatus()) {
            this.showLoginPrompt();
            return;
        }
        
        try {
            const deviceId = this.getDeviceId();
            
            const response = await this.apiRequest('POST', '/switch', {
                targetUserId: targetUserId
            });
            
            if (response.code === 200) {
                // 更新用户信息和会话
                this.updateUserInfo(response.data.userInfo, response.data.sessionId);
                
                this.showSuccess('账户切换成功');
                this.closeAllModals();
                
                // 刷新页面或更新UI
                setTimeout(() => {
                    window.location.reload();
                }, 1000);
                
            } else {
                throw new Error(response.msg || '切换失败');
            }
            
        } catch (error) {
            console.error('切换账户失败:', error);
            this.showError('切换失败: ' + error.message);
        }
    }
    
    // 绑定账户
    async bindAccount(phone, verificationCode) {
        if (!this.checkLoginStatus()) {
            this.showLoginPrompt();
            return;
        }
        
        try {
            const response = await this.apiRequest('POST', '/bind', {
                targetPhone: phone,
                verificationCode: verificationCode
            });
            
            if (response.code === 200) {
                this.showSuccess('账户绑定成功');
                this.closeAllModals();
                
                // 重新加载账户列表
                await this.loadBoundAccounts();
                this.renderAccountCards();
                
            } else {
                throw new Error(response.msg || '绑定失败');
            }
            
        } catch (error) {
            console.error('绑定账户失败:', error);
            this.showError('绑定失败: ' + error.message);
        }
    }
    
    // 解绑账户
    async unbindAccount(targetUserId, index) {
        if (!confirm('确定要解绑这个账户吗？')) {
            return;
        }
        
        if (!this.checkLoginStatus()) {
            this.showLoginPrompt();
            return;
        }
        
        try {
            const response = await this.apiRequest('POST', '/unbind', {
                targetUserId: targetUserId
            });
            
            if (response.code === 200) {
                this.showSuccess('账户解绑成功');
                
                // 从列表中移除
                this.boundAccounts.splice(index, 1);
                this.renderAccountCards();
                
            } else {
                throw new Error(response.msg || '解绑失败');
            }
            
        } catch (error) {
            console.error('解绑账户失败:', error);
            this.showError('解绑失败: ' + error.message);
        }
    }
    
    // 发送验证码
    async sendVerificationCode(phone, type = 'bind_account') {
        try {
            // 这里应该调用验证码发送接口
            // 简化实现：直接返回成功
            this.showSuccess('验证码已发送');
            
            // 实际实现应该调用：
            // const response = await fetch('/api/verification/send', {
            //     method: 'POST',
            //     headers: {
            //         'Content-Type': 'application/json'
            //     },
            //     body: JSON.stringify({
            //         phone: phone,
            //         type: type
            //     })
            // });
            
        } catch (error) {
            console.error('发送验证码失败:', error);
            this.showError('发送验证码失败');
        }
    }
    
    // API请求封装
    async apiRequest(method, endpoint, data = null) {
        const url = this.baseUrl + this.apiBase + endpoint;
        const deviceId = this.getDeviceId();
        
        const options = {
            method: method,
            headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ' + this.token,
                'Device-Id': deviceId,
                'Request-Id': this.generateRequestId()
            }
        };
        
        if (data && method !== 'GET') {
            options.body = JSON.stringify(data);
        }
        
        const response = await fetch(url, options);
        
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        
        return await response.json();
    }
    
    // 工具方法
    getDeviceId() {
        // 生成设备ID（简化实现）
        let deviceId = localStorage.getItem('deviceId');
        if (!deviceId) {
            deviceId = 'device_' + Date.now() + '_' + Math.random().toString(36).substr(2, 9);
            localStorage.setItem('deviceId', deviceId);
        }
        return deviceId;
    }
    
    generateRequestId() {
        return 'req_' + Date.now() + '_' + Math.random().toString(36).substr(2, 9);
    }
    
    checkLoginStatus() {
        const isLoggedIn = localStorage.getItem('isLoggedIn') === 'true';
        const token = localStorage.getItem('token');
        return isLoggedIn && token && this.currentUser;
    }
    
    updateUserInfo(userInfo, sessionId) {
        localStorage.setItem('userInfo', JSON.stringify(userInfo));
        localStorage.setItem('token', sessionId);
        localStorage.setItem('isLoggedIn', 'true');
        
        this.currentUser = userInfo;
        this.token = sessionId;
    }
    
    // 模态框控制
    showModal(modalId) {
        const modal = document.getElementById(modalId);
        if (modal) {
            modal.style.display = 'block';
            this.isModalOpen = true;
        }
    }
    
    closeModal(modalId) {
        const modal = document.getElementById(modalId);
        if (modal) {
            modal.style.display = 'none';
        }
    }
    
    closeAllModals() {
        const modals = document.querySelectorAll('.modal');
        modals.forEach(modal => {
            modal.style.display = 'none';
        });
        this.isModalOpen = false;
    }
    
    // 消息提示
    showSuccess(message) {
        this.showMessage(message, 'success');
    }
    
    showError(message) {
        this.showMessage(message, 'error');
    }
    
    showMessage(message, type = 'info') {
        // 简化实现：使用alert
        alert(message);
        
        // 实际实现应该使用更友好的提示组件
        // this.createToast(message, type);
    }
    
    showLoginPrompt() {
        this.showError('请先登录');
        // 可以跳转到登录页面
        // window.location.href = '/login.html';
    }
}

// 全局实例
let accountSwitchManager;

// 页面加载完成后初始化
document.addEventListener('DOMContentLoaded', function() {
    accountSwitchManager = new AccountSwitchManager();
});

// 全局函数（用于HTML中的onclick事件）
function showAccountCardsModal() {
    if (accountSwitchManager) {
        accountSwitchManager.showAccountCardsModal();
    }
}

function closeAccountCardsModal() {
    if (accountSwitchManager) {
        accountSwitchManager.closeModal('accountCardsModal');
    }
}

function showAddAccountModal() {
    if (accountSwitchManager) {
        accountSwitchManager.showModal('addAccountModal');
    }
}

function closeAddAccountModal() {
    if (accountSwitchManager) {
        accountSwitchManager.closeModal('addAccountModal');
    }
}

async function addAccount() {
    if (!accountSwitchManager) return;
    
    const phone = document.getElementById('targetPhone').value;
    const code = document.getElementById('switchCode').value;
    
    if (!phone || !code) {
        accountSwitchManager.showError('请填写手机号和验证码');
        return;
    }
    
    await accountSwitchManager.bindAccount(phone, code);
}

async function sendSwitchCode() {
    if (!accountSwitchManager) return;
    
    const phone = document.getElementById('targetPhone').value;
    if (!phone) {
        accountSwitchManager.showError('请填写手机号');
        return;
    }
    
    await accountSwitchManager.sendVerificationCode(phone, 'bind_account');
}