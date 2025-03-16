/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import data.LeaveRequest;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DuyetDBContext extends DBContext<Object> {

    // Duyệt đơn nghỉ
    public void approveLeave(int requestId, String approvedBy, String comments) {
        String sql = "INSERT INTO LeaveApproval (id_LeaveRequest, approvedBy, status, comments) VALUES (?, ?, 'Approved', ?)";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, requestId);
            stm.setString(2, approvedBy);
            stm.setString(3, comments);
            stm.executeUpdate();
            System.out.println("Đã duyệt đơn nghỉ: " + requestId);
        } catch (SQLException ex) {
            Logger.getLogger(DuyetDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // Từ chối đơn nghỉ
    public void rejectLeave(int requestId, String approvedBy, String comments) {
        String sql = "INSERT INTO LeaveApproval (id_LeaveRequest, approvedBy, status, comments) VALUES (?, ?, 'Rejected', ?)";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, requestId);
            stm.setString(2, approvedBy);
            stm.setString(3, comments);
            stm.executeUpdate();
            System.out.println("Đã từ chối đơn nghỉ: " + requestId);
        } catch (SQLException ex) {
            Logger.getLogger(DuyetDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // Lấy danh sách đơn nghỉ đang chờ duyệt
    public List<Integer> getPendingRequests() {
        List<Integer> requests = new ArrayList<>();
        String sql = "SELECT id_LeaveRequest FROM LeaveRequest WHERE status = 0";
        try (PreparedStatement stm = connection.prepareStatement(sql);
             ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                requests.add(rs.getInt("id_LeaveRequest"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(DuyetDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return requests;
    }

    @Override
    public ArrayList<Object> list() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Object get(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void insert(Object model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void update(Object model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(Object model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public LeaveRequest getLeaveRequestById(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}


