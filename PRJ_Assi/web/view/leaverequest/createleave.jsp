<%-- 
    Document   : createleave
    Created on : Mar 4, 2025, 8:04:58 PM
    Author     : ADM
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1 style="color: brown">
            Hello ${sessionScope.user.displayname}
        </h1>
    <form action="create" method="POST">
        Tiêu đề: <input type="text" name="title"/> <br/>    
        Lý do: <textarea name="reason"></textarea> <br/>
        Từ ngày: <input type="date" name="from"/> <br/>
        Đến ngày: <input type="date" name="to"/> <br/>
            Owner: 
            <select name="ownerid_Employee">
                <c:forEach items="${requestScope.employees}" var="e">
                    <option value="${e.id}"
                            <c:if test="${e.id eq sessionScope.user.employee.id}">
                            selected="selected"
                            </c:if>
                            >
                        ${e.name}
                    </option>
                </c:forEach>
            </select><br/>
            <input type="submit" value="Send"/>
        
        
    </form>
    </body>
</html>
