/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package data;

import java.util.Date;
import java.sql.*;
/**
 *
 * @author ADM
 */
public class LeaveRequest extends BaseEntity{
    private String title;
    private String reason;
    private String from;
    private String to;
    private int status;

    
    private int owner;
    private String createddate;

    public LeaveRequest(String title, String reason, String from, String to, int status, int owner, String createddate) {
        this.title = title;
        this.reason = reason;
        this.from = from;
        this.to = to;
        this.status = status;
        this.owner = owner;
        this.createddate = createddate;
    }

    public LeaveRequest() {
    }

    
    
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getFrom() {
        return from;
    }

    public void setFrom(String from) {
        this.from = from;
    }

    public String getTo() {
        return to;
    }

    public void setTo(String to) {
        this.to = to;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getOwner() {
        return owner;
    }

    public void setOwner(int owner) {
        this.owner = owner;
    }

    public String getCreateddate() {
        return createddate;
    }

    public void setCreateddate(String createddate) {
        this.createddate = createddate;
    }
    
    
}
    
   
