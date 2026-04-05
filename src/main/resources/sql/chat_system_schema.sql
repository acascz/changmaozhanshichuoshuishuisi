-- 聊天系统基础表结构
-- 版本：v1.0
-- 日期：2026-04-04

-- 1. 聊天会话表
CREATE TABLE IF NOT EXISTS chat_session (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键 ID',
    session_id VARCHAR(64) UNIQUE NOT NULL COMMENT '会话 ID',
    session_type TINYINT NOT NULL COMMENT '会话类型：1-私信，2-客服，3-群聊，4-AI',
    session_name VARCHAR(100) COMMENT '会话名称',
    session_avatar VARCHAR(255) COMMENT '会话头像',
    
    -- 成员信息
    member1_id BIGINT COMMENT '成员 1 用户 ID（私信）',
    member2_id BIGINT COMMENT '成员 2 用户 ID（私信）',
    group_id BIGINT COMMENT '群 ID（群聊）',
    ai_id BIGINT COMMENT 'AI ID（AI 会话）',
    
    -- 状态
    is_deleted TINYINT DEFAULT 0 COMMENT '是否删除：0-否，1-是',
    is_top TINYINT DEFAULT 0 COMMENT '是否置顶：0-否，1-是',
    is_disturb TINYINT DEFAULT 0 COMMENT '是否免打扰：0-否，1-是',
    
    -- 最后消息
    last_message_id BIGINT COMMENT '最后一条消息 ID',
    last_message_content VARCHAR(500) COMMENT '最后一条消息内容',
    last_message_time DATETIME COMMENT '最后一条消息时间',
    unread_count INT DEFAULT 0 COMMENT '未读消息数',
    
    -- 元数据
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    
    INDEX idx_member1 (member1_id),
    INDEX idx_member2 (member2_id),
    INDEX idx_group (group_id),
    INDEX idx_last_message_time (last_message_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='聊天会话表';

-- 2. 会话成员表
CREATE TABLE IF NOT EXISTS chat_session_member (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键 ID',
    session_id VARCHAR(64) NOT NULL COMMENT '会话 ID',
    user_id BIGINT NOT NULL COMMENT '用户 ID',
    role TINYINT DEFAULT 1 COMMENT '角色：1-普通成员，2-管理员，3-群主',
    session_key TEXT COMMENT '会话密钥（加密后的群组密钥）',
    join_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '加入时间',
    quit_time DATETIME COMMENT '退出时间',
    is_deleted TINYINT DEFAULT 0 COMMENT '是否删除：0-否，1-是',
    
    UNIQUE KEY uk_session_user (session_id, user_id),
    INDEX idx_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='会话成员表';

-- 3. 消息表
CREATE TABLE IF NOT EXISTS chat_message (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键 ID',
    message_id VARCHAR(64) UNIQUE NOT NULL COMMENT '消息 ID',
    session_id VARCHAR(64) NOT NULL COMMENT '会话 ID',
    sender_id BIGINT NOT NULL COMMENT '发送者 ID',
    receiver_id BIGINT COMMENT '接收者 ID（私信）',
    
    -- 消息内容（加密存储）
    message_type TINYINT NOT NULL COMMENT '消息类型：1-文字，2-图片，3-语音，4-视频，5-表情，6-电商卡片',
    content TEXT NOT NULL COMMENT '加密后的消息内容',
    content_hash VARCHAR(64) COMMENT '消息内容哈希（完整性校验）',
    
    -- 加密相关
    encrypted_key TEXT COMMENT '加密的会话密钥（接收方公钥加密）',
    signature TEXT COMMENT '数字签名（发送方私钥签名）',
    public_key_fingerprint VARCHAR(64) COMMENT '公钥指纹（验证用）',
    
    -- 状态
    status TINYINT DEFAULT 1 COMMENT '状态：1-正常，2-撤回，3-删除',
    is_read TINYINT DEFAULT 0 COMMENT '是否已读：0-否，1-是',
    read_time DATETIME COMMENT '已读时间',
    
    -- 元数据
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    
    INDEX idx_session (session_id),
    INDEX idx_sender (sender_id),
    INDEX idx_receiver (receiver_id),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='消息表';

-- 4. AI 上下文表
CREATE TABLE IF NOT EXISTS ai_context (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键 ID',
    session_id VARCHAR(64) NOT NULL COMMENT 'AI 会话 ID',
    user_id BIGINT NOT NULL COMMENT '用户 ID',
    context_key VARCHAR(100) COMMENT '上下文键',
    context_value TEXT COMMENT '上下文值（加密存储）',
    expire_time DATETIME COMMENT '过期时间',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    
    UNIQUE KEY uk_session_key (session_id, context_key),
    INDEX idx_user (user_id),
    INDEX idx_expire (expire_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='AI 上下文表';

-- 5. AI 访问日志表
CREATE TABLE IF NOT EXISTS ai_access_log (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键 ID',
    user_id BIGINT NOT NULL COMMENT '用户 ID',
    session_id VARCHAR(64) NOT NULL COMMENT 'AI 会话 ID',
    question TEXT COMMENT '用户问题',
    intent VARCHAR(50) COMMENT '意图类型',
    accessed_data TEXT COMMENT '访问的数据（JSON）',
    response TEXT COMMENT 'AI 回答',
    risk_level TINYINT DEFAULT 1 COMMENT '风险等级：1-低，2-中，3-高',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    
    INDEX idx_user (user_id),
    INDEX idx_session (session_id),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='AI 访问日志表';

-- 6. 用户密钥表
CREATE TABLE IF NOT EXISTS user_key (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键 ID',
    user_id BIGINT UNIQUE NOT NULL COMMENT '用户 ID',
    public_key TEXT NOT NULL COMMENT 'RSA 公钥',
    private_key TEXT NOT NULL COMMENT 'RSA 私钥（加密存储）',
    public_key_fingerprint VARCHAR(64) COMMENT '公钥指纹',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    
    INDEX idx_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户密钥表';

-- 7. 群聊表
CREATE TABLE IF NOT EXISTS chat_group (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键 ID',
    group_id VARCHAR(64) UNIQUE NOT NULL COMMENT '群 ID',
    group_name VARCHAR(100) NOT NULL COMMENT '群名称',
    group_avatar VARCHAR(255) COMMENT '群头像',
    owner_id BIGINT NOT NULL COMMENT '群主用户 ID',
    max_count INT DEFAULT 500 COMMENT '最大成员数',
    current_count INT DEFAULT 0 COMMENT '当前成员数',
    group_key VARCHAR(255) COMMENT '群聊密钥（加密存储）',
    notice TEXT COMMENT '群公告',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    
    INDEX idx_owner (owner_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='群聊表';

-- 8. 用户浏览记录表（新增）
CREATE TABLE IF NOT EXISTS user_browse_history (
    id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '主键 ID',
    user_id BIGINT NOT NULL COMMENT '用户 ID',
    product_id BIGINT NOT NULL COMMENT '商品 ID',
    product_name VARCHAR(255) COMMENT '商品名称',
    product_price DECIMAL(10,2) COMMENT '商品价格',
    product_image VARCHAR(255) COMMENT '商品主图',
    category_id BIGINT COMMENT '商品分类 ID',
    category_name VARCHAR(100) COMMENT '商品分类名称',
    browse_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '浏览时间',
    source VARCHAR(50) COMMENT '来源：search-搜索，recommend-推荐，link-外链',
    
    UNIQUE KEY uk_user_product (user_id, product_id, browse_time),
    INDEX idx_user_time (user_id, browse_time),
    INDEX idx_product (product_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户浏览记录表';

-- 插入默认数据：官方 AI 会话
INSERT INTO chat_session (session_id, session_type, session_name, session_avatar, ai_id, is_top, is_disturb)
VALUES ('official_ai', 4, 'AI 智能助手', '/avatar/ai.png', 0, 1, 0)
ON DUPLICATE KEY UPDATE session_name = VALUES(session_name);
