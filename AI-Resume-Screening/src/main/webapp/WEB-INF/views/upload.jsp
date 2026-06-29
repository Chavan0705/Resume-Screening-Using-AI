<%@ include file="header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container" style="max-width: 700px;">
    <div class="page-title" style="text-align: center;">Upload Resume</div>

    <c:if test="${not empty error}">
        <div class="alert alert-danger" id="upload-error-alert">${error}</div>
    </c:if>

    <div class="glass-card" style="padding: 40px;">
        <form action="${pageContext.request.contextPath}/upload" method="POST" enctype="multipart/form-data" id="upload-form">
            
            <div class="upload-zone" id="drop-zone">
                <div class="upload-icon">
                    <i class="fa-solid fa-cloud-arrow-up"></i>
                </div>
                <div class="upload-text">Drag and drop your resume here</div>
                <div class="upload-hint">or click to browse your files</div>
                <input type="file" name="file" id="file-input" style="display: none;" accept=".pdf,.docx,.txt" required>
                
                <div id="file-info" style="margin-top: 15px; font-weight: 600; color: var(--primary); display: none;"></div>
            </div>

            <div style="margin-top: 30px; display: flex; gap: 15px;">
                <button type="submit" class="btn-primary" style="flex: 2;" id="btn-upload-submit">Start AI Screening</button>
                <a href="${pageContext.request.contextPath}/dashboard" class="btn-secondary" style="flex: 1; display: flex; align-items: center; justify-content: center;" id="btn-upload-cancel">Cancel</a>
            </div>
        </form>
    </div>
</div>

<!-- Loader Overlay -->
<div class="loader-overlay" id="loading-overlay">
    <div class="loader-box">
        <div class="spinner"></div>
        <div class="loader-text">AI is reading resume and predicting category...</div>
    </div>
</div>

<script>
    const dropZone = document.getElementById('drop-zone');
    const fileInput = document.getElementById('file-input');
    const fileInfo = document.getElementById('file-info');
    const form = document.getElementById('upload-form');
    const overlay = document.getElementById('loading-overlay');

    dropZone.addEventListener('click', () => {
        fileInput.click();
    });

    fileInput.addEventListener('change', (e) => {
        showFileInfo(fileInput.files[0]);
    });

    dropZone.addEventListener('dragover', (e) => {
        e.preventDefault();
        dropZone.style.borderColor = 'var(--primary)';
        dropZone.style.background = 'rgba(99, 102, 241, 0.08)';
    });

    dropZone.addEventListener('dragleave', () => {
        dropZone.style.borderColor = 'rgba(255, 255, 255, 0.15)';
        dropZone.style.background = 'rgba(30, 41, 59, 0.3)';
    });

    dropZone.addEventListener('drop', (e) => {
        e.preventDefault();
        dropZone.style.borderColor = 'rgba(255, 255, 255, 0.15)';
        dropZone.style.background = 'rgba(30, 41, 59, 0.3)';
        
        if (e.dataTransfer.files.length > 0) {
            fileInput.files = e.dataTransfer.files;
            showFileInfo(e.dataTransfer.files[0]);
        }
    });

    function showFileInfo(file) {
        if (file) {
            fileInfo.innerHTML = `<i class="fa-regular fa-file"></i> Selected: ${file.name} (${(file.size / 1024).toFixed(1)} KB)`;
            fileInfo.style.display = 'block';
        }
    }

    form.addEventListener('submit', () => {
        overlay.style.display = 'flex';
    });
</script>

<%@ include file="footer.jsp" %>
