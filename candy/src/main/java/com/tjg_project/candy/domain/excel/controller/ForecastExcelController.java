package com.tjg_project.candy.domain.excel.controller;

import com.tjg_project.candy.domain.excel.dto.ForecastExcelRow;
import lombok.Data;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xddf.usermodel.chart.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.*;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.ByteArrayOutputStream;
import java.util.List;

@RestController
@RequestMapping("/excel")
public class ForecastExcelController {

    @PostMapping("/forecast")
    public ResponseEntity<byte[]> exportForecast(@RequestBody ForecastRequest req) throws Exception {

        XSSFWorkbook workbook = new XSSFWorkbook();
        XSSFSheet sheet = workbook.createSheet("Forecast");

        // ---------- Header ----------
        Row header = sheet.createRow(0);
        header.createCell(0).setCellValue("날짜");
        header.createCell(1).setCellValue("예측값");

        // ---------- Rows ----------
        int rowNum = 1;
        for (ForecastExcelRow r : req.getRows()) {
            Row row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue(r.getDate());
            row.createCell(1).setCellValue(r.getValue());
        }

        // ---------- Chart ----------
        XSSFDrawing draw = sheet.createDrawingPatriarch();
        XSSFClientAnchor anchor = new XSSFClientAnchor(
                0, 0, 0, 0,
                3, 1, 15, 20
        );

        XSSFChart chart = draw.createChart(anchor);
        chart.setTitleText("판매량 예측");

        XDDFCategoryAxis bottomAxis = chart.createCategoryAxis(AxisPosition.BOTTOM);
        XDDFValueAxis leftAxis = chart.createValueAxis(AxisPosition.LEFT);

        var dates = XDDFDataSourcesFactory.fromStringCellRange(sheet,
                new CellRangeAddress(1, rowNum - 1, 0, 0));
        var values = XDDFDataSourcesFactory.fromNumericCellRange(sheet,
                new CellRangeAddress(1, rowNum - 1, 1, 1));

        XDDFLineChartData data = (XDDFLineChartData) chart.createData(
                ChartTypes.LINE, bottomAxis, leftAxis);

        var series = (XDDFLineChartData.Series) data.addSeries(dates, values);
        series.setTitle("예측값", null);
        chart.plot(data);

        // ---------- Output ----------
        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        workbook.write(bos);
        workbook.close();

        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=forecast.xlsx")
                .body(bos.toByteArray());
    }

    @Data
    static class ForecastRequest {
        private List<ForecastExcelRow> rows;
    }

}
