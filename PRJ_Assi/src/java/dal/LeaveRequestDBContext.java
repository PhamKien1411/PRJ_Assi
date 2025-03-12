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
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ADM
 */
public class LeaveRequestDBContext extends DBContext<LeaveRequest> {

    @Override
    public ArrayList<LeaveRequest> list() {
        ArrayList<LeaveRequest> requests = new ArrayList<>();
        try {
            String sql = "SELECT * FROM LeaveRequest";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                LeaveRequest request = new LeaveRequest();
                request.setId(rs.getInt("id_LeaveRequest"));
                request.setTitle(rs.getString("title"));
                request.setReason(rs.getString("reason"));
                request.setFrom(rs.getDate("from_date"));
                request.setTo(rs.getDate("to_date"));
                request.setStatus(rs.getInt("status"));

                // Set người tạo
                User user = new User();
                user.setUsername(rs.getString("createBy"));
                request.setCreatedby(user);

                // Set người sở hữu
                Employee owner = new Employee();
                owner.setId(rs.getInt("owner_eid"));
                request.setOwner(owner);

                request.setCreateddate(rs.getTimestamp("createddate"));
                requests.add(request);
            }
        } catch (SQLException ex) {
            Logger.getLogger(LeaveRequestDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return requests; //Trả về danh sách hợp lệ
    }

    public List<LeaveRequest> getByCreator(String creator) {
        List<LeaveRequest> requests = new ArrayList<>();
        try {
            String sql = "select * from leaveRequest where  createBy = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, creator);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                LeaveRequest request = new LeaveRequest();
                request.setId(rs.getInt("id_LeaveRequest"));
                request.setTitle(rs.getString("title"));
                request.setReason(rs.getString("reason"));
                request.setFrom(rs.getDate("from_date"));
                request.setTo(rs.getDate("to_date"));
                request.setStatus(rs.getInt("status"));

                // Set người tạo
                User user = new User();
                user.setUsername(rs.getString("createBy"));
                request.setCreatedby(user);

                // Set người sở hữu
                Employee owner = new Employee();
                owner.setId(rs.getInt("owner_eid"));
                request.setOwner(owner);

                request.setCreateddate(rs.getTimestamp("createddate"));
                requests.add(request);
            }
        } catch (SQLException ex) {
            Logger.getLogger(LeaveRequestDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return requests;
    }
    public static void main(String[] args) {
        List<LeaveRequest> l = new LeaveRequestDBContext().getByCreator("mra");
        for (LeaveRequest leaveRequest : l) {
            System.out.println(leaveRequest.getId());
        }
        System.out.println(l.get(3).getCreatedby());
        
    }
    public List<LeaveRequest> getByCreatorNotCnfirm(String creator) {
        List<LeaveRequest> requests = new ArrayList<>();
        try {
            String sql = "SELECT * FROM LeaveRequest WHERE createBy = ? and [status] = 0";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, creator);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                LeaveRequest request = new LeaveRequest();
                request.setId(rs.getInt("id_LeaveRequest"));
                request.setTitle(rs.getString("title"));
                request.setReason(rs.getString("reason"));
                request.setFrom(rs.getDate("from_date"));
                request.setTo(rs.getDate("to_date"));
                request.setStatus(rs.getInt("status"));

                // Set người tạo
                User user = new User();
                user.setUsername(rs.getString("createBy"));
                request.setCreatedby(user);

                // Set người sở hữu
                Employee owner = new Employee();
                owner.setId(rs.getInt("owner_eid"));
                request.setOwner(owner);

                request.setCreateddate(rs.getTimestamp("createddate"));
                requests.add(request);
            }
        } catch (SQLException ex) {
            Logger.getLogger(LeaveRequestDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return requests;
    }


    
    @Override
    public void insert(LeaveRequest model) {
        try {

            String sql = "INSERT INTO LeaveRequest (title, reason, from_date, to_date, status, createBy, owner_eid, createddate)  VALUES  (?,?, ?, ?, 0, ?, ?, GETDATE())";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, model.getTitle());
            stm.setString(2, model.getReason());
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            sdf.setLenient(false);

            java.util.Date utilDate = sdf.parse(model.getFrom().toString());
            java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
            stm.setDate(3, sqlDate);
            java.util.Date utilDateto = sdf.parse(model.getTo().toString());
            java.sql.Date sqlDateto = new java.sql.Date(utilDateto.getTime());
            stm.setDate(4, sqlDateto);
            stm.setString(5, model.getCreatedby().getUsername());
            stm.setInt(6, model.getOwner().getId());
            stm.executeUpdate();
        } catch (SQLException ex) {
            System.out.println(ex);
        } catch (ParseException ex) {
            Logger.getLogger(LeaveRequestDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

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
            stm.setDate(3, (Date) model.getFrom());
            stm.setDate(4, (Date) model.getTo());
            stm.setInt(5, model.getOwner().getId());
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
    public void delete(LeaveRequest leaveRequest) {
    }
    
      public void delete(int model) {
        try {
            String sql = "DELETE FROM LeaveRequest WHERE id_LeaveRequest = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, model);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(LeaveRequestDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public LeaveRequest get(int id) {
    String sql = "SELECT * FROM LeaveRequest WHERE id_LeaveRequest = ?";
    try (PreparedStatement stm = connection.prepareStatement(sql)) {
        stm.setInt(1, id);
        try (ResultSet rs = stm.executeQuery()) {
            if (rs.next()) {
                LeaveRequest lr = new LeaveRequest();
                lr.setId(rs.getInt("id_LeaveRequest"));
                lr.setTitle(rs.getString("title"));
                lr.setReason(rs.getString("reason"));
                lr.setFrom(rs.getDate("from_date"));
                lr.setTo(rs.getDate("to_date"));
                lr.setStatus(rs.getInt("status"));
                lr.setCreateddate(rs.getTimestamp("createddate"));

                // Set người tạo
                User user = new User();
                user.setUsername(rs.getString("createBy"));
                lr.setCreatedby(user);

                // Set người sở hữu
                Employee owner = new Employee();
                owner.setId(rs.getInt("owner_eid"));
                lr.setOwner(owner);
                
                return lr;
            }
        }
    } catch (SQLException ex) {
        Logger.getLogger(LeaveRequestDBContext.class.getName()).log(Level.SEVERE, null, ex);
    }
    return null; // Nếu không tìm thấy, trả về null
}


}
