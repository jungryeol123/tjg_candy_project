package com.tjg_project.candy.domain.analytics.service;

import com.tjg_project.candy.domain.analytics.dto.ForecastResponseDto;
import com.tjg_project.candy.domain.analytics.dto.DailySalesDto;

import java.util.List;

public interface ForecastService {
    List<DailySalesDto> getDailySales(Long ppk);
    ForecastResponseDto runForecast(Long ppk) throws Exception;
}
