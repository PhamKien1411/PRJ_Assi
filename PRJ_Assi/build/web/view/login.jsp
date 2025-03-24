<%-- 
    Document   : login
    Created on : Mar 14, 2025, 3:05:51 PM
    Author     : ADM
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<!--
Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Html.html to edit this template
-->
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <style>
            .form-group {
                margin-bottom: 5%;
                font-size: 18px;
                font-weight: bold;
                flex-direction: column;
                align-items: center;
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            html, body {
                height: 100%;
                overflow: hidden; /* Ngăn chặn thanh cuộn */
            }

            .box
            {
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }
            .container {
                text-align: center;
                background: burlywood;
                padding: 20px;
            }
        </style>




    </head>


    <body style="font-family: cursive">
        <div class="box container">  
            <form action="login" method="post">
                <h1 style="color: white">Login</h1>  


                <div class="form-group">
                    <label for="username">Username:</label>
                    <input type="text" id="username" name="username"/>
                </div>


                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" id="username" name="password"/>
                </div>


                <input type="submit" value="Login"/>
                
                <h3 style="color: red">${requestScope.mess}</h3>
                <%-- lấy từ request.setAttribute ở bên LoginController trong phương thức doPost--%>
            </form>
        </div>
    </body>
</html>