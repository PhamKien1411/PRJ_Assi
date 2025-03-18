/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.leaverequest;

import controller.login.BaseAccessControlByCreator;
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
public class UpdateLeaveRequest extends BaseAccessControlByCreator<LeaveRequest> {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, User user, LeaveRequest entity) throws ServletException, IOException {
        LeaveRequest lr = new LeaveRequest();
        lr.setId(Integer.parseInt(req.getParameter("rid")));
        lr.setTitle(req.getParameter("title"));
        lr.setReason(req.getParameter("reason"));
        lr.setFrom(Date.valueOf(req.getParameter("from")));
        lr.setTo(Date.valueOf(req.getParameter("to")));
        Employee owner = new Employee();
        owner.setId(Integer.parseInt(req.getParameter("ownerid_Employee")));
        lr.setOwner(owner);
        lr.setCreatedby(user);
        LeaveRequestDBContext db = new LeaveRequestDBContext();
        db.update(lr);
            //resp.sendRedirect("create?action=update");
             // Chuyển hướng về danh sách đơn nghỉ sau khi cập nhật
            resp.sendRedirect(req.getContextPath() + "/listLeave");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp, User user, LeaveRequest entity) throws ServletException, IOException {
        EmployeeDBContext db = new EmployeeDBContext();
        ArrayList<Employee> employees = db.list();
        req.setAttribute("employees", employees);
        req.setAttribute("leaverequest", entity);
        req.getRequestDispatcher("../view/leaverequest/updateleave.jsp").forward(req, resp);

    }

    @Override
    protected LeaveRequest getEntity(int id) {
        LeaveRequestDBContext dbLr = new LeaveRequestDBContext();
        return dbLr.get(id);
    }
}
