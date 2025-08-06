```markdown
# 🚌 Bus Management System – JSP + MySQL Project

The **Bus Management System** is a web-based application built with JSP, Servlets, HTML, CSS, JavaScript, and MySQL.  
It allows management of buses, routes, tickets, and bookings with an admin and user interface.

---

## 📁 Project Structure

```

BusManagementSystem/
├── src/
├── WebContent/
│   ├── index.jsp
│   ├── login.jsp
│   ├── addBus.jsp
│   ├── ...
│   └── WEB-INF/
│       └── web.xml
├── bus\_management.sql
├── README.md

````
### 🏠 Home Page
![Home Page](/screenshots/home.jpg)

### 🔐 Login Page
![Login Page](/screenshots/login.jpg)

### 📊 Admin Dashboard
![Admin Dashboard](/screenshots/admin.jpg)

---

## ⚙️ Requirements

| Software        | Version / Notes                        |
|-----------------|----------------------------------------|
| Java JDK        | 8 or higher                            |
| Apache Tomcat   | 8.5 / 9.0                              |
| MySQL Server    | 5.7 or higher                          |
| MySQL Workbench | Optional, for database GUI             |
| Eclipse IDE     | Optional, for developer use            |
| Web Browser     | Chrome / Firefox recommended           |

---

## 🚀 How to Run with Eclipse (for Developers)

### 1️⃣ Import Project into Eclipse

1. Open Eclipse (EE version)
2. Go to: `File → Import → Existing Projects into Workspace`
3. Browse and select the `BusManagementSystem` folder
4. Click **Finish**

---

### 2️⃣ Configure Apache Tomcat in Eclipse

1. Go to: `Servers` tab → Right Click → `New → Server`
2. Select `Apache → Tomcat v9.0` → Browse to your Tomcat installation folder
3. Add the `BusManagementSystem` project to the server

---

### 3️⃣ Set Up MySQL Database

1. Open MySQL Workbench
2. Go to: `Server → Data Import`
3. Select: `Import from Self-Contained File`
4. File: Select `bus_management.sql`
5. Default Target Schema: `bus_management`
6. ✅ Check: "Create Schema if it does not exist"
7. Click **Start Import**

---

### 4️⃣ Configure DB Connection in Code

In your JSP/Servlet DB config file (e.g., `dbconfig.jsp`):

```jsp
<%
    String url = "jdbc:mysql://localhost:3306/bus_management";
    String user = "root";
    String password = "your_mysql_password";
%>
````

---

### 5️⃣ Run the Project

* Start the server from Eclipse (`Right-click → Start`)
* Visit: `http://localhost:8080/BusManagementSystem/`

---

## 🌐 How to Run Without Eclipse (for Non-Technical Users)

> Use this method if you want to run the project directly with Tomcat and MySQL, without using any IDE.

---

### 🔁 Step 1: Install Required Software

* [Java JDK](https://www.oracle.com/java/technologies/javase-downloads.html)
* [Apache Tomcat 9.0](https://tomcat.apache.org/download-90.cgi)
* [MySQL Server](https://dev.mysql.com/downloads/)
* [MySQL Workbench (Optional)](https://dev.mysql.com/downloads/workbench/)

---

### 📂 Step 2: Set Up the Database

1. Open MySQL Workbench
2. Go to: `Server → Data Import`
3. Select: `Import from Self-Contained File`
4. File: Choose `bus_management.sql`
5. Schema Name: `bus_management`
6. ✅ Check: “Create Schema if it does not exist”
7. Click **Start Import**

---

### 📦 Step 3: Deploy WAR File

1. Copy the file `BusManagementSystem.war` (exported from Eclipse)
2. Paste it into:
   `C:\apache-tomcat-9.0.xx\webapps\`

---

### ▶️ Step 4: Start Tomcat Server

1. Open: `C:\apache-tomcat-9.0.xx\bin\`
2. Double-click: `startup.bat`

---

### 🌐 Step 5: Access Project in Browser

Open browser and go to:

```
http://localhost:8080/BusManagementSystem/
```

---

## 👤 Default Admin Credentials

| Role  | Email                                 | Password |
| ----- | ------------------------------------- | -------- |
| Admin | [admin@bus.com](mailto:admin@bus.com) | admin123 |
| User  | [user@bus.com](mailto:user@bus.com)   | user123  |

> You can change these credentials directly in the MySQL `users` table.

---

## 💡 Tips

* Create a desktop shortcut for `startup.bat` for quick start
* Bookmark the portal URL in the browser
* Make sure MySQL service is running before starting Tomcat

---

## 📞 Support

**Developer**: Abdu Rehman
**Email**: [your-email@example.com](mailto:your-email@example.com)

---

## 🧾 License

This project is for educational and demo purposes only. Not for commercial use without permission.

```

---

Agar aap chahein to main aap ke liye **Bus Management System** ka WAR file + SQL file + yeh README ek **ZIP package** mein bana ke step-by-step setup ready kar doon, taake non-technical user ko sirf double-click karke chalana ho.  

Kya aap chahte hain main ye ZIP packaging ka guide bana doon?
```
