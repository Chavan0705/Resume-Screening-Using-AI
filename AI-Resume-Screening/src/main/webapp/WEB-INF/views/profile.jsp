<%@ include file="header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container" style="max-width: 600px;">
    <div class="page-title" style="text-align: center;">User Profile</div>

    <div class="glass-card" style="padding: 40px; display: flex; flex-direction: column; align-items: center; gap: 20px;">
        <!-- Profile avatar icon -->
        <div style="width: 100px; height: 100px; border-radius: 50%; background: rgba(99, 102, 241, 0.1); border: 2px solid var(--primary); display: flex; align-items: center; justify-content: center; font-size: 3rem; color: var(--primary);">
            <i class="fa-solid fa-user-tie"></i>
        </div>

        <h2 style="font-weight: 700; margin-bottom: 10px;" id="profile-username">${user.username}</h2>
        
        <div style="width: 100%; height: 1px; background: var(--border-color); margin: 10px 0;"></div>
        
        <div style="width: 100%; display: flex; flex-direction: column; gap: 15px; font-size: 0.95rem;">
            <div style="display: flex; justify-content: space-between;">
                <span style="color: var(--text-sub);">Email Address:</span>
                <span style="font-weight: 600;" id="profile-email">${user.email}</span>
            </div>
            
            <div style="display: flex; justify-content: space-between;">
                <span style="color: var(--text-sub);">Account Role:</span>
                <span class="category-tag" style="background: rgba(16, 185, 129, 0.15); color: var(--success);" id="profile-role">${user.role}</span>
            </div>
            
            <div style="display: flex; justify-content: space-between;">
                <span style="color: var(--text-sub);">Registered On:</span>
                <span style="font-weight: 600; color: var(--text-main);" id="profile-created-at">${user.createdAt != null ? user.createdAt : 'System Default'}</span>
            </div>
        </div>
        
        <div style="width: 100%; margin-top: 20px; display: flex; gap: 15px;">
            <a href="${pageContext.request.contextPath}/dashboard" class="btn-primary" style="flex: 1;" id="btn-profile-dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/logout" class="btn-secondary" style="flex: 1;" id="btn-profile-logout">Logout</a>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>
