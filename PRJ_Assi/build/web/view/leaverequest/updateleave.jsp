<%-- 
    Document   : updateleave
    Created on : Mar 4, 2025, 8:07:18 PM
    Author     : ADM
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
    <from action="update" method="POST">
                    <input type="hidden" name="rid" value="${requestScope.leaverequest.id}" />
            Title: <input type="text" name="title" value="${requestScope.leaverequest.title}"/> <br/>
            Reason:<textarea name="reason">${requestScope.leaverequest.reason}</textarea> <br/>
            From: <input type="date" name="from" value="${requestScope.leaverequest.from}"/> <br/>
            To: <input type="date" name="to" value="${requestScope.leaverequest.to}"/> <br/>
            Owner: 
            <select name="eid">
                <c:forEach items="${requestScope.employees}" var="e">
                    <option value="${e.id}"
                            <c:if test="${e.id eq requestScope.leaverequest.owner.id}">
                            selected="selected"
                            </c:if>
                            >
                        ${e.name}
                    </option>
                </c:forEach>
            </select><br/>
            Status: ${requestScope.leaverequest.status eq 0?"In progress"
                      :requestScope.leaverequest.status eq 1?"Approved":"Rejected"}
            <br/>
            Created By : ${requestScope.leaverequest.createdby.displayname} <br/>
            Created Date: ${requestScope.leaverequest.createddate} <br/>
            <input type="submit" value="Save"/>
        
    </from>
    </body>
</html>
