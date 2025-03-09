/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import data.Employee;
import data.LeaveRequest;
import data.User;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ADM
 */
public class LeaveRequestDBContext extends DBContext<LeaveRequest> {

    @Override
    public ArrayList<LeaveRequest> list() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public LeaveRequest get(int id) {
        try {
            String sql = """
                         SELECT 
                             lr.id_LeaveRequest,
                             lr.title,
                             lr.reason,
                             lr.[from_date], 
                             lr.[to_date],    
                             lr.[status],
                             u.username AS createdbyusername,
                             u.displayname,
                             e.id_Employee AS ownereid,  
                             e.name_Employee AS ename,  
                             d.id_Department AS did,     
                             d.name_Department AS dname, 
                             lr.[createddate]
                         FROM LeaveRequest lr  
                         INNER JOIN Users u ON u.username = lr.createBy  -- Đúng tên cột
                         INNER JOIN Employees e ON e.id_Employee = lr.ownerid_Employee 
                         INNER JOIN Department d ON e.id_Department = d.id_Department 
                         WHERE lr.id_LeaveRequest = ?;
                         
                         """;
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                LeaveRequest lr = new LeaveRequest();
                lr.setId(rs.getInt("id_LeaveRequest"));
                lr.setTitle(rs.getString("title"));
                lr.setReason(rs.getString("reason"));
                lr.setFrom(rs.getDate("from_date").toString());
                lr.setTo(rs.getDate("to_date").toString());
                lr.setStatus(rs.getInt("status"));
                lr.setCreateddate(rs.getTimestamp("createddate").toString());

                Employee owner = new Employee();
                owner.setId(rs.getInt("owner_eid"));
                owner.setName(rs.getString("ename"));
                lr.setOwner(id);

                User u = new User();
                u.setUsername(rs.getString("createdbyusername"));
                u.setDisplayname(rs.getString("displayname"));
                lr.setCreatedby(u);
                return lr;
            }

        } catch (SQLException ex) {
            Logger.getLogger(LeaveRequestDBContext.class.getName()).log(Level.SEVERE, null, ex);
            try {
                connection.rollback();
            } catch (SQLException ex1) {
                Logger.getLogger(LeaveRequestDBContext.class.getName()).log(Level.SEVERE, null, ex1);
            }
        } finally {
            if (connection != null)
                try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(LeaveRequestDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return null;
    }

    @Override
    public void insert(LeaveRequest model) {
        try {
            connection.setAutoCommit(false);

            String sql = """
                    insert into LeaveRequest
                    (title,reason,from_date,to_date,status,createBy,owner_eid,createddate)
                    value(?,?,?,?,?,?)
                    """;
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, model.getTitle());
            stm.setString(2, model.getReason());
            stm.setDate(3, convertStringToSqlDate(model.getFrom()));
            stm.setDate(4, convertStringToSqlDate(model.getTo()));
            stm.setString(5, model.getCreatedby().getUsername());
            stm.setInt(6, model.getOwner());
            stm.executeUpdate();
            //get ID of record
            String sql_getid = "SELECT @@IDENTITY as id_LeaveRequest";
            PreparedStatement stm_getid = connection.prepareStatement(sql_getid);
            ResultSet rs = stm_getid.executeQuery();
            if (rs.next()) {
                model.setId(rs.getInt("id_LeaveRequest"));
            }
            connection.commit();
        } catch (SQLException ex) {
            Logger.getLogger(LeaveRequestDBContext.class.getName()).log(Level.SEVERE, null, ex);
            try {
                connection.rollback();
            } catch (SQLException ex1) {
                Logger.getLogger(LeaveRequestDBContext.class.getName()).log(Level.SEVERE, null, ex1);
            }
        } finally {
            if (connection != null)
                try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(LeaveRequestDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

    }

    public Date convertStringToSqlDate(String dateString) {
        try {
            // Định dạng chuẩn của HTML input type="date" là "yyyy-MM-dd"
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date parsedDate = sdf.parse(dateString);

            // Chuyển từ java.util.Date sang java.sql.Date
            return new Date(parsedDate.getTime());
        } catch (ParseException e) {
            System.out.println("Lỗi: Định dạng ngày không hợp lệ! Định dạng yêu cầu: YYYY-MM-DD.");
            return null;
        }
    }

    public static void main(String[] args) {
        LeaveRequestDBContext l = new LeaveRequestDBContext();
        LeaveRequest la = new LeaveRequest("aaaa", "aaa", "2024-11-11", "2024-11-12", 0, 1, "2024-11-12");
        l.insert(la);
    }

    @Override
    public void update(LeaveRequest model) {
        try {
            connection.setAutoCommit(false);
            String sql = """
                         Update LeaveRequest
                         Set title = ?,
                             reason = ?,
                             from_date =?,
                             to_date = ?,
                             owner_eid = ?
                         where id_LeaveRequest = ?
                         """;
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, model.getTitle());
            stm.setString(2, model.getReason());
            stm.setDate(3, convertStringToSqlDate( model.getFrom()));
            stm.setDate(4, convertStringToSqlDate(model.getTo()));
            stm.setInt(5, model.getOwner());
            stm.setInt(6, model.getId());
            stm.executeUpdate();
            connection.commit();

        } catch (SQLException ex) {
            Logger.getLogger(LeaveRequestDBContext.class.getName()).log(Level.SEVERE, null, ex);
            try {
                connection.rollback();
            } catch (SQLException ex1) {
                Logger.getLogger(LeaveRequestDBContext.class.getName()).log(Level.SEVERE, null, ex1);
            }
        } finally {
            if (connection != null)
                try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(LeaveRequestDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

    }

    @Override
    public void delete(LeaveRequest model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
