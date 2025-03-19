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
        <style>
            body {
                font-family: Arial, sans-serif;
                text-align: center;
                background-color: #f4f4f4;
            }
            h2 {
                margin-top: 20px;
            }
            table {
                width: 80%;
                margin: 20px auto;
                border-collapse: collapse;
                background-color: #ffffff;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            }
            th, td {
                border: 1px solid #ddd;
                padding: 10px;
                text-align: center;
            }
            th {
                background-color: #007bff;
                color: white;
            }
            td a {
                text-decoration: none;
                font-weight: bold;
            }
            .btn-container {
                margin-top: 20px;
            }
            .btn-container button {
                padding: 10px 20px;
                font-size: 16px;
                background-color: #007bff;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
            .btn-container button a {
                color: white;
                text-decoration: none;
            }
            .btn-container button:hover {
                background-color: #0056b3;
            }
        </style>
    </head>
    <body>
        <div class="btn-container">
            <button>
                <a href="http://localhost:9999/PRJ_Assi/login">Back to home</a>
            </button>
        </div>
        <h2>Duyệt đơn nhân viên</h2>
        <table>
            <tr>
                <th>Title</th>
                <th>Reason</th>
                <th>From_date</th>
                <th>To_Date</th>
                <th>Status</th>
                <th>Created_by</th>
                <th>Created_Date</th>
                <th>Action</th>
            </tr>
            <c:forEach items="${requestScope.list}" var="i">
                <tr>
                    <td>${i.title}</td>
                    <td>${i.reason}</td>
                    <td>${i.from}</td>
                    <td>${i.to}</td>
                    <td>${i.status eq 0 ? "In progress" : i.status eq 1 ? "Approved" : "Rejected"}</td>
                    <td>${i.created_by}</td>
                    <td>${i.createddate}</td>
                    <td>
                        <a href="confirmLeave?action=0&id=${i.id}" style="color: blue">Confirm</a>
                        |
                        <a href="confirmLeave?action=1&id=${i.id}" style="color: red">Reject</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </body>
</html>
