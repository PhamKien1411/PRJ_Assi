<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


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
            input[type="submit"] {
                margin-top: 10px;
                padding: 8px 15px;
                background-color: #007bff;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }

            input[type="submit"]:hover {
                background-color: #0056b3;
            }

            .submit-container {
                width: 100%;
                display: flex;
                justify-content: center;
                margin-top: 10px;

            </style>
        </head>
        <body>

            <h1 class="box">
                Hello ${sessionScope.user.displayname}
            </h1>

            <h2 class="text2">Agenda Giám Sát Nhân Viên</h2>

            <form action="agenda" method="post">

                <input value="${requestScope.user.username}" hidden="" type="text" name="username"/>
                <input value="${requestScope.user.password}" hidden="" type="text" name="password"/>
                <table>
                    <tr>
                        <th>Nhân sự</th> 
                            <c:forEach var="day" items="${dateList}">
                            <th>${day}</th>
                            </c:forEach>
                    </tr>

                    <c:forEach items="${sessionScope.user.employee.staffs}" var="s">
                        <tr>
                            <td>${s.name}</td>

                            <c:forEach var="day" items="${dateList}">
                                <c:set var="checkDate" value="${day}" />

                                <c:set var="isChecked" value="false" />
                                <c:forEach items="${requestScope.agendaList}" var="att">
                                    <c:if test="${att.employeeId eq s.id and att.attendanceDate eq checkDate}">
                                        <c:set var="isChecked" value="true" />
                                    </c:if>
                                </c:forEach>

                                <td>
                                    <input type="checkbox" name="attendance"
                                           value="${s.id},${checkDate}" ${isChecked eq 'true' ? 'checked' : ''} />
                                </td>

                            </c:forEach>
                        </tr>
                    </c:forEach>

                </table>
                <div class="submit-container">
                    <button type="submit">Save</button>
                </div>
            </form>

        </body>
    </html>
