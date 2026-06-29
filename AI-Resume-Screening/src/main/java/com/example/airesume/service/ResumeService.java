package com.example.airesume.service;

import com.example.airesume.dto.PredictionResponse;
import com.example.airesume.entity.Resume;
import com.example.airesume.entity.User;
import com.example.airesume.repository.ResumeRepository;
import com.example.airesume.util.FileUtil;
import com.example.airesume.util.TextExtractor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import java.io.File;
import java.io.IOException;
import java.util.List;

@Service
public class ResumeService {

    @Autowired
    private ResumeRepository resumeRepository;

    @Autowired
    private FileUtil fileUtil;

    @Autowired
    private TextExtractor textExtractor;

    @Autowired
    private PythonApiService pythonApiService;

    public Resume processAndSaveResume(MultipartFile file, User user) throws IOException {
        // 1. Save uploaded file to local filesystem
        File savedFile = fileUtil.saveFile(file);
        
        // 2. Extract text content
        String rawText = "";
        try {
            rawText = textExtractor.extract(savedFile);
        } catch (Exception e) {
            rawText = "Failed to extract text: " + e.getMessage();
        }

        // 3. Request category prediction from ML service
        PredictionResponse prediction = pythonApiService.predictCategory(rawText);

        // 4. Save to Database
        Resume resume = new Resume();
        resume.setUser(user);
        resume.setFileName(file.getOriginalFilename());
        resume.setFilePath(savedFile.getAbsolutePath());
        resume.setRawText(rawText);
        resume.setPredictedCategory(prediction.getCategory());
        resume.setConfidenceScore(prediction.getConfidence());

        return resumeRepository.save(resume);
    }

    public List<Resume> getResumesForUser(User user) {
        if ("ADMIN".equals(user.getRole())) {
            return resumeRepository.findAllByOrderByUploadedAtDesc();
        } else {
            return resumeRepository.findByUserOrderByUploadedAtDesc(user);
        }
    }

    public Resume getResumeById(Long id) {
        return resumeRepository.findById(id).orElse(null);
    }
}
