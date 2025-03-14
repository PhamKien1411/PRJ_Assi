<%-- 
    Document   : viewleaverequest
    Created on : Mar 12, 2025, 11:49:30 PM
    Author     : ADM
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Xem đơn nghỉ phép</title>
            <script>
        let deleteClick = (id) => {
            if (confirm("Are you sure to delete id: " + id)) {
                window.location = "deleteLeave?action=delete&id=" + id;
            }
        };
    </script>
    </head>
    <body>
        <c:if test="${all == null}">
            <h2>Các đơn chưa duyệt</h2>
            <table border="1">
                <tr>
                    <th>Title</th>
                    <th>Reason</th>
                    <th>From_date</th>
                    <th>To_Date</th>
                    <th>created_Date</th>

                </tr>
            </thead>
            <c:forEach items="${requestScope.list}" var="i">
                <tr>
                    <td>${i.title}</td>
                    <td>${i.reason}</td>
                    <td>${i.from}</td>
                    <td>${i.to}</td>
                    <td>${i.createddate}</td>
                    <td ><a href="#" onclick="deleteClick(${i.id})">Delete</a>
                        <a href="deleteLeave?action=update&id=${i.id}">update</a></td>
                </tr>
            </c:forEach>

        </table>
    </c:if>

    <c:if test="${all!= null}">
        <h2>Các đơn đã tạo</h2>
        <table border="1">
            <thead>
                <tr>
                    <th>Title</th>
                    <th>Reason</th>
                    <th>From_date</th>
                    <th>To_Date</th>
                    <th>Status</th>
                    <th>created_Date</th>
                    <th>Action</th>
                </tr>
            </thead>
            <c:forEach items="${requestScope.list}" var="i">
                <tr>
                    <td>${i.title}</td>
                    <td>${i.reason}</td>
                    <td>${i.from}</td>
                    <td>${i.to}</td>
                    <td>${i.status eq 0?"In progress"
                          :i.status eq 1?"Approved":"Rejected"}</td>
                    <td>${i.createddate}</td>
                    <td ><a href="#" onclick="deleteClick(${i.id})">Delete</a>
                        <a href="deleteLeave?action=update&id=${i.id}">update</a></td>
                </tr>
            </c:forEach>
        </table>    
    </c:if>



</body>
</html>
