package com.pdd.mall.controller;

import com.pdd.mall.common.Result;
import com.pdd.mall.entity.AiForm;
import com.pdd.mall.service.AiFormService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/ai-form")
@CrossOrigin
public class AiFormController {

    @Autowired
    private AiFormService aiFormService;

    @GetMapping("/list/{userId}")
    public Result<List<AiForm>> getForms(@PathVariable Long userId) {
        return Result.success(aiFormService.getFormsByUserId(userId));
    }

    @GetMapping("/detail/{id}")
    public Result<AiForm> getFormDetail(@PathVariable Long id) {
        AiForm form = aiFormService.getFormById(id);
        if (form != null) {
            return Result.success(form);
        }
        return Result.error("表单不存在");
    }

    @PostMapping("/submit")
    public Result<AiForm> submitForm(@RequestBody AiForm aiForm) {
        return Result.success(aiFormService.submitForm(aiForm));
    }
}
