package com.tjg_project.candy.domain.order.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.tjg_project.candy.domain.openai.service.OpenAiService;
import com.tjg_project.candy.domain.order.dto.DailySalesDto;
import com.tjg_project.candy.domain.order.dto.ForecastResponseDto;
import com.tjg_project.candy.domain.order.repository.OrderDetailRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ForecastService {

    private final OrderDetailRepository orderDetailRepository;
    private final OpenAiService openAiService; // ← 네가 만든 RestTemplate 기반 OpenAiService

    public List<DailySalesDto> getDailySales(Long ppk) {
        return orderDetailRepository.findDailySalesByProduct(ppk);
    }

    public ForecastResponseDto runForecast(Long ppk) throws Exception {

        List<DailySalesDto> sales = getDailySales(ppk);

        StringBuilder sb = new StringBuilder();
        sb.append("다음은 최근 일별 판매량 데이터이다. '날짜=수량' 형식:\n");

        for (DailySalesDto s : sales) {
            sb.append(s.getDateTime()).append("=").append(s.getQty()).append("\n");
        }

        sb.append("설명 금지. 코드블록 금지. JSON만 출력.\n");
        sb.append("반드시 아래 형식 그대로 출력해:\n");
        sb.append("{\n" +
                "\"next7Days\": [7개 숫자],\n" +
                "\"next30Days\": [30개 숫자],\n" +
                "\"next12Months\": [12개 숫자],\n" +
                "\"next365Days\": [365개 숫자]\n" +
                "}\n");

        String raw = openAiService.ask(sb.toString());

        ObjectMapper mapper = new ObjectMapper();
        JsonNode root = mapper.readTree(raw);

        List<Integer> next7 = new ArrayList<>();
        root.get("next7Days").forEach(v -> next7.add(v.asInt()));

        List<Integer> next30 = new ArrayList<>();
        root.get("next30Days").forEach(v -> next30.add(v.asInt()));

        List<Integer> next12 = new ArrayList<>();
        root.get("next12Months").forEach(v -> next12.add(v.asInt()));

        List<Integer> next365 = new ArrayList<>();
        root.get("next365Days").forEach(v -> next365.add(v.asInt()));

        return new ForecastResponseDto(next7, next30, next12, next365);
    }

}
