/**
 * 聊天系统完整前端 - 六个阶段全功能
 * 包含：基础聊天、群聊、客服、AI 助手、消息加密、性能优化
 */

// ==================== 全局变量 ====================
let currentChatId = null;
let currentChatType = null;
let currentTab = 'all';
let ws = null; // WebSocket 连接
let userInfo = null; // 当前用户信息

// ==================== 初始化 ====================
document.addEventListener('DOMContentLoaded', function() {
    console.log('聊天系统初始化...');
    initUserInfo();
    initWebSocket();
    loadChatList();
    initEmojiPanel();
    initInputListener();
    initEventListeners();
});

// 初始化用户信息
function initUserInfo() {
    // 从本地存储或 session 获取用户信息
    userInfo = {
        userId: localStorage.getItem('userId') || 1,
        userName: localStorage.getItem('userName') || '用户',
        avatar: localStorage.getItem('avatar') || null
    };
    
    document.getElementById('currentUserName').textContent = userInfo.userName;
    document.getElementById('currentUserAvatar').textContent = userInfo.userName.charAt(0);
}

// 初始化 WebSocket 连接
function initWebSocket() {
    const wsUrl = `ws://localhost:8080/ws/chat?userId=${userInfo.userId}`;
    
    try {
        ws = new WebSocket(wsUrl);
        
        ws.onopen = function() {
            console.log('WebSocket 连接成功');
            showSystemMessage('已连接到聊天服务器');
        };
        
        ws.onmessage = function(event) {
            const message = JSON.parse(event.data);
            handleIncomingMessage(message);
        };
        
        ws.onerror = function(error) {
            console.error('WebSocket 错误:', error);
        };
        
        ws.onclose = function() {
            console.log('WebSocket 连接关闭');
            // 3 秒后尝试重连
            setTimeout(initWebSocket, 3000);
        };
    } catch (error) {
        console.error('WebSocket 初始化失败:', error);
    }
}

// 处理接收到的消息
function handleIncomingMessage(message) {
    console.log('收到新消息:', message);
    
    // 如果当前正在和发送者聊天，直接添加到消息列表
    if (currentChatId && message.sessionId === currentChatId) {
        const messageList = document.getElementById('messageList');
        const emptyState = messageList.querySelector('.empty-state');
        if (emptyState) {
            messageList.innerHTML = '';
        }
        
        const msgElement = createMessageItem({
            content: message.content,
            senderName: message.senderName,
            sendTime: new Date().toISOString(),
            isSelf: false,
            status: 0
        });
        
        messageList.appendChild(msgElement);
        messageList.scrollTop = messageList.scrollHeight;
    }
    
    // 更新会话列表
    loadChatList();
    
    // 显示通知
    if (!document.hasFocus() || currentChatId !== message.sessionId) {
        showNotification(message);
    }
}

// ==================== 会话列表 ====================
// 加载会话列表
async function loadChatList() {
    try {
        const response = await fetch(`/api/chat/sessions?userId=${userInfo.userId}`);
        const data = await response.json();
        
        if (data.code === 200) {
            displayChatList(data.data);
        } else {
            showError('加载会话列表失败：' + data.message);
        }
    } catch (error) {
        console.error('加载会话列表错误:', error);
        showError('网络错误，请检查服务器连接');
    }
}

// 显示会话列表
function displayChatList(sessions) {
    const chatList = document.getElementById('chatList');
    chatList.innerHTML = '';
    
    if (!sessions || sessions.length === 0) {
        chatList.innerHTML = `
            <div class="empty-state">
                <div class="empty-icon">📭</div>
                <div class="empty-text">暂无会话</div>
                <button class="empty-btn" onclick="showAddFriendModal()">添加好友</button>
            </div>
        `;
        return;
    }
    
    // 根据当前标签过滤
    const filteredSessions = filterSessionsByTab(sessions, currentTab);
    
    if (filteredSessions.length === 0) {
        chatList.innerHTML = `
            <div class="empty-state">
                <div class="empty-icon">📭</div>
                <div class="empty-text">暂无${getTabName(currentTab)}会话</div>
            </div>
        `;
        return;
    }
    
    filteredSessions.forEach(session => {
        const chatItem = createChatItem(session);
        chatList.appendChild(chatItem);
    });
}

