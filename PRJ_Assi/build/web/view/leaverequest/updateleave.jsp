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
    <body>        <c:set value="${requestScope.leave}" var="i"></c:set>
    <form action="update" method="post">

        <input type="hidden" name="rid" value="${i.id}" />
        Tiêu đề: <input type="text" name="title" value="${i.title}"/> <br/>
        Lý do:<textarea name="reason">${i.reason}</textarea> <br/>
        Từ ngày: <input type="date" name="from" value="${i.from}"/> <br/>
        Dến ngày: <input type="date" name="to" value="${i.to}"/> <br/>
        Owner: 
        <select name="ownerid_Employee">
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
        Status: ${i.status eq 0?"In progress"
                  :i.status eq 1?"Approved":"Rejected"}
        <br/>
        Created By : ${i.createdby.username} <br/>
        Created Date: ${i.createddate} <br/>
        <input type="submit" value="Save"/>
    </form>
</body>
</html>
