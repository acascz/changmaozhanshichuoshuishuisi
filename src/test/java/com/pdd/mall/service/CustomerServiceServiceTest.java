package com.pdd.mall.service;

import com.pdd.mall.entity.ChatSession;
import com.pdd.mall.entity.ChatSessionMember;
import com.pdd.mall.mapper.ChatSessionMapper;
import com.pdd.mall.mapper.ChatSessionMemberMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

/**
 * 客服系统服务测试类
 */
@ExtendWith(MockitoExtension.class)
class CustomerServiceServiceTest {
    
    @Mock
    private ChatSessionMapper chatSessionMapper;
    
    @Mock
    private ChatSessionMemberMapper chatSessionMemberMapper;
    
    @InjectMocks
    private CustomerServiceService customerServiceService;
    
    private Long testUserId;
    private Long testServiceId;
    
    @BeforeEach
    void setUp() {
        testUserId = 10001L;
        testServiceId = 20001L;
    }
    
    @Test
    void testRequestService_Success() {
        String question = "订单怎么查询？";
        
        when(chatSessionMapper.insert(any(ChatSession.class))).thenReturn(1);
        when(chatSessionMemberMapper.insert(any(ChatSessionMember.class))).thenReturn(1);
        
        String sessionId = assertDoesNotThrow(() -> customerServiceService.requestService(testUserId, question));
        
        assertNotNull(sessionId);
        assertTrue(sessionId.startsWith("service_"));
        
        verify(chatSessionMapper, times(1)).insert(any(ChatSession.class));
        verify(chatSessionMemberMapper, times(1)).insert(any(ChatSessionMember.class));
    }
    
    @Test
    void testServiceOnline_Success() {
        assertDoesNotThrow(() -> customerServiceService.serviceOnline(testServiceId));
        
        assertEquals(1, customerServiceService.getOnlineServiceCount());
    }
    
    @Test
    void testServiceOffline_Success() {
        // 先上线
        customerServiceService.serviceOnline(testServiceId);
        assertEquals(1, customerServiceService.getOnlineServiceCount());
        
        // 再下线
        assertDoesNotThrow(() -> customerServiceService.serviceOffline(testServiceId));
        assertEquals(0, customerServiceService.getOnlineServiceCount());
    }
    
    @Test
    void testTransferService_Success() {
        String sessionId = "service_10001";
        Long fromServiceId = 20001L;
        Long toServiceId = 20002L;
        
        // 先让两个客服都上线
        customerServiceService.serviceOnline(fromServiceId);
        customerServiceService.serviceOnline(toServiceId);
        
        when(chatSessionMemberMapper.delete(sessionId, fromServiceId)).thenReturn(1);
        when(chatSessionMemberMapper.insert(any(ChatSessionMember.class))).thenReturn(1);
        
        assertDoesNotThrow(() -> 
            customerServiceService.transferService(sessionId, fromServiceId, toServiceId)
        );
        
        verify(chatSessionMemberMapper, times(1)).delete(sessionId, fromServiceId);
        verify(chatSessionMemberMapper, times(1)).insert(any(ChatSessionMember.class));
    }
    
    @Test
    void testTransferService_ServiceOffline() {
        String sessionId = "service_10001";
        Long fromServiceId = 20001L;
        Long toServiceId = 20002L; // 未上线
        
        customerServiceService.serviceOnline(fromServiceId);
        
        RuntimeException exception = assertThrows(RuntimeException.class, () -> {
            customerServiceService.transferService(sessionId, fromServiceId, toServiceId);
        });
        
        assertTrue(exception.getMessage().contains("目标客服不在线"));
    }
    
    @Test
    void testEndService_Success() {
        String sessionId = "service_10001";
        
        ChatSession mockSession = new ChatSession();
        mockSession.setSessionId(sessionId);
        mockSession.setStatus(1);
        
        when(chatSessionMapper.findBySessionId(sessionId)).thenReturn(mockSession);
        when(chatSessionMapper.update(mockSession)).thenReturn(1);
        
        assertDoesNotThrow(() -> customerServiceService.endService(sessionId, testUserId));
        
        // 验证会话状态被更新为已结束（2）
        assertEquals(2, mockSession.getStatus());
        verify(chatSessionMapper, times(1)).update(mockSession);
    }
    
    @Test
    void testGetQueueSize() {
        // 初始队列大小为 0
        assertEquals(0, customerServiceService.getQueueSize());
        
        // 添加一个请求（不实际执行，只测试方法存在）
        customerServiceService.requestService(testUserId, "test");
        
        // 由于是异步处理，队列大小可能已经变化
        // 这里主要测试方法可以正常调用
        assertDoesNotThrow(() -> customerServiceService.getQueueSize());
    }
    
    @Test
    void testGetOnlineServiceCount() {
        assertEquals(0, customerServiceService.getOnlineServiceCount());
        
        customerServiceService.serviceOnline(testServiceId);
        assertEquals(1, customerServiceService.getOnlineServiceCount());
        
        customerServiceService.serviceOnline(20002L);
        assertEquals(2, customerServiceService.getOnlineServiceCount());
    }
}
