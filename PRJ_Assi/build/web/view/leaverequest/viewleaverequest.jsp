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
        <title>Xem đơn</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                text-align: center;
                background-color: #f4f4f4;
                padding: 20px;
            }
            h2 {
                color: #333;
            }
            table {
                width: 80%;
                margin: auto;
                border-collapse: collapse;
                background: white;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
                overflow: hidden;
            }
            th, td {
                padding: 10px;
                border: 1px solid #ddd;
            }
            th {
                background-color: #007bff;
                color: white;
            }
            tr:nth-child(even) {
                background-color: #f2f2f2;
            }
            tr:hover {
                background-color: #ddd;
            }
            .btn {
                display: inline-block;
                padding: 10px 20px;
                margin: 20px;
                background-color: #007bff;
                color: white;
                text-decoration: none;
                border-radius: 5px;
                transition: 0.3s;
            }
            .btn:hover {
                background-color: #0056b3;
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

        <script>
            let deleteClick = (id) => {
                if (confirm("Are you sure to delete id: " + id)) {
                    window.location = "deleteLeave?action=delete&id=" + id;
                }
            };
        </script>
    </head>
    <body>
        <div class="btn-container"> 
       <button>
            <a href="http://localhost:9999/PRJ_Assi/leaverequest/create">Back</a>
        </button>
        </div>
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
                    <td><a href="#" onclick="deleteClick(${i.id})">Delete</a>
                        <a href="deleteLeave?action=update&id=${i.id}">update</a>
                    </td>                   


                </tr>
            </c:forEach>

        </table>

        
    </body>
</html>