// 根据标签过滤会话
function filterSessionsByTab(sessions, tab) {
    if (tab === 'all') return sessions;
    
    return sessions.filter(session => {
        switch(tab) {
            case 'friend':
                return session.type === '好友' || (session.sessionId && session.sessionId.startsWith('friend_'));
            case 'group':
                return session.type === '群聊' || (session.sessionId && session.sessionId.startsWith('group_'));
            case 'service':
                return session.type === '客服';
            case 'ai':
                return session.type === 'AI';
            default:
                return true;
        }
    });
}

// 获取标签名称
function getTabName(tab) {
    const names = {
        'all': '全部',
        'friend': '好友',
        'group': '群聊',
        'service': '客服',
        'ai': 'AI'
    };
    return names[tab] || '';
}

// 创建会话项
function createChatItem(session) {
    const div = document.createElement('div');
    div.className = 'chat-item';
    div.dataset.sessionId = session.sessionId;
    div.dataset.sessionType = session.type;
    
    const isStar = session.isStar ? '<span class="star-icon">★</span>' : '';
    const unreadBadge = session.unreadCount && session.unreadCount > 0 
        ? `<span class="unread-badge">${session.unreadCount}</span>` 
        : '';
    
    div.innerHTML = `
        <div class="chat-item-avatar">${session.avatar || session.name.charAt(0)}</div>
        <div class="chat-item-info">
            <div class="chat-item-header">
                <span class="chat-item-name">${escapeHtml(session.name)}</span>
                <span class="chat-item-time">${formatSessionTime(session.lastMessageTime)}</span>
            </div>
            <div class="chat-item-message">${escapeHtml(session.lastMessage || '暂无消息')}</div>
            <div class="chat-item-footer">
                ${unreadBadge}
                ${isStar}
            </div>
        </div>
    `;
    
    div.onclick = () => switchToChat(session);
    
    return div;
}

// 格式化会话时间
function formatSessionTime(timeStr) {
    if (!timeStr) return '';
    
    const date = new Date(timeStr);
    const now = new Date();
    const diff = now - date;
    
    if (diff < 60000) return '刚刚';
    if (diff < 3600000) return Math.floor(diff / 60000) + '分钟前';
    if (diff < 86400000) return Math.floor(diff / 3600000) + '小时前';
    if (diff < 172800000) return '昨天';
    
    return date.toLocaleDateString('zh-CN', { month: 'short', day: 'numeric' });
}

// ==================== 聊天窗口 ====================
// 切换到聊天
function switchToChat(session) {
    currentChatId = session.sessionId;
    currentChatType = session.type;
    
    // 更新选中状态
    document.querySelectorAll('.chat-item').forEach(item => {
        item.classList.remove('active');
    });
    const activeItem = document.querySelector(`[data-session-id="${session.sessionId}"]`);
    if (activeItem) {
        activeItem.classList.add('active');
    }
    
    // 显示聊天窗口
    document.getElementById('noChatSelected').style.display = 'none';
    document.getElementById('chatWindow').style.display = 'flex';
    
    // 更新聊天头部信息
    document.getElementById('chatAvatar').textContent = session.avatar || session.name.charAt(0);
    document.getElementById('chatName').textContent = session.name;
    document.getElementById('chatStatus').textContent = getSessionStatusText(session.type);
    
    // 加载消息历史
    loadMessageHistory(session.sessionId);
    
    // 标记为已读
    markMessagesAsRead(session.sessionId);
}

// 获取会话状态文本
function getSessionStatusText(type) {
    switch(type) {
        case '好友': return '在线';
        case '群聊': return '群聊';
        case '客服': return '客服在线';
        case 'AI': return 'AI 智能助手';
        default: return '';
    }
}

// 加载消息历史
async function loadMessageHistory(sessionId) {
    const messageList = document.getElementById('messageList');
    messageList.innerHTML = '<div class="loading-state"><div class="loading-spinner"></div><div>加载消息中...</div></div>';
    
    try {
        const response = await fetch(`/api/chat/messages?sessionId=${sessionId}&limit=50`);
        const data = await response.json();
        
        if (data.code === 200) {
            displayMessages(data.data || []);
        } else {
            showError('加载消息失败：' + data.message);
        }
    } catch (error) {
        console.error('加载消息历史错误:', error);
        showError('网络错误');
    }
}

