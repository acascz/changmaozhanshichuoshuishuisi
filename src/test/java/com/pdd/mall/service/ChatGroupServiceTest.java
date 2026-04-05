package com.pdd.mall.service;

import com.pdd.mall.entity.ChatGroup;
import com.pdd.mall.mapper.ChatGroupMapper;
import com.pdd.mall.mapper.ChatSessionMapper;
import com.pdd.mall.mapper.ChatSessionMemberMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

/**
 * 群聊服务测试类
 */
@ExtendWith(MockitoExtension.class)
class ChatGroupServiceTest {
    
    @Mock
    private ChatGroupMapper chatGroupMapper;
    
    @Mock
    private ChatSessionMapper chatSessionMapper;
    
    @Mock
    private ChatSessionMemberMapper chatSessionMemberMapper;
    
    @InjectMocks
    private ChatGroupService chatGroupService;
    
    private Long testCreatorId;
    private String testGroupName;
    private List<Long> testMemberIds;
    
    @BeforeEach
    void setUp() {
        testCreatorId = 10001L;
        testGroupName = "测试群聊";
        testMemberIds = new ArrayList<>();
        testMemberIds.add(10002L);
        testMemberIds.add(10003L);
    }
    
    @Test
    void testCreateGroup_Success() {
        // 准备测试数据
        ChatGroup mockGroup = new ChatGroup();
        mockGroup.setGroupId(1L);
        mockGroup.setGroupNo("G20260404001");
        mockGroup.setGroupName(testGroupName);
        mockGroup.setCreatorId(testCreatorId);
        mockGroup.setMaxMembers(500);
        mockGroup.setMemberCount(3);
        mockGroup.setStatus(1);
        
        // 配置 Mock 行为
        when(chatGroupMapper.insert(any(ChatGroup.class))).thenReturn(1);
        when(chatSessionMapper.insert(any())).thenReturn(1);
        when(chatSessionMemberMapper.batchInsert(anyList())).thenReturn(3);
        
        // 执行测试
        ChatGroup result = chatGroupService.createGroup(testCreatorId, testGroupName, null, testMemberIds);
        
        // 验证结果
        assertNotNull(result);
        assertEquals("G20260404001", result.getGroupNo());
        assertEquals(testCreatorId, result.getCreatorId());
        assertEquals(3, result.getMemberCount());
        
        // 验证方法调用
        verify(chatGroupMapper, times(1)).insert(any(ChatGroup.class));
        verify(chatSessionMapper, times(1)).insert(any());
        verify(chatSessionMemberMapper, times(1)).batchInsert(anyList());
    }
    
    @Test
    void testJoinGroup_Success() {
        Long groupId = 1L;
        Long userId = 10004L;
        
        ChatGroup mockGroup = new ChatGroup();
        mockGroup.setGroupId(groupId);
        mockGroup.setMemberCount(3);
        mockGroup.setMaxMembers(500);
        
        when(chatGroupMapper.findById(groupId)).thenReturn(mockGroup);
        when(chatSessionMemberMapper.exists("group_1", userId)).thenReturn(false);
        when(chatSessionMemberMapper.insert(any())).thenReturn(1);
        when(chatGroupMapper.updateMemberCount(groupId, 4)).thenReturn(1);
        
        assertDoesNotThrow(() -> chatGroupService.joinGroup(groupId, userId));
        
        verify(chatGroupMapper, times(1)).findById(groupId);
        verify(chatSessionMemberMapper, times(1)).insert(any());
        verify(chatGroupMapper, times(1)).updateMemberCount(groupId, 4);
    }
    
    @Test
    void testJoinGroup_NotFound() {
        Long groupId = 999L;
        Long userId = 10004L;
        
        when(chatGroupMapper.findById(groupId)).thenReturn(null);
        
        RuntimeException exception = assertThrows(RuntimeException.class, () -> {
            chatGroupService.joinGroup(groupId, userId);
        });
        
        assertTrue(exception.getMessage().contains("群聊不存在"));
    }
    
    @Test
    void testJoinGroup_AlreadyMember() {
        Long groupId = 1L;
        Long userId = 10002L;
        
        ChatGroup mockGroup = new ChatGroup();
        mockGroup.setGroupId(groupId);
        
        when(chatGroupMapper.findById(groupId)).thenReturn(mockGroup);
        when(chatSessionMemberMapper.exists("group_1", userId)).thenReturn(true);
        
        RuntimeException exception = assertThrows(RuntimeException.class, () -> {
            chatGroupService.joinGroup(groupId, userId);
        });
        
        assertTrue(exception.getMessage().contains("已在群聊中"));
    }
    
    @Test
    void testLeaveGroup_Success() {
        Long groupId = 1L;
        Long userId = 10002L;
        
        ChatGroup mockGroup = new ChatGroup();
        mockGroup.setGroupId(groupId);
        mockGroup.setCreatorId(10001L); // 创建者不是当前用户
        mockGroup.setMemberCount(3);
        
        when(chatGroupMapper.findById(groupId)).thenReturn(mockGroup);
        when(chatSessionMemberMapper.delete("group_1", userId)).thenReturn(1);
        when(chatGroupMapper.updateMemberCount(groupId, 2)).thenReturn(1);
        
        assertDoesNotThrow(() -> chatGroupService.leaveGroup(groupId, userId));
        
        verify(chatSessionMemberMapper, times(1)).delete("group_1", userId);
        verify(chatGroupMapper, times(1)).updateMemberCount(groupId, 2);
    }
    
    @Test
    void testLeaveGroup_CreatorCannotLeave() {
        Long groupId = 1L;
        Long userId = 10001L; // 群主
        
        ChatGroup mockGroup = new ChatGroup();
        mockGroup.setGroupId(groupId);
        mockGroup.setCreatorId(userId);
        
        when(chatGroupMapper.findById(groupId)).thenReturn(mockGroup);
        
        RuntimeException exception = assertThrows(RuntimeException.class, () -> {
            chatGroupService.leaveGroup(groupId, userId);
        });
        
        assertTrue(exception.getMessage().contains("群主不能退出"));
    }
    
    @Test
    void testDismissGroup_Success() {
        Long groupId = 1L;
        Long operatorId = 10001L; // 群主
        
        ChatGroup mockGroup = new ChatGroup();
        mockGroup.setGroupId(groupId);
        mockGroup.setCreatorId(operatorId);
        
        when(chatGroupMapper.findById(groupId)).thenReturn(mockGroup);
        when(chatSessionMemberMapper.deleteBySessionId("group_1")).thenReturn(1);
        when(chatSessionMapper.delete("group_1")).thenReturn(1);
        when(chatGroupMapper.delete(groupId)).thenReturn(1);
        
        assertDoesNotThrow(() -> chatGroupService.dismissGroup(groupId, operatorId));
        
        verify(chatGroupMapper, times(1)).delete(groupId);
        verify(chatSessionMapper, times(1)).delete("group_1");
        verify(chatSessionMemberMapper, times(1)).deleteBySessionId("group_1");
    }
    
    @Test
    void testDismissGroup_NotCreator() {
        Long groupId = 1L;
        Long operatorId = 10002L; // 不是群主
        
        ChatGroup mockGroup = new ChatGroup();
        mockGroup.setGroupId(groupId);
        mockGroup.setCreatorId(10001L);
        
        when(chatGroupMapper.findById(groupId)).thenReturn(mockGroup);
        
        RuntimeException exception = assertThrows(RuntimeException.class, () -> {
            chatGroupService.dismissGroup(groupId, operatorId);
        });
        
        assertTrue(exception.getMessage().contains("只有群主可以解散"));
    }
}
