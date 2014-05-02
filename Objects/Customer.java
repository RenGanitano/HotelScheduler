/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package Objects;

/**
 *
 * @author Renniel
 */
public class Customer {
    
    private String username;
    private String password;
    
    public Room room;
    
    public Customer(String username, String password) {
        this.username = username;
        this.password = password;
    }
    
    public Customer(Customer customer, Room room) {
        this.username = customer.username;
        this.password = customer.password;
        this.room = room;        
    }
    
    public Customer(Customer customer, String type) {
        this.username = customer.username;
        this.password = customer.password;
        this.room = new Room(type);                  
    }
    
    public Room getRoom() {
        return room;
    }
    
    public Room bookRoom(String type) {
        Room room;
        DatabaseHandler dbh = new DatabaseHandler();
        dbh.connect();
        dbh.select("SELECT * FROM HOTELROOMS WHERE BOOKED = 'N' AND ROOMTYPE = '" + type + "'", "ROOM#");
        dbh.close();
        room = new Room(type);
        return room;
    }
    
    public String getUsername() {
        return this.username;
    }
}
