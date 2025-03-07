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
