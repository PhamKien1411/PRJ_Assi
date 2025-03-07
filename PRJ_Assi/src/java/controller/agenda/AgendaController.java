/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.agenda;

import dal.AgendaDBContext;
import data.Agenda;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

/**
 *
 * @author ADM
 */
public class AgendaController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
     AgendaDBContext db = new AgendaDBContext();
        ArrayList<Agenda> agendaList = db.list();

        // Đặt danh sách vào request để hiển thị trên JSP
        request.setAttribute("agendaData", agendaList);
        request.getRequestDispatcher("view/agendaView.jsp").forward(request, response);
    
    } 

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        doGet(request, response);
}
}