package com.bus.servlet;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class MyConnectionTest 
{
	private static Connection con;
    public static Connection getConnection() 
    {
        try 
        {
           if(con==null) {
        	   
        	   
        	   // Load the MySQL JDBC driver
               Class.forName("com.mysql.cj.jdbc.Driver");

               // Establish a connection
               con = DriverManager.getConnection(
                   "jdbc:mysql://localhost:3306/practice", "root", "root");


           }         

           
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return con;
    }
}
