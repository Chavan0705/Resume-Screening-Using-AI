package com.example.airesume.dto;

public class PredictionResponse {
    private String category;
    private double confidence;
    private String error;

    public PredictionResponse() {}

    public PredictionResponse(String category, double confidence) {
        this.category = category;
        this.confidence = confidence;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public double getConfidence() {
        return confidence;
    }

    public void setConfidence(double confidence) {
        this.confidence = confidence;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }
}