// 显示消息列表
function displayMessages(messages) {
    const messageList = document.getElementById('messageList');
    messageList.innerHTML = '';
    
    if (!messages || messages.length === 0) {
        messageList.innerHTML = `
            <div class="empty-state">
                <div class="empty-icon">💭</div>
                <div class="empty-text">暂无消息，开始聊天吧</div>
            </div>
        `;
        return;
    }
    
    messages.forEach(msg => {
        const messageItem = createMessageItem(msg);
        messageList.appendChild(messageItem);
    });
    
    // 滚动到底部
    messageList.scrollTop = messageList.scrollHeight;
}

// 创建消息项
function createMessageItem(msg) {
    const div = document.createElement('div');
    div.className = `message-item ${msg.isSelf ? 'self' : ''}`;
    
    const time = formatMessageTime(msg.sendTime);
    const status = msg.isSelf ? (msg.status === 1 ? '✓已读' : '✓已发送') : '';
    
    div.innerHTML = `
        <div class="message-avatar">${msg.senderName ? msg.senderName.charAt(0) : '我'}</div>
        <div class="message-content">
            <div class="message-bubble">
                <div class="message-text">${escapeHtml(msg.content)}</div>
            </div>
            <div class="message-meta">
                <span class="message-time">${time}</span>
                <span class="message-status">${status}</span>
            </div>
        </div>
    `;
    
    return div;
}

// 格式化消息时间
function formatMessageTime(timeStr) {
    if (!timeStr) return '';
    const date = new Date(timeStr);
    const now = new Date();
    const diff = now - date;
    
    if (diff < 60000) return '刚刚';
    if (diff < 3600000) return Math.floor(diff / 60000) + '分钟前';
    if (diff < 86400000) return Math.floor(diff / 3600000) + '小时前';
    if (diff < 172800000) return '昨天';
    
    return date.toLocaleTimeString('zh-CN', { hour: '2-digit', minute: '2-digit' });
}

// 发送消息
async function sendMessage() {
    const input = document.getElementById('messageInput');
    const content = input.value.trim();
    
    if (!content) {
        showWarning('请输入消息内容');
        return;
    }
    
    if (!currentChatId) {
        showWarning('请先选择一个聊天');
        return;
    }
    
    try {
        const response = await fetch('/api/chat/send', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                sessionId: currentChatId,
                sessionType: getSessionTypeCode(currentChatType),
                receiverId: getReceiverIdFromSessionId(currentChatId),
                content: content,
                msgType: 1 // 文本消息
            })
        });
        
        const data = await response.json();
        
        if (data.code === 200) {
            // 清空输入框
            input.value = '';
            updateCharCount();
            
            // 添加新消息到界面
            const newMessage = data.data;
            newMessage.isSelf = true;
            newMessage.senderName = userInfo.userName;
            newMessage.sendTime = new Date().toISOString();
            newMessage.status = 0; // 已发送
            
            const messageList = document.getElementById('messageList');
            const emptyState = messageList.querySelector('.empty-state');
            if (emptyState) {
                messageList.innerHTML = '';
            }
            
            messageList.appendChild(createMessageItem(newMessage));
            messageList.scrollTop = messageList.scrollHeight;
            
            // 通过 WebSocket 发送
            if (ws && ws.readyState === WebSocket.OPEN) {
                ws.send(JSON.stringify({
                    type: 'CHAT',
                    sessionId: currentChatId,
                    content: content
                }));
            }
            
            // 更新会话列表
            loadChatList();
        } else {
            showError('发送失败：' + data.message);
        }
    } catch (error) {
        console.error('发送消息错误:', error);
        showError('发送失败，请重试');
    }
}

// 获取会话类型代码
function getSessionTypeCode(typeName) {
    const typeMap = {
        '好友': 1,
        '客服': 2,
        '群聊': 3,
        'AI': 4
    };
    return typeMap[typeName] || 1;
}

// 从 sessionId 提取 receiverId
function getReceiverIdFromSessionId(sessionId) {
    if (sessionId.startsWith('friend_')) {
        return parseInt(sessionId.replace('friend_', ''));
    }
    if (sessionId.startsWith('group_')) {
        return sessionId.replace('group_', '');
    }
    return sessionId;
}

// 标记消息为已读
async function markMessagesAsRead(sessionId) {
    try {
        await fetch('/api/chat/markRead', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                sessionId: sessionId,
                userId: userInfo.userId
            })
        });
    } catch (error) {
        console.error('标记已读错误:', error);
    }
}

