/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.agenda;

import dal.AgendaDBContext;
import data.Agenda;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

/**
 *
 * @author ADM
 */
public class AgendaController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Kiểm tra session
        AgendaDBContext db = new AgendaDBContext();
        ArrayList<Agenda> agendaList = db.list();
        request.setAttribute("agendaList", agendaList);
        // 1. Lấy ngày hiện tại
        Calendar calendar = Calendar.getInstance();
         while (calendar.get(Calendar.DAY_OF_WEEK) != Calendar.MONDAY) {
        calendar.add(Calendar.DAY_OF_MONTH, -1);
    }
        
        
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); // Định dạng yyyy-MM-dd

        // 2. Tạo danh sách 5 ngày tiếp theo
        List<String> dateList = new ArrayList<>();
        for (int i = 0; i < 5; i++) {
            dateList.add(sdf.format(calendar.getTime())); // Lưu ngày vào danh sách
            calendar.add(Calendar.DAY_OF_MONTH, 1); // Tăng ngày
        }

        // 3. Gửi danh sách ngày sang JSP
        request.setAttribute("dateList", dateList);
        request.getRequestDispatcher("view/agendaView.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String[] attendanceData = request.getParameterValues("attendance");

        if (attendanceData != null) {
            ArrayList<Agenda> attendances = new ArrayList<>();

            for (String record : attendanceData) {
                String[] parts = record.split(",");
                int employeeId = Integer.parseInt(parts[0]);
                String attendanceDate = parts[1];

                Agenda att = new Agenda();
                att.setEmployeeId(employeeId);
                att.setAttendanceDate(attendanceDate);
                att.setStatus("working"); // Hoặc giá trị phù hợp

                attendances.add(att);
            }

            AgendaDBContext dbContext = new AgendaDBContext();
            dbContext.saveAttendance(attendances);

        }

        response.sendRedirect("login");
    }
}
