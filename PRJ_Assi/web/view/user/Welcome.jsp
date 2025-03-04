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
        
        <style>
            * {
               margin: 0;
               padding: 0;
               box-sizing: border-box;
           }
            
        .box
            {
             display: flex;
                justify-content: center;
                align-items: center;
                margin: 0;  
                text-align: center;
                background: burlywood;
                padding: 20px;               
           }
           .box2{
               display: flex;
                justify-content: center;
                align-items: center;
                margin: 0;
           }            
            </style>
    </head>
    <body style="font-family: cursive">
        <h1 class="box" style="color: brown">
            Hello ${sessionScope.user.displayname}
        </h1>
       
        <c:if test="${sessionScope.user.employee.manager ne null}">
            Cấp trên: ${sessionScope.user.employee.manager.name} <br/>
        </c:if>
            <h1 class="box2">Danh sách nhân viên: </h1>
        
        <h2 class="box2">   
            <c:forEach items="${sessionScope.user.employee.staffs}" var="s">
            ${s.name} <br/>
        </c:forEach>
        </h2> 
    </body>
</html>
