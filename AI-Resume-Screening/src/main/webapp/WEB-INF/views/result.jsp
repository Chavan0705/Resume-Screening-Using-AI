<%@ include file="header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container">
    <div class="page-title">Screening Analysis Results</div>

    <div class="result-grid">
        <!-- Left details panel -->
        <div class="glass-card result-card-detail">
            <h3 style="margin-bottom: 20px;">ML Analysis</h3>
            
            <div style="margin-bottom: 25px;">
                <span class="stat-title">Predicted Job Role</span>
                <div class="result-tag" id="result-predicted-category">${resume.predictedCategory}</div>
            </div>

            <div style="margin-bottom: 25px; display: flex; flex-direction: column; align-items: center;">
                <span class="stat-title" style="align-self: flex-start;">Confidence Score</span>
                <div class="progress-circle-wrap">
                    <div class="progress-circle" style="--progress: ${Math.round(resume.confidenceScore * 100.0)};" id="result-confidence-circle">
                        <span class="progress-value" id="result-confidence-value">${Math.round(resume.confidenceScore * 100.0)}%</span>
                    </div>
                </div>
            </div>

            <div style="margin-bottom: 30px; font-size: 0.95rem; color: var(--text-sub); display: flex; flex-direction: column; gap: 10px;">
                <div><strong>File:</strong> <span id="result-filename">${resume.fileName}</span></div>
                <div><strong>Processed At:</strong> <span id="result-uploaded-at">${resume.uploadedAt}</span></div>
            </div>

            <div style="display: flex; flex-direction: column; gap: 12px;">
                <a href="${pageContext.request.contextPath}/upload" class="btn-primary" id="btn-result-another">Screen Another Resume</a>
                <a href="${pageContext.request.contextPath}/dashboard" class="btn-secondary" id="btn-result-dashboard">Back to Dashboard</a>
            </div>
        </div>

        <!-- Right raw text panel -->
        <div class="glass-card" style="padding: 30px;">
            <h3 style="margin-bottom: 20px;">Extracted Resume Text Preview</h3>
            <div class="text-preview-box" id="result-text-preview"><c:out value="${resume.rawText}" /></div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>
