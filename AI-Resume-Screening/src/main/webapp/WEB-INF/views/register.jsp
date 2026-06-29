<%@ include file="header.jsp" %>

<div class="auth-container">
    <div class="auth-card glass-card">
        <div class="auth-header">
            <div class="auth-logo">AI Resume Screener</div>
            <div class="auth-subtitle">Create your new account</div>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger" id="register-error-alert">${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/register" method="POST">
            <div class="form-group">
                <label for="username" class="form-label">Username</label>
                <input type="text" id="username" name="username" class="form-input" placeholder="Choose a username" required autocomplete="off">
            </div>

            <div class="form-group">
                <label for="email" class="form-label">Email Address</label>
                <input type="email" id="email" name="email" class="form-input" placeholder="Enter your email" required autocomplete="off">
            </div>
            
            <div class="form-group">
                <label for="password" class="form-label">Password</label>
                <input type="password" id="password" name="password" class="form-input" placeholder="Create a password" required>
            </div>

            <button type="submit" class="btn-primary" id="btn-register-submit">Register</button>
        </form>

        <div class="auth-footer">
            Already have an account? <a href="${pageContext.request.contextPath}/login" id="link-login">Sign in instead</a>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>
