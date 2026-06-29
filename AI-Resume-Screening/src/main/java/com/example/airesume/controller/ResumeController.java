package com.example.airesume.controller;

import com.example.airesume.entity.Resume;
import com.example.airesume.entity.User;
import com.example.airesume.service.ResumeService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import java.util.List;

@Controller
public class ResumeController {

    @Autowired
    private ResumeService resumeService;

    @GetMapping("/upload")
    public String showUploadForm(HttpSession session) {
        if (session.getAttribute("currentUser") == null) {
            return "redirect:/login";
        }
        return "upload";
    }

    @PostMapping("/upload")
    public String handleFileUpload(
            @RequestParam("file") MultipartFile file,
            HttpSession session,
            Model model) {
        
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/login";
        }

        if (file.isEmpty()) {
            model.addAttribute("error", "Please select a file to upload.");
            return "upload";
        }

        String fileName = file.getOriginalFilename().toLowerCase();
        if (!fileName.endsWith(".pdf") && !fileName.endsWith(".docx") && !fileName.endsWith(".txt")) {
            model.addAttribute("error", "Only PDF, DOCX, and TXT files are supported.");
            return "upload";
        }

        try {
            Resume resume = resumeService.processAndSaveResume(file, currentUser);
            return "redirect:/result?id=" + resume.getId();
        } catch (Exception e) {
            model.addAttribute("error", "Error processing resume: " + e.getMessage());
            return "upload";
        }
    }

    @GetMapping("/result")
    public String showResult(
            @RequestParam("id") Long id,
            HttpSession session,
            Model model) {
        
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/login";
        }

        Resume resume = resumeService.getResumeById(id);
        if (resume == null) {
            model.addAttribute("error", "Resume record not found.");
            return "error";
        }

        // Security check: non-admin users can only view their own resume results
        if (!"ADMIN".equals(currentUser.getRole()) && !resume.getUser().getId().equals(currentUser.getId())) {
            model.addAttribute("error", "Access denied: you are not authorized to view this record.");
            return "error";
        }

        model.addAttribute("resume", resume);
        return "result";
    }

    @GetMapping("/history")
    public String showHistory(HttpSession session, Model model) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/login";
        }

        List<Resume> resumes = resumeService.getResumesForUser(currentUser);
        model.addAttribute("resumes", resumes);
        return "history";
    }
}
