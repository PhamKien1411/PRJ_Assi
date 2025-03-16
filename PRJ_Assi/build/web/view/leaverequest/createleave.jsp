<%-- 
    Document   : createleave
    Created on : Mar 4, 2025, 8:04:58 PM
    Author     : ADM
--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Tạo đơn</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style>
            body {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                min-height: 100vh;
                text-align: center;
                font-family: Arial, sans-serif;
            }
            .box {
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 20px;
                border-radius: 10px;
                margin-bottom: 20px;
                font-size: 40px;
                font-weight: bold;
            }
            h1 {
                color: brown;
            }

            form {
                background: #f9f9f9;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
                width: 50%;
                text-align: left;
            }

            table {
                width: 80%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            th, td {
                border: 1px solid black;
                padding: 10px;
            }

            th {
                background-color: #f2f2f2;
            }

            .actions a {
                margin: 0 5px;
                text-decoration: none;
                padding: 5px 10px;
                border-radius: 5px;
                color: white;
            }

            .actions a:first-child {
                background-color: red;
            }

            .actions a:last-child {
                background-color: green;
            }

            .form-group {
                display: flex;
                align-items: center;
                justify-content: space-between;
                margin-bottom: 10px;
            }
            label {
                width: 30%;
                text-align: right;
                padding-right: 10px;
                font-weight: bold;
            }

            input, textarea, select {
                width: 65%;
                padding: 5px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            textarea {
                resize: vertical;
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
            }
            
            
            
        </style>


            <script>
        let function1 = () => {
           confirm("Delete Successfully" );
        };
         let function2 = () => {
           confirm("Update Successfully" );
        };
    </script>
    </head>

    <body>
        <c:if test="${requestScope.delete != null}">
            <script>
            function1();
        </script>
        </c:if>
        <c:if test="${requestScope.update != null}">
            <script>
            function2();
        </script>
        </c:if>
        <h1 class="box">
            Hello ${sessionScope.user.displayname}
        </h1>
        
        <h2>Tạo đơn</h2>
        <form action="/PRJ_Assi/leaverequest/create" method="POST">

            <div class="form-group">
                <label>Title:</label> 
                <input type="text" name="title"/>
            </div>

            <div class="form-group">
                <label>Reason:</label> 
                <textarea name="reason"></textarea>
            </div>

            <div class="form-group">
                <label>From:</label> 
                <input type="date" name="from_date"/>
            </div>

            <div class="form-group">
                <label>To:</label> 
                <input type="date" name="to_date"/>
            </div>
            <div class="form-group">
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
            </div>


            <c:if test="${not empty sessionScope.message}">
                <div style="color: green; font-weight: bold; text-align: center; padding: 10px;">
                    ${sessionScope.message}
                </div>
                <c:remove var="message" scope="session"/>
            </c:if>

            <div class="submit-container">
                <input type="submit" value="Send"/>
            </div>


        </form>

        <button><a href="/PRJ_Assi/listLeave?list=1">Xem đơn đã tạo</a></button>
        <button><a href="/PRJ_Assi/listLeave?list=2">Xem đơn duyệt</a></button>
        <button>
            <a href="http://localhost:9999/PRJ_Assi/">Back</a>
        </button>

    </body>
</html>
