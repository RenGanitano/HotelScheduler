/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Objects;

import java.sql.*;
import java.util.ArrayList;

/**
 *
 * @author Renniel
 */
public class DatabaseHandler {

    private Connection connection;
    Statement stmt;
    ResultSet rs;
    int count = 0;
    ArrayList results;

    public DatabaseHandler() {
    }

    public void connect() {
        try {
            Class.forName("oracle.jdbc.OracleDriver").newInstance();
            connection = DriverManager.getConnection("jdbc:oracle:thin:@dilbert.humber.ca:1521:grok ", "gntr0073", "oracle");
            System.out.println("Connection success!");
        } catch (Exception e) {
            System.out.println("Connection failed!");
        }
    }

    public ArrayList select(String query, String s) {
        results = new ArrayList();
        try {
            stmt = connection.createStatement();
            rs = stmt.executeQuery(query);
            while (rs.next()) {
                results.add(rs.getString(s));
            }
        } catch (Exception e) {

        }
        return results;
    }

    public int insert(String s) {
        int result;
        try {            
            stmt = connection.createStatement();
            count = stmt.executeUpdate(s);
            result = 0;
        } catch (SQLException e) {
            result = 1;
        }
        return result;
    }
    
    public void insertBookRoom(int roomNum, String username, String userneeds, String checkin, String checkout) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO HOTELROOMSBOOKED VALUES(?, ?, ?, ?, ?)");            
            preparedStatement.setInt(1, roomNum);
            preparedStatement.setString(2, username);
            preparedStatement.setString(3, userneeds);
            preparedStatement.setString(4, checkin);
            preparedStatement.setString(5, checkout);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {

        }        
    }
    
    public void insertItems() { }

    public void update() { }

    public void close() {
        try {
            connection.close();
        } catch (SQLException e) {

        }
    }
    
    public int delete(String s) {
        try {
            stmt = connection.createStatement();
            count = stmt.executeUpdate("DELETE FROM hotelrooms WHERE room# = " + s);
            return 0;
        } catch (Exception e) {
            return 1;
        }
    }
    
    public int deleteBooking(String s) {
        try {
            stmt = connection.createStatement();
            count = stmt.executeUpdate("DELETE FROM HOTELROOMSBOOKED WHERE ROOM# = " + s);
            return 0;
        } catch (Exception e) {
            return 1;
        }
    }
}
