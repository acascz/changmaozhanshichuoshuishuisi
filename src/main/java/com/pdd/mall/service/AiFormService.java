package com.pdd.mall.service;

import com.pdd.mall.entity.AiForm;
import com.pdd.mall.mapper.AiFormMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AiFormService {

    @Autowired
    private AiFormMapper aiFormMapper;

    public List<AiForm> getFormsByUserId(Long userId) {
        return aiFormMapper.findByUserId(userId);
    }

    public AiForm getFormById(Long id) {
        return aiFormMapper.findById(id);
    }

    public AiForm submitForm(AiForm aiForm) {
        aiFormMapper.insert(aiForm);
        return aiForm;
    }
}
