<%-- 
    Document   : viewleaverequest
    Created on : Mar 12, 2025, 11:49:30 PM
    Author     : ADM
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Xem đơn nghỉ phép</title>
    </head>
    <body>
        <h2>Các đơn chưa duyệt</h2>
        <table border="1">
            <thead>
                <tr>
                    <th>Title</th>
                    <th>Reason</th>
                    <th>From_date</th>
                    <th>To_Date</th>
                    <th>created_Date</th>
                    
                </tr>
            </thead>
            <c:forEach items="${requestScope.listNot}" var="i">
                <tr>
                    <td>${i.title}</td>
                    <td>${i.reason}</td>
                    <td>${i.from}</td>
                    <td>${i.to}</td>
                    <td>${i.createddate}</td>
                </tr>
            </c:forEach>

        </table>       
        <h2>Các đơn đã duyệt</h2>
        <table border="2">
            <thead>
                <tr>
                    <th>Title</th>                    
                    <th>From_date</th>
                    <th>To_Date</th>
                    <th>Created By</th>
                    <th>Status</th>                    
                    <th>Processed By</th><!-- Được duyệt bởi ai --> 
                </tr>
            </thead>
            <c:forEach items="${requestScope.list}" var="i">
                <tr>
                    <td>${i.title}</td>
                    <td>${i.from}</td>
                    <td>${i.to}</td>
                    <td>${i.createdBy.name}</td>
                    <td>${i.status eq 0?"In progress"
                          :i.status eq 1?"Approved":"Rejected"}</td>                   
                <td>${i.processedBy.name}</td>  
                </tr>
            </c:forEach>
        </table>        
    </body>
</html>
