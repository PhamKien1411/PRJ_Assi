<%-- 
    Document   : updateleave
    Created on : Mar 4, 2025, 8:07:18 PM
    Author     : ADM
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update đơn</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                background-color: #f8f8f8;
            }
            .container {
                background: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
                width: 400px;
                text-align: left;
            }
            .container h2 {
                text-align: center;
            }
            .form-group {
                display: flex;
                flex-direction: column;
                margin-bottom: 10px;
            }
            .form-group label {
                font-weight: bold;
                margin-bottom: 5px;
            }
            .form-group input, .form-group textarea, .form-group select {
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }
            .button-container {
                text-align: center;
                margin-top: 10px;
            }
            button {
                background-color: #007bff;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 4px;
                cursor: pointer;
            }
            button:hover {
                background-color: #0056b3;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Update đơn</h2>
            <c:set value="${requestScope.leave}" var="i"></c:set>
            <form action="/PRJ_Assi/leaverequest/update" method="post">
                <input type="hidden" name="rid" value="${i.id}" />

                <div class="form-group">
                    <label for="title">Title:</label>
                    <input type="text" id="title" name="title" value="${i.title}" />
                </div>

                <div class="form-group">
                    <label for="reason">Reason:</label>
                    <textarea id="reason" name="reason">${i.reason}</textarea>
                </div>

                <div class="form-group">
                    <label for="from">From:</label>
                    <input type="date" id="from" name="from" value="${i.from}" />
                </div>

                <div class="form-group">
                    <label for="to">To:</label>
                    <input type="date" id="to" name="to" value="${i.to}" />
                </div>

                <div class="form-group">
                    <label for="owner">Owner:</label>
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
                </select>
                </div>

                <p><strong>Status:</strong> ${i.status eq 0?"In progress"
                           :i.status eq 1?"Approved":"Rejected"}
                </p>
                <p><strong>Created By:</strong> ${i.createdby.username}</p>
                <p><strong>Created Date:</strong> ${i.createddate}</p>

                <div class="button-container">
                    <button type="submit">Save</button>
                </div>
            </form>
        </div>
    </body>
</html>
