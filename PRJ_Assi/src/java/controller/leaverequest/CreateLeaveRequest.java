/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.leaverequest;

import controller.login.BaseRequiredAuthenticationController;
import dal.EmployeeDBContext;
import dal.LeaveRequestDBContext;
import data.Employee;
import data.LeaveRequest;
import data.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import java.util.ArrayList;

/**
 *
 * @author ADM
 */
public class CreateLeaveRequest extends BaseRequiredAuthenticationController {
   
     protected void doPost(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
        LeaveRequest lr = new LeaveRequest();
        lr.setTitle(req.getParameter("title"));
        lr.setReason(req.getParameter("reason"));
        lr.setFrom(req.getParameter("from_date"));
        lr.setTo(req.getParameter("to_date"));
        Employee owner = new Employee();
        owner.setId(Integer.parseInt(req.getParameter("ownerid_Employee")));
        lr.setOwner(owner.getId());
        lr.setCreatedby(user);
        LeaveRequestDBContext db = new LeaveRequestDBContext();
        db.insert(lr);
        resp.getWriter().println("inserted" + lr.getId());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        if (!user.hasRole("Nhân viên")&&!user.hasRole("Trưởng phòng")) {
            response.getWriter().println("Access denied!");
            return;
        }

    
        EmployeeDBContext db = new EmployeeDBContext();
        ArrayList<Employee> employees = db.list();
        request.setAttribute("employees", employees);
        request.getRequestDispatcher("createleave.jsp").forward(request, response);

    }


}
   

  

    
   

  
   

