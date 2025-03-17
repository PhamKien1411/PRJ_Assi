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
import java.sql.Date;
import java.util.ArrayList;

/**
 *
 * @author ADM
 */
public class CreateLeaveRequest extends BaseRequiredAuthenticationController {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp, User user) throws ServletException, IOException {
        try {
            LeaveRequest lr = new LeaveRequest();
            lr.setTitle(req.getParameter("title"));
            lr.setReason(req.getParameter("reason"));
            lr.setFrom(Date.valueOf(req.getParameter("from_date")));
            lr.setTo(Date.valueOf(req.getParameter("to_date")));

            Employee owner = new Employee();
            owner.setId(Integer.parseInt(req.getParameter("ownerid_Employee")));
            lr.setOwner(owner);
            lr.setCreatedby(user);

            LeaveRequestDBContext db = new LeaveRequestDBContext();
            db.insert(lr);
            req.getSession().setAttribute("message", "Đơn xin nghỉ đã được tạo thành công!");
        } catch (Exception e) {
            req.getSession().setAttribute("message", "Lỗi! Không thể tạo đơn xin nghỉ.");
        }
        //resp.sendRedirect("http://localhost:9999/PRJ_Assi/login");
     if (user.hasRole("Trưởng phòng")||user.hasRole("Nhân viên")) {
            resp.sendRedirect("http://localhost:9999/PRJ_Assi/leaverequest/create");//khi gửi đơn thành công thì nó sẽ ở 
            //lại trang create
        }
     
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {

        if (user.hasRole("Lãnh đạo")) {
            request.getRequestDispatcher("../view/agendaView.jsp").forward(request, response);
        } else {
            EmployeeDBContext db = new EmployeeDBContext();
            ArrayList<Employee> employees = db.list();
            request.setAttribute("employees", employees);
            LeaveRequestDBContext context = new LeaveRequestDBContext();
            request.setAttribute("listNot", context.getByCreatorNotCnfirm(user.getUsername()));
            request.setAttribute("list", context.getByCreator(user.getUsername()));
            if ("delete".equals(request.getParameter("action"))) {
                request.setAttribute("delete", "delete");
            }
            if ("update".equals(request.getParameter("action"))) {
                request.setAttribute("update", "update");
            }
            request.getRequestDispatcher("../view/leaverequest/createleave.jsp").forward(request, response);
        }
    
    
    
    
    }

}
