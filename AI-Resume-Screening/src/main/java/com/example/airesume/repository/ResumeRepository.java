package com.example.airesume.repository;

import com.example.airesume.entity.Resume;
import com.example.airesume.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface ResumeRepository extends JpaRepository<Resume, Long> {
    List<Resume> findByUserOrderByUploadedAtDesc(User user);
    List<Resume> findAllByOrderByUploadedAtDesc();
}
