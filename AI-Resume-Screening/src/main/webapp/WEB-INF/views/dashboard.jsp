<%@ include file="header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container">
    <div class="page-title">Dashboard Overview</div>

    <div class="dashboard-grid">
        <div class="stat-card glass-card">
            <span class="stat-title">Resumes Screened</span>
            <span class="stat-value" id="stat-total-resumes">${totalResumes}</span>
            <span class="stat-desc">Total documents analyzed</span>
        </div>

        <div class="stat-card glass-card">
            <span class="stat-title">Avg Confidence</span>
            <div class="progress-circle-wrap">
                <div class="progress-circle" style="--progress: ${avgConfidence};" id="stat-avg-confidence-circle">
                    <span class="progress-value" id="stat-avg-confidence">${avgConfidence}%</span>
                </div>
            </div>
            <span class="stat-desc" style="text-align: center;">Average ML probability match</span>
        </div>

        <div class="stat-card glass-card">
            <span class="stat-title">Classification Actions</span>
            <div style="flex: 1; display: flex; flex-direction: column; justify-content: center; gap: 15px;">
                <a href="${pageContext.request.contextPath}/upload" class="btn-primary" id="btn-dashboard-upload">
                    <i class="fa-solid fa-file-arrow-up"></i> Upload New Resume
                </a>
                <a href="${pageContext.request.contextPath}/history" class="btn-secondary" id="btn-dashboard-history">
                    <i class="fa-solid fa-list"></i> View Full History
                </a>
            </div>
        </div>
    </div>

    <!-- Category Distribution Grid -->
    <div class="glass-card" style="padding: 30px; margin-bottom: 40px;">
        <h3 style="margin-bottom: 20px;">Category Breakdown</h3>
        <c:choose>
            <c:when test="${empty categoryStats}">
                <p style="color: var(--text-sub);">No classifications performed yet. Upload your first resume to see statistics.</p>
            </c:when>
            <c:otherwise>
                <div style="display: grid; grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); gap: 16px;">
                    <c:forEach var="entry" items="${categoryStats}">
                        <div style="background: rgba(15, 23, 42, 0.4); border: 1px solid var(--border-color); border-radius: 8px; padding: 16px; text-align: center;">
                            <span class="category-tag">${entry.key}</span>
                            <div style="font-size: 1.5rem; font-weight: 700; margin-top: 10px;">${entry.value}</div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Recent Resumes Table -->
    <div class="glass-card history-table-card">
        <div class="table-controls">
            <h3 style="margin: 0;">Recent Screenings</h3>
            <a href="${pageContext.request.contextPath}/history" style="color: var(--primary); text-decoration: none; font-size: 0.95rem; font-weight: 500;">
                See All <i class="fa-solid fa-arrow-right"></i>
            </a>
        </div>
        <div class="table-responsive">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Filename</th>
                        <th>Predicted Category</th>
                        <th>Confidence</th>
                        <th>Upload Date</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty recentResumes}">
                            <tr>
                                <td colspan="5" style="text-align: center; color: var(--text-sub);">No records found.</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="res" items="${recentResumes}">
                                <tr>
                                    <td><i class="fa-regular fa-file-pdf" style="color: var(--primary); margin-right: 8px;"></i> ${res.fileName}</td>
                                    <td><span class="category-tag">${res.predictedCategory}</span></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${res.confidenceScore >= 0.8}">
                                                <span class="confidence-badge confidence-high">${Math.round(res.confidenceScore * 100.0)}%</span>
                                            </c:when>
                                            <c:when test="${res.confidenceScore >= 0.5}">
                                                <span class="confidence-badge confidence-medium">${Math.round(res.confidenceScore * 100.0)}%</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="confidence-badge confidence-low">${Math.round(res.confidenceScore * 100.0)}%</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${res.uploadedAt}</td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/result?id=${res.id}" class="btn-secondary" style="padding: 6px 12px; font-size: 0.85rem;" id="btn-view-recent-${res.id}">
                                            <i class="fa-regular fa-eye"></i> View
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>
