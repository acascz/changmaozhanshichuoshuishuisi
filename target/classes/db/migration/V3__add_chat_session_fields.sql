-- 添加 ChatSession 表缺失的字段
-- 日期：2026-04-04

-- 如果 chat_session 表不存在 unread_count 字段，则添加
ALTER TABLE chat_session 
ADD COLUMN IF NOT EXISTS unread_count INT DEFAULT 0 COMMENT '未读消息数' AFTER last_message_time;

-- 如果 chat_session 表不存在 session_type 字段，则添加
ALTER TABLE chat_session 
ADD COLUMN IF NOT EXISTS session_type TINYINT NOT NULL COMMENT '会话类型：1-私信，2-客服，3-群聊，4-AI' AFTER session_id;

-- 如果 chat_session 表不存在 is_top 字段，则添加
ALTER TABLE chat_session 
ADD COLUMN IF NOT EXISTS is_top TINYINT DEFAULT 0 COMMENT '是否置顶：0-否，1-是' AFTER is_deleted;

-- 如果 chat_session 表不存在 is_disturb 字段，则添加
ALTER TABLE chat_session 
ADD COLUMN IF NOT EXISTS is_disturb TINYINT DEFAULT 0 COMMENT '是否免打扰：0-否，1-是' AFTER is_top;

-- 添加索引
CREATE INDEX IF NOT EXISTS idx_user_id ON chat_session(user_id);
CREATE INDEX IF NOT EXISTS idx_session_type ON chat_session(session_type);
CREATE INDEX IF NOT EXISTS idx_ai_id ON chat_session(ai_id);
