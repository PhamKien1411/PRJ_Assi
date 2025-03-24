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
    //doPost(): Xử lý đăng nhập, kiểm tra user và role, điều hướng trang phù hợp.
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //Lấy giá trị username và password từ request của form đăng nhập.
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        UsersDBContext db = new UsersDBContext();
        
        //Kiểm tra tài khoản có tồn tại hay không
        User user = db.get(username, password);

        if (user != null) {//Nếu có
            //Lấy thông tin nhân viên trong EmployeeDBContext
            EmployeeDBContext demp = new EmployeeDBContext();
            Employee profile = demp.get(user.getEmployee().getId());
            
            user.setEmployee(profile);
            
            HttpSession session = request.getSession();
            session.setAttribute("user", user); // Lưu thông tin user vào session
            session.setAttribute("role", user.getRoles());//// Lưu thông tin role(vai trò) vào session
            //Điều hướng người dùng theo Role
            if (user.getUsername().equals("kien")){ // kien đang có role 'Lãnh đạo' 
                response.sendRedirect("rollLanhDao.jsp");           
            } else if (user.hasRole("Trưởng phòng")){ //Nếu người dùng có role 'Trưởng phòng'
            response.sendRedirect("rollTruongPhong.jsp");
            // Sẽ truy cập vào trang chọn chức năng
            //dành riêng co người có role 'Trưởng phòng'
            
            }else{
                response.sendRedirect("leaverequest/create");
            }
        } else {
            //Nếu sai username hoặc password thì sẽ hiển thị thông báo
            request.setAttribute("mess", "Username or Password is not exactly!!");
            //Và sẽ ở lại trang login
            request.getRequestDispatcher("view/login.jsp").forward(request, response);
        }
    }

    @Override
    //doGet: Kiểm tra nếu user đã đăng nhập hay chưa, điều hướng trang hoặc hiển thị login.
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //Lưu thông tin của User vào session
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