// ==================== 标签页切换 ====================
// 切换标签页
function switchTab(tab) {
    currentTab = tab;
    
    // 更新按钮状态
    document.querySelectorAll('.tab-btn').forEach(btn => {
        btn.classList.remove('active');
    });
    const activeBtn = document.querySelector(`[data-tab="${tab}"]`);
    if (activeBtn) {
        activeBtn.classList.add('active');
    }
    
    // 重新加载会话列表
    loadChatList();
}

// ==================== 搜索功能 ====================
// 搜索聊天
function searchChats() {
    const keyword = document.getElementById('searchInput').value.trim().toLowerCase();
    
    if (!keyword) {
        loadChatList();
        return;
    }
    
    const chatItems = document.querySelectorAll('.chat-item');
    let hasResults = false;
    
    chatItems.forEach(item => {
        const name = item.querySelector('.chat-item-name')?.textContent.toLowerCase() || '';
        const message = item.querySelector('.chat-item-message')?.textContent.toLowerCase() || '';
        
        if (name.includes(keyword) || message.includes(keyword)) {
            item.style.display = 'flex';
            hasResults = true;
        } else {
            item.style.display = 'none';
        }
    });
    
    if (!hasResults) {
        document.getElementById('chatList').innerHTML = `
            <div class="empty-state">
                <div class="empty-icon">🔍</div>
                <div class="empty-text">未找到匹配的会话</div>
            </div>
        `;
    }
}

// ==================== 表情面板 ====================
// 初始化表情面板
function initEmojiPanel() {
    const emojis = [
        '😀', '😂', '😍', '🥰', '😊', '😎', '🤔', '😴', 
        '😋', '🤗', '😭', '😡', '👍', '👎', '❤️', '💔', 
        '🎉', '🔥', '⭐', '✨', '👏', '🙏', '💪', '🎵',
        '🍔', '🍕', '🍺', '🎁', '💰', '📱', '💻', '🎮'
    ];
    
    const panel = document.getElementById('emojiPanel');
    panel.innerHTML = '';
    
    emojis.forEach(emoji => {
        const div = document.createElement('div');
        div.className = 'emoji-item';
        div.textContent = emoji;
        div.onclick = () => insertEmoji(emoji);
        panel.appendChild(div);
    });
}

// 显示表情面板
function showEmojiPanel() {
    const panel = document.getElementById('emojiPanel');
    const morePanel = document.getElementById('morePanel');
    morePanel.style.display = 'none';
    
    if (panel.style.display === 'none' || panel.style.display === '') {
        panel.style.display = 'grid';
    } else {
        panel.style.display = 'none';
    }
}

// 插入表情
function insertEmoji(emoji) {
    const input = document.getElementById('messageInput');
    const startPos = input.selectionStart;
    const endPos = input.selectionEnd;
    
    input.value = input.value.substring(0, startPos) + emoji + input.value.substring(endPos);
    input.selectionStart = input.selectionEnd = startPos + emoji.length;
    input.focus();
    
    updateCharCount();
    document.getElementById('emojiPanel').style.display = 'none';
}

// ==================== 输入框功能 ====================
// 初始化输入监听
function initInputListener() {
    const input = document.getElementById('messageInput');
    input.addEventListener('input', updateCharCount);
}

// 更新字符计数
function updateCharCount() {
    const input = document.getElementById('messageInput');
    const count = input.value.length;
    const countElement = document.getElementById('charCount');
    countElement.textContent = `${count}/500`;
    
    if (count > 450) {
        countElement.style.color = '#f44336';
    } else {
        countElement.style.color = '#999';
    }
}

// 处理键盘事件
function handleKeyDown(event) {
    const enterToSend = document.getElementById('enterToSend').checked;
    
    if (event.key === 'Enter') {
        if (event.ctrlKey || !enterToSend) {
            // Ctrl+Enter 或 Enter 发送（当选项启用时）
            event.preventDefault();
            sendMessage();
        }
    }
}

// ==================== 群聊功能 ====================
// 显示创建群聊弹窗
function showCreateGroupModal() {
    document.getElementById('createGroupModal').classList.add('show');
    loadFriendsForGroup();
}

// 加载好友列表（用于创建群聊）
async function loadFriendsForGroup() {
    try {
        const response = await fetch(`/api/friend/list?userId=${userInfo.userId}`);
        const data = await response.json();
        
        if (data.code === 200) {
            displayFriendsForGroup(data.data || []);
        }
    } catch (error) {
        console.error('加载好友列表错误:', error);
    }
}

