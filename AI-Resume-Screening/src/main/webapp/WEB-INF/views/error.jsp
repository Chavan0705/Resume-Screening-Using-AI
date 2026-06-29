<%@ include file="header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container" style="max-width: 650px; text-align: center; margin-top: 50px;">
    <div class="glass-card" style="padding: 50px;">
        <div style="font-size: 4rem; color: var(--error); margin-bottom: 20px;">
            <i class="fa-solid fa-circle-exclamation"></i>
        </div>
        
        <h2 style="font-weight: 700; margin-bottom: 15px;" id="error-title">An Error Occurred</h2>
        
        <p style="color: var(--text-sub); font-size: 1.1rem; margin-bottom: 30px;" id="error-message">
            <c:choose>
                <c:when test="${not empty error}">
                    ${error}
                </c:when>
                <c:otherwise>
                    The page you are looking for does not exist or you do not have permission to view it.
                </c:otherwise>
            </c:choose>
        </p>
        
        <div style="display: flex; gap: 15px; justify-content: center;">
            <a href="${pageContext.request.contextPath}/dashboard" class="btn-primary" style="padding: 12px 30px;" id="btn-error-home">Go to Home</a>
            <a href="javascript:history.back()" class="btn-secondary" style="padding: 12px 30px;" id="btn-error-back">Go Back</a>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>
