/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.leaverequest;

import controller.login.BaseRequiredAuthenticationController;
import dal.EmployeeDBContext;
import data.Employee;
import data.LeaveRequest;
import data.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.util.ArrayList;

/**
 *
 * @author ADM
 */
public class CreateLeaveRequest extends BaseRequiredAuthenticationController {
   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, User user)throws ServletException, IOException {
    LeaveRequest lr = new LeaveRequest();
    lr.setTitle(request.getParameter("title"));
    lr.setReason(request.getParameter("reason"));
        lr.setFrom(Date.valueOf(request.getParameter("from_date")));
        lr.setTo(Date.valueOf(request.getParameter("to_date")));
        Employee owner = new Employee();
        owner.setId(Integer.parseInt(request.getParameter("ownerid_Employee")));
        lr.setOwner(owner);
        lr.setCreatedby(user);
        //LeaveRequestDBContext db = new LeaveRequestDBContext();
        //db.insert(lr);
        response.getWriter().println("inserted" + lr.getId());
    
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, User user)throws ServletException, IOException {
     EmployeeDBContext db = new EmployeeDBContext();
        ArrayList<Employee> employees = db.list();
        request.setAttribute("employees", employees);
        request.getRequestDispatcher("/view/leaverequest/createleave.jsp").forward(request, response);
    } 


}
   

  

    
   

  
   

