<%-- 
    Document   : choose
    Created on : Mar 13, 2025, 2:45:48 PM
    Author     : ADM
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lựa chọn chức năng</title>
    </head>
    <body>
        <h1 class="box">
            Hello ${sessionScope.user.displayname}
        </h1>

        <h1>Danh sách chức năng:</h1>
        <ul>
            <c:forEach items="${sessionScope.user.roles}" var="role">
                <c:forEach items="${role.features}" var="feature">
                    <li><a href="${pageContext.request.contextPath}${feature.url}">${feature.url}</a></li>
                </c:forEach>
            </c:forEach>
        </ul>
        <ul>
            <c:forEach items="${sessionScope.user.roles}" var="role">
                <!-- Nếu user là director, chỉ hiển thị Agenda -->
                <c:if test="${role.name eq 'Lãnh đạo'}">
                    <a href="${pageContext.request.contextPath}/user/agenda">Xem Agenda</a>
                    <li><a href="${pageContext.request.contextPath}/view/leaverequest/duyetdonnghi.jsp">Duyệt đơn</a></li>
                </c:if>

                <!-- Nếu user là division leader, hiển thị chức năng tạo, sửa, xem, duyệt đơn -->
                <c:if test="${role.name eq 'Trưởng phòng'}">
                    <li><a href="${pageContext.request.contextPath}/view/leaverequest/create.jsp">Tạo đơn</a></li>
                    <li><a href="${pageContext.request.contextPath}/view/leaverequest/view.jsp">Xem danh sách đơn</a></li>
                    <li><a href="${pageContext.request.contextPath}/view/leaverequest/approve.jsp">Duyệt đơn</a></li>
                </c:if>

                <!-- Nếu user là staff, chỉ có thể tạo, cập nhật và xem đơn -->
                <c:if test="${role.name eq 'Nhân viên'}">
                    <li><a href="${pageContext.request.contextPath}/view/leaverequest/create.jsp">Tạo đơn nghỉ phép</a></li>
                    <li><a href="${pageContext.request.contextPath}/view/leaverequest/view.jsp">Xem danh sách đơn đã được duyệt</a></li>
                </c:if>
            </c:forEach>
        </ul>

    </body>
</html>
