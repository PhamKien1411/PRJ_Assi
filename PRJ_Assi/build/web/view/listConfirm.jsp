<%-- 
    Document   : listConfirm
    Created on : Mar 17, 2025, 1:58:33 PM
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
        <h2>Duyệt đơn nhân viên</h2>
        <table border="1">
            <tr>
                <th>Title</th>
                <th>Reason</th>
                <th>From_date</th>
                <th>To_Date</th>
                <th>Status</th>
                <th>created_Date</th>       
                <th>Action</th>
            </tr>
        <c:forEach items="${requestScope.list}" var="i">
            <tr>
                <td>${i.title}</td>
                <td>${i.reason}</td>
                <td>${i.from}</td>
                <td>${i.to}</td>
                <td>${i.status eq 0?"In progress"
                      :i.status eq 1?"Approved":"Rejected"}</td>
                <td>${i.createddate}</td>
                <td><a href="confirmLeave?action=0&id=${i.id}">Confirm</a>
                    <a href="confirmLeave?action=1&id=${i.id}">Reject</a>
                </td>                   


            </tr>
        </c:forEach>

    </table>
</body>
</html>
