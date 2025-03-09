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
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
        }
        
        .container {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 400px;
            text-align: center;
        }

        h1 {
            color: brown;
            margin-bottom: 20px;
        }

        form {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 15px; /* Khoảng cách giữa các ô nhập liệu */
        }

        input, textarea, select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }

        textarea {
            resize: none;
            height: 80px;
        }

        input[type="submit"] {
            background-color: brown;
            color: white;
            border: none;
            cursor: pointer;
            font-size: 18px;
            padding: 10px;
        }

        input[type="submit"]:hover {
            background-color: burlywood;
        }
    </style>
</head>
<body>

    <div class="container">
        <h1>Hello ${sessionScope.user.displayname}</h1>

        <form action="create" method="POST">
            <label>Tiêu đề:</label>
            <input type="text" name="title"/>

            <label>Lý do:</label>
            <textarea name="reason"></textarea>

            <label>Từ ngày:</label>
            <input type="date" name="from_date"/>

            <label>Đến ngày:</label>
            <input type="date" name="to_date"/>

            <label>Owner:</label>
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

            <input type="submit" value="Send"/>
        </form>
    </div>

</body>
</html>

