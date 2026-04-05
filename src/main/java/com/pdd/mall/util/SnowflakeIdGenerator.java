package com.pdd.mall.util;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

/**
 * 雪花算法分布式 ID 生成器
 * 
 * 设计原理：
 * - 48 位时间戳（毫秒级，可用 69 年）
 * - 10 位机器 ID（支持 1024 台机器）
 * - 12 位序列号（每毫秒可生成 4096 个 ID）
 * 
 * 高可用特性：
 * - 无中心节点，每台机器独立生成
 * - 不依赖数据库/Redis，性能极高
 * - ID 有序递增，有利于数据库索引
 */
@Slf4j
@Component
public class SnowflakeIdGenerator {

    /**
     * 起始时间戳（2024-01-01 00:00:00 UTC）
     */
    private static final long START_TIMESTAMP = 1704067200000L;

    /**
     * 机器 ID 位数（5 位数据中心 ID + 5 位机器 ID = 10 位）
     */
    private static final long MACHINE_BIT = 10L;

    /**
     * 序列号位数
     */
    private static final long SEQUENCE_BIT = 12L;

    /**
     * 机器 ID 最大值
     */
    private static final long MAX_MACHINE_NUM = ~(-1L << MACHINE_BIT);

    /**
     * 序列号最大值
     */
    private static final long MAX_SEQUENCE = ~(-1L << SEQUENCE_BIT);

    /**
     * 机器 ID 左移位数
     */
    private static final long MACHINE_SHIFT = SEQUENCE_BIT;

    /**
     * 时间戳左移位数
     */
    private static final long TIMESTAMP_SHIFT = SEQUENCE_BIT + MACHINE_BIT;

    /**
     * 机器 ID（实际部署时应该从配置文件读取）
     */
    private long machineId;

    /**
     * 序列号
     */
    private long sequence;

    /**
     * 上次生成 ID 的时间戳
     */
    private long lastTimestamp = -1L;

    /**
     * 构造函数（默认机器 ID 为 0）
     */
    public SnowflakeIdGenerator() {
        this(0L);
    }

    /**
     * 构造函数
     * @param machineId 机器 ID（0-1023）
     */
    public SnowflakeIdGenerator(long machineId) {
        if (machineId < 0 || machineId > MAX_MACHINE_NUM) {
            log.error("机器 ID 必须在 0 到 {} 之间", MAX_MACHINE_NUM);
            throw new IllegalArgumentException("Machine ID must be between 0 and " + MAX_MACHINE_NUM);
        }
        this.machineId = machineId;
        this.sequence = 0L;
    }

    /**
     * 生成下一个 ID（线程安全）
     */
    public synchronized Long nextId() {
        long timestamp = System.currentTimeMillis();

        // 时钟回拨处理
        if (timestamp < lastTimestamp) {
            log.error("时钟回拨！拒绝生成 ID，直到时间恢复正常。上次时间戳：{}, 当前时间戳：{}", 
                    lastTimestamp, timestamp);
            throw new RuntimeException("Clock moved backwards. Refusing to generate id for " 
                    + (lastTimestamp - timestamp) + " milliseconds");
        }

        // 如果是同一毫秒，序列号递增
        if (timestamp == lastTimestamp) {
            sequence = (sequence + 1) & MAX_SEQUENCE;
            // 如果序列号溢出，等待下一毫秒
            if (sequence == 0) {
                timestamp = tilNextMillis(lastTimestamp);
            }
        } else {
            // 不同毫秒，序列号重置为 0
            sequence = 0L;
        }

        lastTimestamp = timestamp;

        // 组合 ID：时间戳 + 机器 ID + 序列号
        return ((timestamp - START_TIMESTAMP) << TIMESTAMP_SHIFT)
                | (machineId << MACHINE_SHIFT)
                | sequence;
    }

    /**
     * 生成指定数量的 ID
     */
    public synchronized Long[] nextIds(int count) {
        Long[] ids = new Long[count];
        for (int i = 0; i < count; i++) {
            ids[i] = nextId();
        }
        return ids;
    }

    /**
     * 等待下一毫秒
     */
    private long tilNextMillis(long lastTimestamp) {
        long timestamp = System.currentTimeMillis();
        while (timestamp <= lastTimestamp) {
            timestamp = System.currentTimeMillis();
        }
        return timestamp;
    }

    /**
     * 解析 ID 包含的时间戳
     */
    public long parseTimestamp(long id) {
        return ((id >> TIMESTAMP_SHIFT) + START_TIMESTAMP);
    }

    /**
     * 解析 ID 包含的机器 ID
     */
    public long parseMachineId(long id) {
        return (id >> MACHINE_SHIFT) & ~(-1L << MACHINE_BIT);
    }

    /**
     * 解析 ID 包含的序列号
     */
    public long parseSequence(long id) {
        return id & MAX_SEQUENCE;
    }
}
