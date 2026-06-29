package com.example.airesume.controller;

import com.example.airesume.entity.Resume;
import com.example.airesume.entity.User;
import com.example.airesume.service.ResumeService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class DashboardController {

    @Autowired
    private ResumeService resumeService;

    @GetMapping("/")
    public String index(HttpSession session) {
        if (session.getAttribute("currentUser") != null) {
            return "redirect:/dashboard";
        }
        return "redirect:/login";
    }

    @GetMapping("/dashboard")
    public String showDashboard(HttpSession session, Model model) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/login";
        }

        List<Resume> resumes = resumeService.getResumesForUser(currentUser);
        model.addAttribute("totalResumes", resumes.size());
        
        // Calculate category stats
        Map<String, Integer> categoryStats = new HashMap<>();
        double avgConfidence = 0.0;
        double sumConfidence = 0.0;
        
        for (Resume resume : resumes) {
            categoryStats.put(resume.getPredictedCategory(), categoryStats.getOrDefault(resume.getPredictedCategory(), 0) + 1);
            sumConfidence += resume.getConfidenceScore();
        }
        
        if (!resumes.isEmpty()) {
            avgConfidence = sumConfidence / resumes.size();
        }
        
        model.addAttribute("categoryStats", categoryStats);
        model.addAttribute("avgConfidence", Math.round(avgConfidence * 100.0));
        model.addAttribute("recentResumes", resumes.stream().limit(5).toList());

        return "dashboard";
    }

    @GetMapping("/profile")
    public String showProfile(HttpSession session, Model model) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/login";
        }
        model.addAttribute("user", currentUser);
        return "profile";
    }
}
