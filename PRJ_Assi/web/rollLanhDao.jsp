<%-- 
    Document   : homeAdmin
    Created on : Mar 16, 2025, 7:48:10 PM
    Author     : ADM
--%>

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
            .btn-container {
                display: flex;
                justify-content: center;
                gap: 20px;
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
        <h1 class="box">
            Hello ${sessionScope.user.displayname}
        </h1>
        <div class="btn-container">
            <button>
                <a href="http://localhost:9999/PRJ_Assi/user/agenda">Angenda view</a>
            </button>
            <button>
                <a href="http://localhost:9999/PRJ_Assi/leaveManager">Duyệt Đơn</a>
            </button>
            <button>
                <a href="http://localhost:9999/PRJ_Assi/">Back to login</a>
            </button>
        </div>
    </body>
</html>