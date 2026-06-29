package com.example.airesume.util;

import org.apache.poi.xwpf.extractor.XWPFWordExtractor;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.Files;

@Component
public class TextExtractor {

    @Autowired
    private PdfReaderUtil pdfReaderUtil;

    public String extract(File file) throws IOException {
        String fileName = file.getName().toLowerCase();
        
        if (fileName.endsWith(".pdf")) {
            return pdfReaderUtil.readPdfText(file);
        } else if (fileName.endsWith(".docx")) {
            return readDocxText(file);
        } else if (fileName.endsWith(".txt")) {
            return readTxtText(file);
        } else {
            throw new IllegalArgumentException("Unsupported file type. Please upload a PDF, DOCX, or TXT file.");
        }
    }

    private String readDocxText(File file) throws IOException {
        try (FileInputStream fis = new FileInputStream(file);
             XWPFDocument doc = new XWPFDocument(fis);
             XWPFWordExtractor extractor = new XWPFWordExtractor(doc)) {
            return extractor.getText();
        }
    }

    private String readTxtText(File file) throws IOException {
        return Files.readString(file.toPath());
    }
}
