package com.example.airesume.util;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.UUID;

@Component
public class FileUtil {

    @Value("${app.upload.dir}")
    private String uploadDir;

    public File saveFile(MultipartFile file) throws IOException {
        File dir = new File(uploadDir);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        String originalName = file.getOriginalFilename();
        String extension = "";
        if (originalName != null && originalName.contains(".")) {
            extension = originalName.substring(originalName.lastIndexOf("."));
        }

        // Generate safe unique filename
        String uniqueName = UUID.randomUUID().toString() + extension;
        String filePath = Paths.get(uploadDir, uniqueName).toString();

        File destinationFile = new File(filePath);
        file.transferTo(destinationFile);

        return destinationFile;
    }
}
