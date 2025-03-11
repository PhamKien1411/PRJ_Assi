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
    <script>
        let deleteClick = (id) => {
            if (confirm("Are you sure to delete id: " + id)) {
                window.location = "deleteLeave?action=delete&id=" + id;
            }
        };
    </script>
    <body>
        <h1 style="color: brown">
            Hello ${sessionScope.user.displayname}
        </h1>
        <h2>Tạo đơn xin nghỉ việc</h2>
        <form action="create" method="POST">
            Tiêu đề: <input type="text" name="title"/> <br/>    
            Lý do: <textarea name="reason"></textarea> <br/>
            Từ ngày: <input type="date" name="from_date"/> <br/>
            Đến ngày: <input type="date" name="to_date"/> <br/>
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
        <h2>Các đơn xin nghỉ đã viết</h2>
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

        <h2>Các đơn xin nghỉ chưa duyệt</h2>
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
    </body>
</html>
