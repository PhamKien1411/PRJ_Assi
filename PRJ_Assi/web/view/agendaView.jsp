<%-- 
    Document   : agendaView
    Created on : Mar 7, 2025, 8:48:18 PM
    Author     : ADM
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Agenda Giám Sát Nhân Viên</title>
    <style>
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid black; text-align: center; padding: 8px; }
        .working { background-color: lightgreen; }
        .leave { background-color: red; color: white; }
    </style>
</head>
<body>
    <h2>Agenda Giám Sát Nhân Viên</h2>
    <table>
        <tr>
            <th>Nhân sự</th>
            <c:forEach var="i" begin="1" end="9">
                <th>${i}/1</th>
            </c:forEach>
        </tr>
        <c:forEach var="employee" items="${agendaData}">
            <tr>
                <td>${employee.employee}</td>
                <c:forEach var="i" begin="1" end="9">
                    <td class="${employee.date.endsWith('/1') ? employee.status : ''}"></td>
                </c:forEach>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
