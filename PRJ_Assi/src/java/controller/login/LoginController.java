/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.login;

import dal.EmployeeDBContext;
import dal.UsersDBContext;
import data.Employee;
import data.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author ADM
 */
public class LoginController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        UsersDBContext db = new UsersDBContext();
        User user = db.get(username, password);

        if (user != null) {

            EmployeeDBContext demp = new EmployeeDBContext();
            Employee profile = demp.get(user.getEmployee().getId());
            user.setEmployee(profile);
            HttpSession session = request.getSession();
            session.setAttribute("user", user); // Lưu thông tin user vào session
            session.setAttribute("role", user.getRoles());
            if (user.getUsername().equals("kien")){
                response.sendRedirect("rollLanhDao.jsp");           
            } else if (user.hasRole("Trưởng phòng")){
            response.sendRedirect("rollTruongPhong.jsp");
            
            }else{
                response.sendRedirect("leaverequest/create");
            }
        } else {
            //Nếu sai username hoặc password thì sẽ hiển thị thông báo
            request.setAttribute("mess", "Username or Password is not exactly!!");
            request.getRequestDispatcher("view/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
    if (user != null) {
        if (user.hasRole("Lãnh đạo")) {  // Kiểm tra đúng role
            response.sendRedirect("rollLanhDao.jsp");
        } else if (user.hasRole("Trưởng phòng")) {
            response.sendRedirect("rollTruongPhong.jsp");
        } else {
            response.sendRedirect("view/login.jsp"); // Nếu không có role hợp lệ, quay lại login
        }
    } else {
        request.getRequestDispatcher("view/login.jsp").forward(request, response);
    }
    }

}
