package controller.leaverequest;

import dal.DuyetDBContext;
import data.LeaveRequest;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;

public class LeaveApprovalController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String requestId = request.getParameter("requestId");
        
        if (requestId != null) {
            try {
                int id = Integer.parseInt(requestId);
                DuyetDBContext db = new DuyetDBContext();
                LeaveRequest leaveRequest = db.getLeaveRequestById(id);
                if (leaveRequest != null) {
                    request.setAttribute("request", leaveRequest);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/duyetDon.jsp");
                    dispatcher.forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/viewleaverequest?error=not_found");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/viewleaverequest?error=invalid_id");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/viewleaverequest?error=missing_data");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String requestId = request.getParameter("requestId");
        String action = request.getParameter("action"); // "approve" hoặc "reject"
        String processedBy = (String) request.getSession().getAttribute("username");
        String comments = request.getParameter("comments"); // Lấy lý do duyệt/từ chối

        if (requestId != null && processedBy != null && action != null) {
            try {
                int id = Integer.parseInt(requestId);
                DuyetDBContext db = new DuyetDBContext();
                
                if ("approve".equals(action)) {
                    db.approveLeave(id, processedBy, comments);
                } else if ("reject".equals(action)) {
                    db.rejectLeave(id, processedBy, comments);
                }

                response.sendRedirect(request.getContextPath() + "/viewleaverequest?success=true");
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/viewleaverequest?error=invalid_id");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/viewleaverequest?error=missing_data");
        }
    }
}
