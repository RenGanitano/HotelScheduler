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
public class Room {
    
    public String roomNum;
    
    public String type;
    public String beds;
    public boolean view;
    public double price;
    public String special;
    
    public Room(String type) {
        if(type.equals("Regular")) {
            this.type = type;
            this.beds = "";
            this.view = false;
            this.price = 300.0;
            
        } else if(type.equals("Regular with view")) {
            this.type = type;
            this.beds = "";
            this.view = true;
            this.price = 350.0;
            
        } else if(type.equals("Deluxe")) {
            this.type = type;
            this.beds = "";
            this.view = false;
            this.price = 500.0;
            
        } else if(type.equals("Deluxe with view")) {
            this.type = type;
            this.beds = "";
            this.view = true;
            this.price = 600.0;
            
        } else if(type.equals("Suite")) {
            this.type = type;
            this.beds = "";
            this.view = true;
            this.price = 800.0;
            
        }
    }
    
    public Room(String roomNum, String type) {
        this.roomNum = roomNum;
        this.type = type;
    }
    
    public String priceString() {
        this.price = this.price * 1.13;
        return String.format("%.2f", this.price);
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
        
}