// 显示好友列表（用于创建群聊）
function displayFriendsForGroup(friends) {
    const container = document.getElementById('friendListForGroup');
    container.innerHTML = '';
    
    if (friends.length === 0) {
        container.innerHTML = '<div style="padding: 20px; text-align: center; color: #999;">暂无好友，先添加好友吧</div>';
        return;
    }
    
    friends.forEach(friend => {
        const div = document.createElement('div');
        div.className = 'friend-select-item';
        div.innerHTML = `
            <input type="checkbox" value="${friend.friendId}" id="friend_${friend.friendId}">
            <label for="friend_${friend.friendId}">
                <div class="friend-select-avatar">${friend.friendName ? friend.friendName.charAt(0) : '友'}</div>
                <div class="friend-select-name">${friend.friendRemark || friend.friendName}</div>
            </label>
        `;
        container.appendChild(div);
    });
}

// 创建群聊
async function createGroupChat() {
    const groupName = document.getElementById('groupNameInput').value.trim();
    if (!groupName) {
        showWarning('请输入群聊名称');
        return;
    }
    
    const checkboxes = document.querySelectorAll('#friendListForGroup input[type="checkbox"]:checked');
    if (checkboxes.length === 0) {
        showWarning('请至少选择一位成员');
        return;
    }
    
    const memberIds = Array.from(checkboxes).map(cb => parseInt(cb.value));
    
    try {
        const response = await fetch('/api/group/create', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                name: groupName,
                creatorId: userInfo.userId,
                memberIds: memberIds
            })
        });
        
        const data = await response.json();
        
        if (data.code === 200) {
            showSuccess('群聊创建成功');
            closeModal('createGroupModal');
            loadChatList();
        } else {
            showError('创建失败：' + data.message);
        }
    } catch (error) {
        console.error('创建群聊错误:', error);
        showError('创建失败，请重试');
    }
}

// ==================== 好友功能 ====================
// 显示添加好友弹窗
function showAddFriendModal() {
    document.getElementById('addFriendModal').classList.add('show');
}

// 发送好友请求
async function sendFriendRequest() {
    const friendId = document.getElementById('friendIdInput').value.trim();
    const message = document.getElementById('addFriendMessage').value.trim();
    
    if (!friendId) {
        showWarning('请输入好友 ID');
        return;
    }
    
    try {
        const response = await fetch('/api/friend/request', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                senderId: userInfo.userId,
                receiverId: parseInt(friendId),
                message: message
            })
        });
        
        const data = await response.json();
        
        if (data.code === 200) {
            showSuccess('好友请求已发送');
            closeModal('addFriendModal');
        } else {
            showError('发送失败：' + data.message);
        }
    } catch (error) {
        console.error('发送好友请求错误:', error);
        showError('发送失败，请重试');
    }
}

// ==================== 客服功能 ====================
// 显示联系客服弹窗
function showContactServiceModal() {
    document.getElementById('contactServiceModal').classList.add('show');
}

// 联系客服
async function contactService() {
    const serviceType = document.getElementById('serviceType').value;
    const message = document.getElementById('serviceMessage').value.trim();
    
    if (!message) {
        showWarning('请描述您的问题');
        return;
    }
    
    try {
        const response = await fetch('/api/service/request', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                userId: userInfo.userId,
                serviceType: serviceType,
                message: message
            })
        });
        
        const data = await response.json();
        
        if (data.code === 200) {
            showSuccess('客服请求已发送，正在为您分配客服...');
            closeModal('contactServiceModal');
            setTimeout(() => loadChatList(), 1000);
        } else {
            showError('请求失败：' + data.message);
        }
    } catch (error) {
        console.error('联系客服错误:', error);
        showError('请求失败，请重试');
    }
}

// ==================== AI 聊天 ====================
// 切换 AI 聊天
function toggleAIChat() {
    const aiSession = {
        sessionId: 'ai_assistant',
        name: 'AI 智能助手',
        type: 'AI',
        avatar: '🤖',
        lastMessage: '点击开始对话',
        lastMessageTime: new Date().toISOString()
    };
    
    switchToChat(aiSession);
}

// ==================== 工具函数 ====================
// 关闭弹窗
function closeModal(modalId) {
    document.getElementById(modalId).classList.remove('show');
}

// HTML 转义
function escapeHtml(text) {
    const div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
}

