package com.pdd.mall.service;

import com.pdd.mall.entity.MultimediaMessage;
import com.pdd.mall.mapper.MultimediaMessageMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 多媒体消息服务
 */
@Service
@Slf4j
public class MultimediaMessageService {

    @Autowired
    private MultimediaMessageMapper multimediaMessageMapper;

    /**
     * 发送图片消息
     */
    @Transactional
    public MultimediaMessage sendImageMessage(Long senderId, Long receiverId, String sessionId,
                                              String imageUrl, String thumbnailUrl,
                                              Integer width, Integer height,
                                              Long fileSize, String format) {
        log.info("发送图片消息：senderId={}, receiverId={}, sessionId={}", senderId, receiverId, sessionId);
        
        MultimediaMessage message = new MultimediaMessage();
        message.setMessageId(java.util.UUID.randomUUID().toString());
        message.setSessionId(sessionId);
        message.setSenderId(senderId);
        message.setReceiverId(receiverId);
        message.setMessageType(2); // 图片消息类型
        message.setMediaUrl(imageUrl);
        message.setMediaType("image/" + format);
        message.setThumbnailUrl(thumbnailUrl);
        message.setWidth(width);
        message.setHeight(height);
        message.setFileSize(fileSize);
        message.setFormat(format);
        message.setStatus(1);
        message.setIsRead(0);
        message.setCreateTime(LocalDateTime.now());
        
        multimediaMessageMapper.insert(message);
        return message;
    }

    /**
     * 发送语音消息
     */
    @Transactional
    public MultimediaMessage sendAudioMessage(Long senderId, Long receiverId, String sessionId,
                                              String audioUrl, Long fileSize,
                                              Integer duration, String format) {
        log.info("发送语音消息：senderId={}, receiverId={}, sessionId={}", senderId, receiverId, sessionId);
        
        MultimediaMessage message = new MultimediaMessage();
        message.setMessageId(java.util.UUID.randomUUID().toString());
        message.setSessionId(sessionId);
        message.setSenderId(senderId);
        message.setReceiverId(receiverId);
        message.setMessageType(3); // 语音消息类型
        message.setMediaUrl(audioUrl);
        message.setMediaType("audio/" + format);
        message.setFileSize(fileSize);
        message.setDuration(duration);
        message.setFormat(format);
        message.setStatus(1);
        message.setIsRead(0);
        message.setCreateTime(LocalDateTime.now());
        
        multimediaMessageMapper.insert(message);
        return message;
    }

    /**
     * 发送视频消息
     */
    @Transactional
    public MultimediaMessage sendVideoMessage(Long senderId, Long receiverId, String sessionId,
                                              String videoUrl, String thumbnailUrl,
                                              Long fileSize, Integer duration,
                                              Integer width, Integer height, String format) {
        log.info("发送视频消息：senderId={}, receiverId={}, sessionId={}", senderId, receiverId, sessionId);
        
        MultimediaMessage message = new MultimediaMessage();
        message.setMessageId(java.util.UUID.randomUUID().toString());
        message.setSessionId(sessionId);
        message.setSenderId(senderId);
        message.setReceiverId(receiverId);
        message.setMessageType(4); // 视频消息类型
        message.setMediaUrl(videoUrl);
        message.setMediaType("video/" + format);
        message.setThumbnailUrl(thumbnailUrl);
        message.setFileSize(fileSize);
        message.setDuration(duration);
        message.setWidth(width);
        message.setHeight(height);
        message.setFormat(format);
        message.setStatus(1);
        message.setIsRead(0);
        message.setCreateTime(LocalDateTime.now());
        
        multimediaMessageMapper.insert(message);
        return message;
    }

    /**
     * 发送表情消息
     */
    @Transactional
    public MultimediaMessage sendEmojiMessage(Long senderId, Long receiverId, String sessionId,
                                              String emojiCode, String emojiName,
                                              String emojiPackageId, String imageUrl) {
        log.info("发送表情消息：senderId={}, receiverId={}, sessionId={}", senderId, receiverId, sessionId);
        
        MultimediaMessage message = new MultimediaMessage();
        message.setMessageId(java.util.UUID.randomUUID().toString());
        message.setSessionId(sessionId);
        message.setSenderId(senderId);
        message.setReceiverId(receiverId);
        message.setMessageType(5); // 表情消息类型
        message.setMediaUrl(imageUrl);
        message.setMediaType("image/gif");
        message.setEmojiCode(emojiCode);
        message.setEmojiName(emojiName);
        message.setEmojiPackageId(emojiPackageId);
        message.setStatus(1);
        message.setIsRead(0);
        message.setCreateTime(LocalDateTime.now());
        
        multimediaMessageMapper.insert(message);
        return message;
    }

    /**
     * 发送电商卡片消息
     */
    @Transactional
    public MultimediaMessage sendProductCardMessage(Long senderId, Long receiverId, String sessionId,
                                                    Long productId, String productName,
                                                    String productImage, Double price,
                                                    Double originalPrice, String productUrl,
                                                    String couponAmount, String activityInfo) {
        log.info("发送电商卡片：senderId={}, receiverId={}, productId={}", senderId, receiverId, productId);
        
        MultimediaMessage message = new MultimediaMessage();
        message.setMessageId(java.util.UUID.randomUUID().toString());
        message.setSessionId(sessionId);
        message.setSenderId(senderId);
        message.setReceiverId(receiverId);
        message.setMessageType(6); // 电商卡片类型
        message.setProductId(productId);
        message.setProductName(productName);
        message.setProductImage(productImage);
        message.setPrice(price);
        message.setOriginalPrice(originalPrice);
        message.setProductUrl(productUrl);
        message.setCouponAmount(couponAmount);
        message.setActivityInfo(activityInfo);
        message.setStatus(1);
        message.setIsRead(0);
        message.setCreateTime(LocalDateTime.now());
        
        multimediaMessageMapper.insert(message);
        return message;
    }

    /**
     * 获取消息列表
     */
    public List<MultimediaMessage> getMessages(String sessionId, int page, int size) {
        log.info("获取多媒体消息：sessionId={}, page={}, size={}", sessionId, page, size);
        int offset = (page - 1) * size;
        return multimediaMessageMapper.selectBySessionId(sessionId, offset, size);
    }

    /**
     * 撤回消息
     */
    @Transactional
    public boolean recallMessage(String messageId) {
        log.info("撤回消息：messageId={}", messageId);
        int rows = multimediaMessageMapper.updateStatus(messageId, 2);
        return rows > 0;
    }

    /**
     * 删除消息
     */
    @Transactional
    public boolean deleteMessage(String messageId) {
        log.info("删除消息：messageId={}", messageId);
        int rows = multimediaMessageMapper.updateStatus(messageId, 3);
        return rows > 0;
    }

    /**
     * 标记消息已读
     */
    @Transactional
    public boolean markMessageAsRead(String messageId) {
        log.info("标记消息已读：messageId={}", messageId);
        int rows = multimediaMessageMapper.updateReadStatus(messageId, 1);
        return rows > 0;
    }
}
