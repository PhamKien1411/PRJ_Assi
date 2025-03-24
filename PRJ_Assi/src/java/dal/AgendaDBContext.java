/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import data.Agenda;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;

import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ADM
 */
public class AgendaDBContext extends DBContext<Agenda> {

    public ArrayList<Agenda> list() {
        ArrayList<Agenda> agenda = new ArrayList<>();
        try {
            String sql = """
                    SELECT ea.id_Attendance, e.id_Employee, e.name_Employee, ea.attendance_date, ea.status 
                    FROM Employee_Attendance ea 
                    JOIN Employees e ON ea.id_Employee = e.id_Employee 
                    ORDER BY e.id_Employee ASC, ea.attendance_date ASC
                    """;
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                agenda.add(new Agenda(
                        rs.getInt("id_Attendance"),
                        rs.getInt("id_Employee"),
                        rs.getString("name_Employee"),
                        rs.getString("attendance_date"),
                        rs.getString("status")
                ));
            }
        } catch (SQLException ex) {
            Logger.getLogger(AgendaDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (connection != null)
                try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(AgendaDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return agenda;
    }
    //Ở trong SaveAttendance.java
    public void saveAttendance(ArrayList<Agenda> attendances) {
        PreparedStatement stm = null;
        try {
            String sql = """
            MERGE INTO Employee_Attendance AS target
            USING (SELECT ? AS id_Employee, ? AS attendance_date, ? AS status) AS source
            ON target.id_Employee = source.id_Employee AND target.attendance_date = source.attendance_date
            WHEN MATCHED THEN 
                UPDATE SET target.status = source.status
            WHEN NOT MATCHED THEN 
                INSERT (id_Employee, attendance_date, status) VALUES (source.id_Employee, source.attendance_date, source.status);
        """;

            stm = connection.prepareStatement(sql);

            for (Agenda att : attendances) {
                stm.setInt(1, att.getEmployeeId());
                stm.setString(2, att.getAttendanceDate());
                stm.setString(3, att.getStatus());
                stm.addBatch(); // Thêm vào batch để giảm số lần gọi SQL
            }

        int[] affectedRows = stm.executeBatch(); // Chạy tất cả lệnh INSERT/UPDATE một lần
        //Khi ấn check box, thì sẽ lưu lại 
        //Chứa số bản ghi bị ảnh hưởng.
        Arrays.toString(affectedRows);
      

    } catch (SQLException ex) {
        ex.printStackTrace(); // In lỗi SQL ra console
    } finally {
        try {
            if (stm != null) stm.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
}

    @Override
    public Agenda get(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void insert(Agenda model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void update(Agenda model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(Agenda model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
