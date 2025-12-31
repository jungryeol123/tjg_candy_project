package com.tjg_project.candy.domain.analytics.controller;


import com.tjg_project.candy.domain.analytics.dto.DailySalesDto;
import com.tjg_project.candy.domain.analytics.dto.ForecastResponseDto;
import com.tjg_project.candy.domain.analytics.service.ForecastServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/forecast")
public class ForecastController {

    private final ForecastServiceImpl forecastServiceImpl;

    @GetMapping("/sales/{ppk}")
    public List<DailySalesDto> getSales(@PathVariable Long ppk) {
        return forecastServiceImpl.getDailySales(ppk);
    }

    @GetMapping("/predict/{ppk}")
    public ForecastResponseDto runForecast(@PathVariable Long ppk) {
        try {
            return forecastServiceImpl.runForecast(ppk);
        } catch (Exception e) {
            throw new RuntimeException("AI 예측 실패: " + e.getMessage());
        }
    }
}