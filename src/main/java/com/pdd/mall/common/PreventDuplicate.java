package com.pdd.mall.common;

import java.lang.annotation.*;

/**
 * 防止重复提交注解
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface PreventDuplicate {
    
    /**
     * 防止重复提交的时间间隔（毫秒），默认 1 秒
     */
    long interval() default 1000;
    
    /**
     * 消息提示
     */
    String message() default "操作过于频繁，请稍后再试";
}
