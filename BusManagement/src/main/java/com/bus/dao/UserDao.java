package com.bus.dao;
import java.sql.*;

import com.bus.entities.Users;
public class UserDao {
	private Connection con;

	public UserDao(Connection con) {
		super();
		this.con = con;
	}
	public boolean saveUser(Users user) 
	{
		boolean f= false;
		try 
		{
			
			//user  database
			String q="insert into users(userId,name,email,gender,age,cnic,phone,password,picture) values (?,?,?,?,?,?,?,?,?)";
			PreparedStatement pstmt=this.con.prepareStatement(q);
			pstmt.setInt(1, user.getUserId());
			pstmt.setString(2, user.getName());
			pstmt.setString(3, user.getEmail());
			pstmt.setString(4, user.getGender());
			pstmt.setInt(5, user.getAge());
			pstmt.setString(6, user.getCnic());
			pstmt.setString(7, user.getPhone());
			pstmt.setString(8,user.getPassword());
			pstmt.setBlob(9, user.getPicture());
			
			pstmt.executeUpdate();
			f=true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
		
		
	}
	//get user by username and email
	public Users getUserByEmailAndPassword(String email,String password) 
	{
		Users user=null;
		try {
			
			String q="select * from users where email =? and password = ?";
			PreparedStatement pstmt= con.prepareStatement(q);
			pstmt.setString(1, email);
			pstmt.setString(2, password);
			
			ResultSet set= pstmt.executeQuery();
			
			if(set.next()) 
			{
				user=new Users();
				
				// data from db
				String name= set.getString("name");
				
				//set to user object
				user.setName(name);
				
				user.setUserId(set.getInt("userId"));
				user.setEmail(set.getString("email"));
				user.setGender(set.getString("gender"));
				user.setAge(set.getInt("age"));
				user.setCnic(set.getString("cnic"));
				user.setPhone(set.getString("phone"));
				user.setPassword(set.getString("password"));
				user.setPicture(set.getBlob("picture"));
				
				
			}
			
		} catch (Exception e) {
			
		}
		
		return user;
		
	}
}
