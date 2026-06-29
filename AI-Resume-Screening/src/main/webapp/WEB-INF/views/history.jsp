<%@ include file="header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container">
    <div class="page-title">Screening History</div>

    <div class="glass-card history-table-card">
        <div class="table-controls">
            <!-- Left: Search controls -->
            <div style="display: flex; gap: 15px; flex-wrap: wrap; flex: 1;">
                <input type="text" id="search-input" class="search-input" placeholder="Search by filename..." onkeyup="filterHistory()">
                
                <select id="category-filter" class="search-input" style="width: 200px;" onchange="filterHistory()">
                    <option value="">All Categories</option>
                    <!-- JavaScript will dynamically populate distinct categories found in table rows -->
                </select>
            </div>
            
            <a href="${pageContext.request.contextPath}/upload" class="btn-primary" style="padding: 10px 20px; font-size: 0.9rem;" id="btn-history-upload-new">
                <i class="fa-solid fa-file-arrow-up"></i> Upload New
            </a>
        </div>

        <div class="table-responsive">
            <table class="data-table" id="history-table">
                <thead>
                    <tr>
                        <c:if test="${sessionScope.currentUser.role == 'ADMIN'}">
                            <th>User</th>
                        </c:if>
                        <th>Filename</th>
                        <th>Predicted Category</th>
                        <th>Confidence</th>
                        <th>Upload Date</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="history-table-body">
                    <c:choose>
                        <c:when test="${empty resumes}">
                            <tr class="no-records-row">
                                <td colspan="${sessionScope.currentUser.role == 'ADMIN' ? 6 : 5}" style="text-align: center; color: var(--text-sub); padding: 40px 0;">No records found.</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="res" items="${resumes}">
                                <tr class="history-row" data-filename="${res.fileName.toLowerCase()}" data-category="${res.predictedCategory}">
                                    <c:if test="${sessionScope.currentUser.role == 'ADMIN'}">
                                        <td style="font-weight: 500; color: var(--primary);">${res.user.username}</td>
                                    </c:if>
                                    <td><i class="fa-regular fa-file-lines" style="color: var(--primary); margin-right: 8px;"></i> ${res.fileName}</td>
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
                                        <a href="${pageContext.request.contextPath}/result?id=${res.id}" class="btn-secondary" style="padding: 6px 12px; font-size: 0.85rem;" id="btn-view-history-${res.id}">
                                            <i class="fa-regular fa-eye"></i> Details
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

<script>
    // Populate distinct categories in filter dropdown on page load
    document.addEventListener("DOMContentLoaded", () => {
        const filterSelect = document.getElementById("category-filter");
        const rows = document.querySelectorAll(".history-row");
        const categories = new Set();

        rows.forEach(row => {
            const cat = row.getAttribute("data-category");
            if (cat) categories.add(cat);
        });

        // Sort categories alphabetically
        Array.from(categories).sort().forEach(cat => {
            const opt = document.createElement("option");
            opt.value = cat;
            opt.innerText = cat;
            filterSelect.appendChild(opt);
        });
    });

    // Client-side instant filtering
    function filterHistory() {
        const searchVal = document.getElementById("search-input").value.toLowerCase();
        const catFilter = document.getElementById("category-filter").value;
        const rows = document.querySelectorAll(".history-row");
        let visibleCount = 0;

        rows.forEach(row => {
            const filename = row.getAttribute("data-filename");
            const category = row.getAttribute("data-category");
            
            const matchesSearch = filename.includes(searchVal);
            const matchesCategory = !catFilter || category === catFilter;

            if (matchesSearch && matchesCategory) {
                row.style.display = "";
                visibleCount++;
            } else {
                row.style.display = "none";
            }
        });

        // Show/hide empty state row if no results match
        const noRecordsRow = document.querySelector(".no-records-row");
        if (noRecordsRow) {
            if (visibleCount === 0 && rows.length > 0) {
                noRecordsRow.style.display = "";
                noRecordsRow.querySelector("td").innerText = "No matching records found.";
            } else if (rows.length === 0) {
                noRecordsRow.style.display = "";
                noRecordsRow.querySelector("td").innerText = "No records found.";
            } else {
                noRecordsRow.style.display = "none";
            }
        } else if (visibleCount === 0 && rows.length > 0) {
            // Append temporary no-records-row
            const tbody = document.getElementById("history-table-body");
            const newRow = document.createElement("tr");
            newRow.className = "no-records-row";
            newRow.innerHTML = `<td colspan="${document.getElementById("history-table").rows[0].cells.length}" style="text-align: center; color: var(--text-sub); padding: 40px 0;">No matching records found.</td>`;
            tbody.appendChild(newRow);
        }
    }
</script>

<%@ include file="footer.jsp" %>