// 显示系统消息
function showSystemMessage(message) {
    const messageList = document.getElementById('messageList');
    const div = document.createElement('div');
    div.className = 'system-message';
    div.textContent = message;
    div.style.cssText = 'text-align: center; color: #999; font-size: 13px; padding: 10px;';
    messageList.appendChild(div);
}

// 显示错误提示
function showError(message) {
    alert('❌ ' + message);
}

// 显示警告提示
function showWarning(message) {
    alert('⚠️ ' + message);
}

// 显示成功提示
function showSuccess(message) {
    alert('✅ ' + message);
}

// 显示通知
function showNotification(message) {
    if ('Notification' in window && Notification.permission === 'granted') {
        new Notification('新消息', {
            body: `${message.senderName}: ${message.content}`,
            icon: '/favicon.ico'
        });
    }
}

// 初始化事件监听器
function initEventListeners() {
    // 点击其他地方关闭面板
    document.addEventListener('click', function(e) {
        const emojiPanel = document.getElementById('emojiPanel');
        const morePanel = document.getElementById('morePanel');
        
        if (!e.target.closest('.emoji-panel') && !e.target.closest('.tool-btn')) {
            emojiPanel.style.display = 'none';
        }
        
        if (!e.target.closest('.more-panel') && !e.target.closest('.tool-btn')) {
            morePanel.style.display = 'none';
        }
    });
}

// 显示更多选项
function showMoreOptions() {
    const panel = document.getElementById('morePanel');
    const emojiPanel = document.getElementById('emojiPanel');
    emojiPanel.style.display = 'none';
    
    if (panel.style.display === 'none' || panel.style.display === '') {
        panel.style.display = 'block';
    } else {
        panel.style.display = 'none';
    }
}

// 其他功能函数（待实现）
function selectImage() { showInfo('图片选择功能开发中...'); }
function selectFile() { showInfo('文件选择功能开发中...'); }
function showChatSettings() { showInfo('聊天设置功能开发中...'); }
function toggleChatInfo() { 
    const panel = document.getElementById('infoPanel');
    panel.style.display = panel.style.display === 'none' ? 'flex' : 'none';
    if (panel.style.display === 'flex') {
        loadChatInfo();
    }
}
function showSearchMessagePanel() { showInfo('搜索消息功能开发中...'); }
function sendLocation() { showInfo('位置功能开发中...'); }
function sendContact() { showInfo('名片功能开发中...'); }
function sendRedPacket() { showInfo('红包功能开发中...'); }
function sendTransfer() { showInfo('转账功能开发中...'); }
function recordVoice() { showInfo('语音功能开发中...'); }
function screenShare() { showInfo('屏幕共享功能开发中...'); }

function showInfo(message) {
    alert('ℹ️ ' + message);
}

// 加载聊天详情
function loadChatInfo() {
    const content = document.getElementById('infoContent');
    content.innerHTML = `
        <div class="chat-info-detail">
            <div class="info-avatar">
                <div class="avatar-large">${document.getElementById('chatAvatar').textContent}</div>
                <h3>${document.getElementById('chatName').textContent}</h3>
                <p>${document.getElementById('chatStatus').textContent}</p>
            </div>
            
            <div class="info-section">
                <div class="info-item">
                    <span>消息免打扰</span>
                    <input type="checkbox">
                </div>
                <div class="info-item">
                    <span>置顶聊天</span>
                    <input type="checkbox">
                </div>
                <div class="info-item">
                    <span>聊天记录</span>
                    <button onclick="showInfo('聊天记录功能开发中...')">查看</button>
                </div>
                ${currentChatType === '群聊' ? `
                <div class="info-item">
                    <span>群管理</span>
                    <button onclick="showGroupManage()">管理</button>
                </div>
                ` : ''}
            </div>
        </div>
    `;
}

// 显示群管理
function showGroupManage() {
    document.getElementById('groupManageModal').classList.add('show');
    switchManageTab('members');
}

// 切换管理标签
function switchManageTab(tab) {
    const content = document.getElementById('manageContent');
    
    switch(tab) {
        case 'members':
            content.innerHTML = '<div style="padding: 20px;">群成员管理功能开发中...</div>';
            break;
        case 'announcement':
            content.innerHTML = '<div style="padding: 20px;">群公告管理功能开发中...</div>';
            break;
        case 'settings':
            content.innerHTML = '<div style="padding: 20px;">群设置功能开发中...</div>';
            break;
    }
}
