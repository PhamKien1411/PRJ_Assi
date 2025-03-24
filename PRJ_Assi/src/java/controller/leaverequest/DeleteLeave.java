/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.leaverequest;

import dal.EmployeeDBContext;
import dal.LeaveRequestDBContext;
import data.Employee;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

/**
 *
 * @author ADMIN
 */
public class DeleteLeave extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet DeleteLeave</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DeleteLeave at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        LeaveRequestDBContext l = new LeaveRequestDBContext();
        //Nếu chọn xóa đơn đi thì đơn sẽ được xóa và id sẽ biến mất
        if ("delete".equals(request.getParameter("action"))) {
            l.delete(id);
            //Khi xóa đơn thì sẽ ở lại trang list đơn        
            response.sendRedirect(request.getContextPath() + "/listLeave");
        } else {
            //Còn chọn update 
            EmployeeDBContext db = new EmployeeDBContext();
            //Lưu lại các thông tin đơn từ người dùng tạo
            ArrayList<Employee> employees = db.list();
            request.setAttribute("employees", employees);
            request.setAttribute("leave", l.get(id));  
            request.getRequestDispatcher("/view/leaverequest/updateleave.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }


}
