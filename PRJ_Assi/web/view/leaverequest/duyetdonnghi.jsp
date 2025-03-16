<%-- 
    Document   : viewleave
    Created on : Mar 9, 2025, 9:31:19 AM
    Author     : ADM
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Duyệt đơn</title>
    </head>
    <body>
    <div class="container">
        <div class="title">Duyệt đơn xin nghỉ phép</div>
        <form action="/PRJ_Assi/leaverequest/create" method="POST">
        <p>Duyệt bởi User: ${approver} , Role: ${role}</p>
        <p>Tạo bởi: ${request.createdBy}</p>
        <p>Từ ngày: ${request.fromDate}</p>
        <p>Tới ngày: ${request.toDate}</p>
        <p>Lý do:</p>
        <textarea readonly>${request.reason}</textarea>
        <div class="buttons">
            <form action="approveRequest" method="post">
                <input type="hidden" name="requestId" value="${request.id}">
                <button type="submit" class="approve">Approve</button>
            </form>
            <form action="rejectRequest" method="post">
                <input type="hidden" name="requestId" value="${request.id}">
                <button type="submit" class="reject">Reject</button>
            </form>
        </div>
        </form>        
                
    </div>
</body>
</html>
