<%@ include file="header.jsp" %>

<div class="auth-container">
    <div class="auth-card glass-card">
        <div class="auth-header">
            <div class="auth-logo">AI Resume Screener</div>
            <div class="auth-subtitle">Sign in to your account</div>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger" id="login-error-alert">${error}</div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="alert alert-success" id="login-success-alert">${success}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/login" method="POST">
            <div class="form-group">
                <label for="username" class="form-label">Username</label>
                <input type="text" id="username" name="username" class="form-input" placeholder="Enter username" required autocomplete="off">
            </div>
            
            <div class="form-group">
                <label for="password" class="form-label">Password</label>
                <input type="password" id="password" name="password" class="form-input" placeholder="Enter password" required>
            </div>

            <button type="submit" class="btn-primary" id="btn-login-submit">Login</button>
        </form>

        <div class="auth-footer">
            Don't have an account? <a href="${pageContext.request.contextPath}/register" id="link-register">Register here</a>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>
