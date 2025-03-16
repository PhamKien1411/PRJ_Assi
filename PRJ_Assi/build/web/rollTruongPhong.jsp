<%-- 
    Document   : newjsp
    Created on : Mar 16, 2025, 11:20:19 PM
    Author     : ADM
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    
    
    <style>
            
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
        </style>
    
    </head>
    <body>
        <h1 class="box">
            Hello ${sessionScope.user.displayname}
        </h1>
        <button>
            <a href="http://localhost:9999/PRJ_Assi/leaverequest/create">Tạo đơn</a>
        </button>
         <button>
            <a href="http://localhost:9999/PRJ_Assi/leaverequest/duyetdonnghi">Accept Đơn</a>
        </button>
        <button>
            <a href="http://localhost:9999/PRJ_Assi/">Back</a>
        </button>
    </body>
</html>
