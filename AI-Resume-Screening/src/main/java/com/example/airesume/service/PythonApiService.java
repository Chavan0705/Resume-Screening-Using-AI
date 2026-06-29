package com.example.airesume.service;

import com.example.airesume.dto.PredictionRequest;
import com.example.airesume.dto.PredictionResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class PythonApiService {

    @Autowired
    private RestTemplate restTemplate;

    @Value("${python.api.url}")
    private String pythonApiUrl;

    public PredictionResponse predictCategory(String rawText) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        PredictionRequest requestDto = new PredictionRequest(rawText);
        HttpEntity<PredictionRequest> requestEntity = new HttpEntity<>(requestDto, headers);

        try {
            return restTemplate.postForObject(pythonApiUrl, requestEntity, PredictionResponse.class);
        } catch (Exception e) {
            PredictionResponse fallback = new PredictionResponse("Unknown", 0.0);
            fallback.setError("Could not connect to Python ML API server: " + e.getMessage());
            return fallback;
        }
    }
}
