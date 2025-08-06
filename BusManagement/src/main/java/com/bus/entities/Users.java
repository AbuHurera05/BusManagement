package com.bus.entities;
import java.sql.*;
public class Users {
	private int userId;
	private String name;
	private String email;
	private String gender;
	private int age;
	private String cnic;
	private String phone;
	private String password;
	private Blob picture;
	public Users(int userId, String name, String email, String gender, int age, String cnic, String phone,
			String password, Blob picture) {
		super();
		this.userId = userId;
		this.name = name;
		this.email = email;
		this.gender = gender;
		this.age = age;
		this.cnic = cnic;
		this.phone = phone;
		this.password = password;
		this.picture = picture;
	}
	

	public Users() {
		
	}


	


	public Users(String name, String email, String gender, int age, String phone, String password) {
		super();
		this.name = name;
		this.email = email;
		this.gender = gender;
		this.age = age;
		this.phone = phone;
		this.password = password;
	}


	public int getUserId() {
		return userId;
	}


	public void setUserId(int userId) {
		this.userId = userId;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getGender() {
		return gender;
	}


	public void setGender(String gender) {
		this.gender = gender;
	}


	public int getAge() {
		return age;
	}


	public void setAge(int age) {
		this.age = age;
	}


	public String getCnic() {
		return cnic;
	}


	public void setCnic(String cnic) {
		this.cnic = cnic;
	}


	public String getPhone() {
		return phone;
	}


	public void setPhone(String phone) {
		this.phone = phone;
	}


	public String getPassword() {
		return password;
	}


	public void setPassword(String password) {
		this.password = password;
	}


	public Blob getPicture() {
		return picture;
	}


	public void setPicture(Blob picture) {
		this.picture = picture;
	}
	
	
}
