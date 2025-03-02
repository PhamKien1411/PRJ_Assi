<%-- 
    Document   : Welcome
    Created on : Feb 20, 2025, 2:18:28 PM
    Author     : ADM
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello ${sessionScope.user.displayname}</h1>
               
        <c:if test="${sessionScope.user.employee.manager ne null}">
            Cấp trên: ${sessionScope.user.employee.manager.name} <br/>
        </c:if>
            <h1>Danh sách nhân viên được quản lý bởi bạn: </h1>
        <c:forEach items="${sessionScope.user.employee.staffs}" var="s">
            ${s.name} <br/>
        </c:forEach>
    </body>
</html>
