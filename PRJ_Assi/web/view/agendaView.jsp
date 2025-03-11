<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<%
    Calendar calendar = Calendar.getInstance();
%>

<html>
<head>
    <title>Agenda Giám Sát Nhân Viên</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            text-align: center;
        }
        
        .box {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            border-radius: 10px;
            font-size: 50px;
            font-weight: bold;
            
        }

        .text2 {
            font-size: 30px;
            margin-bottom: 20px;
        }

        table {
            width: 80%;
            margin: auto;
            border-collapse: collapse;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            
        }

        th, td {
            border: 2px solid black;
            text-align: center;
            padding: 12px;
        }

        th {
            background-color: brown;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .working {
            background-color: chartreuse;
        }

        .leave {
            background-color: red;
            color: white;
        }
    </style>
</head>
<body>

    <h1 class="box">
        Hello ${sessionScope.user.displayname}
    </h1>

    <h2 class="text2">Agenda Giám Sát Nhân Viên</h2>

    <table>
        <tr>
            <th>Nhân sự</th> 
            <c:forEach var="i" begin="0" end="4">
                <th>
                    <fmt:formatDate value="<%= calendar.getTime() %>" pattern="d" var="currentDay"/>
                    ${currentDay + i}/
                    <fmt:formatDate value="<%= calendar.getTime() %>" pattern="M"/>
                </th>
            </c:forEach>
        </tr>

        <c:forEach items="${sessionScope.user.employee.staffs}" var="s">
            <tr>
                <td>${s.name}</td>
                <c:forEach var="i" begin="0" end="4">
                    <td></td> <%-- Các ô trống để nhập trạng thái làm việc --%>
                </c:forEach>
            </tr>
        </c:forEach>
            
    </table>
   <input type="submit" value="Save"/> 
</body>
</html>