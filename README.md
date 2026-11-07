# 🩸 Blood Donor Finder System

### A Java-Based Web Application for Blood Donor Search and Blood Request Management

<p align="center">
  <strong>Developed using Java, JSP, Servlets, JDBC, MySQL and Apache Tomcat</strong>
</p>

---

## 👩‍💻 Project Details

| Detail | Information |
|---|---|
| Project Title | Blood Donor Finder System |
| Developed By | LALAM PADMINI |
| Roll Number | 24VV1A1236 |
| Project Type | Advanced Java Lab Project |
| Frontend | HTML, CSS, JSP |
| Backend | Java, Servlets |
| Database | MySQL |
| Database Connectivity | JDBC |
| IDE | Eclipse IDE for Enterprise Java and Web Developers |
| Server | Apache Tomcat 11 |

---

## 📌 About the Project

The **Blood Donor Finder System** is a web-based application developed to simplify the process of finding blood donors and managing blood donation requests.

The main purpose of this project is to provide a centralized platform where users can register, add their donor details, search for available blood donors based on blood group and city, create blood requests, and respond to pending requests.

The system also provides an administrator module to manage users, donors, blood requests, donor responses, and blood inventory.

This application is developed using Java, JSP, Servlets, JDBC, MySQL, HTML, and CSS. Apache Tomcat is used as the web server to execute the application.

---

## 🎯 Objectives

- To develop an online platform for searching blood donors.
- To maintain donor information in a centralized database.
- To allow users to search donors based on blood group and city.
- To provide a facility for creating and managing blood requests.
- To allow donors to accept or decline blood requests.
- To help users track their blood request status.
- To provide notifications about relevant activities.
- To provide administrative facilities for managing the application.

---

## ✨ Key Features

### 👤 User Module

- User Registration
- User Login and Logout
- User Dashboard
- User Profile Management
- Add Blood Donor Details
- Search Blood Donors
- Search by Blood Group and City
- View Donor Search Results
- Create Blood Requests
- View My Blood Requests
- View Pending Blood Requests
- Accept or Decline Blood Requests
- View Donor Responses
- Notification Management

### 🔐 Administrator Module

- Separate Admin Login
- Admin Dashboard
- Manage Registered Users
- Manage Donor Details
- Manage Blood Requests
- Manage Donor Responses
- Update Blood Request Status
- Manage Blood Inventory
- Update Available Blood Units

---

## 🛠️ Technologies Used

| Technology | Purpose |
|---|---|
| Java | Application backend programming |
| JSP | Dynamic web pages |
| Servlets | Request processing and application control |
| JDBC | Database connectivity |
| MySQL | Data storage and management |
| HTML | Web page structure |
| CSS | Styling and user interface |
| Apache Tomcat 11 | Web application server |
| Eclipse IDE | Development environment |

---

## 🏗️ System Architecture

The application follows a three-layer web application architecture.

```text
             USER / ADMIN
                  |
                  v
             WEB BROWSER
                  |
                  v
          PRESENTATION LAYER
              JSP + HTML
                  |
                  v
           APPLICATION LAYER
          JAVA SERVLETS
                  |
                  v
           DATABASE LAYER
             JDBC
                  |
                  v
              MYSQL
```

### Architecture Description

**1. Presentation Layer**

JSP, HTML, and CSS are used to create the user interface. Users interact with the application through web pages.

**2. Application Layer**

Java Servlets process user requests, perform validations, manage sessions, and communicate with the database.

**3. Database Layer**

MySQL stores user information, donor details, blood requests, donor responses, notifications, and blood inventory information. JDBC is used to establish database connectivity.

---

## 🗄️ Database Management

The application uses MySQL as its database management system.

The database stores information required for user authentication, donor management, blood requests, responses, notifications, and inventory management.

The main database entities include:

- Users
- Donors
- Requests
- Donor Responses
- Admin
- Blood Inventory
- Notifications

**Note:** The exact database name and table definitions should be taken from the SQL scripts used in the project.

---

## 📂 Project Structure

```text
BloodDonorSystem/
│
├── src/
│   └── main/
│       ├── java/
│       │   ├── com.blooddonor.controller/
│       │   │   ├── AddDonorServlet.java
│       │   │   ├── AdminDashboardServlet.java
│       │   │   ├── AdminLoginServlet.java
│       │   │   ├── AdminLogoutServlet.java
│       │   │   ├── BloodInventoryServlet.java
│       │   │   ├── CreateRequestServlet.java
│       │   │   ├── DonorResponseServlet.java
│       │   │   ├── LoginServlet.java
│       │   │   ├── LogoutServlet.java
│       │   │   ├── ManageDonorsServlet.java
│       │   │   ├── ManageRequestsServlet.java
│       │   │   ├── ManageResponsesServlet.java
│       │   │   ├── ManageUsersServlet.java
│       │   │   ├── NotificationServlet.java
│       │   │   ├── ProfileServlet.java
│       │   │   ├── RegisterServlet.java
│       │   │   ├── RespondToRequestServlet.java
│       │   │   ├── SearchDonorServlet.java
│       │   │   ├── UpdateInventoryServlet.java
│       │   │   ├── UpdateRequestStatusServlet.java
│       │   │   └── ViewPendingRequestsServlet.java
│       │   │
│       │   ├── com.blooddonor.model/
│       │   │   ├── BloodInventory.java
│       │   │   ├── BloodRequest.java
│       │   │   ├── Donor.java
│       │   │   ├── DonorResponse.java
│       │   │   ├── Notification.java
│       │   │   └── User.java
│       │   │
│       │   └── com.blooddonor.util/
│       │       └── DBConnection.java
│       │
│       └── webapp/
│           ├── WEB-INF/
│           │   ├── lib/
│           │   └── web.xml
│           │
│           ├── index.jsp
│           ├── register.jsp
│           ├── login.jsp
│           ├── dashboard.jsp
│           ├── add-donor.jsp
│           ├── search-donor.jsp
│           ├── donor-results.jsp
│           ├── create-request.jsp
│           ├── my-requests.jsp
│           ├── pending-requests.jsp
│           ├── donor-response.jsp
│           ├── my-donor-responses.jsp
│           ├── notifications.jsp
│           ├── profile.jsp
│           ├── admin-login.jsp
│           ├── admin-dashboard.jsp
│           ├── manage-users.jsp
│           ├── manage-donors.jsp
│           ├── manage-requests.jsp
│           ├── manage-responses.jsp
│           └── blood-inventory.jsp
│
├── Documentation/
│   ├── Blood_Donor_Finder_System_Presentation_Padmini.pptx
│   └── Blood_Donor_Finder_System_Report.pdf
│
├── .project
├── .classpath
├── .gitignore
└── README.md
```

---

## ⚙️ Software Requirements

- Java Development Kit (JDK)
- Eclipse IDE for Enterprise Java and Web Developers
- Apache Tomcat 11
- MySQL Server
- MySQL Workbench
- MySQL Connector/J
- Web Browser

## 💻 Hardware Requirements

- Computer or Laptop
- Minimum 4 GB RAM
- Sufficient storage space
- Internet connection for downloading required software and accessing GitHub

---

## 🚀 Installation and Execution

Follow these steps to run the project on your local system.

### Step 1: Install Required Software

Install the following software:

1. JDK
2. Eclipse IDE for Enterprise Java and Web Developers
3. Apache Tomcat 11
4. MySQL Server
5. MySQL Workbench

### Step 2: Clone the Repository

Clone this repository using GitHub Desktop or Git:

```bash
git clone https://github.com/lalamp60-max/BloodDonorSystem.git
```

### Step 3: Import Project into Eclipse

1. Open Eclipse IDE.
2. Select **File → Import**.
3. Select **General → Existing Projects into Workspace**, if the project is recognized as a standard Eclipse project.
4. Browse and select the cloned project folder.
5. Click Finish.

If Eclipse does not recognize the project through this option, import it as an existing Dynamic Web Project or configure its project facets according to the included project configuration.

### Step 4: Configure MySQL Database

1. Open MySQL Workbench.
2. Create the database using the database name configured in `DBConnection.java`.
3. Execute the project's SQL table creation scripts.
4. Insert the required initial data if available.

### Step 5: Configure Database Connectivity

Open:

```text
src/main/java/com/blooddonor/util/DBConnection.java
```

Configure the following values according to your local MySQL installation:

- Database URL
- MySQL username
- MySQL password

Ensure that MySQL Connector/J is available in the project's build path and deployment libraries.

### Step 6: Configure Apache Tomcat

1. Open Eclipse.
2. Go to **Window → Show View → Servers**.
3. Add Apache Tomcat 11.
4. Configure the Tomcat installation directory.
5. Add the BloodDonorSystem project to the server.

### Step 7: Run the Application

1. Right-click the project.
2. Select **Run As → Run on Server**.
3. Choose Apache Tomcat 11.
4. Click Finish.
5. Open the application in your browser.

The application entry page is:

```text
http://localhost:8080/BloodDonorSystem/
```

The context path may differ depending on your Eclipse and Tomcat configuration.

---

## 🔄 Working Principle

1. A new user opens the application and registers.
2. The registered user logs in using their credentials.
3. The user accesses the dashboard.
4. A donor can add blood donor details.
5. Users can search for available donors using blood group and city.
6. Users can create blood requests by providing the required information.
7. Donors can view pending requests and accept or decline them.
8. Users can track their requests and view donor responses.
9. Notifications provide updates about relevant activities.
10. Administrators can manage users, donors, requests, responses, and blood inventory.

---

## 📸 Project Screenshots

The application screenshots are included in the project presentation and documentation.

To view the application screens, open the presentation below.

---
## 📚 Project Documentation

### 📄 Project Report (PDF)

[**Click Here to View Project Report (PDF)**](https://github.com/lalamp60-max/BloodDonorSystem/blob/main/Documentation/JavaPDF.pdf)

### 📊 Project Presentation (PPT)

[**Click Here to View Project Presentation (PPT)**](https://github.com/lalamp60-max/BloodDonorSystem/blob/main/Documentation/JAVA.pptx)

---

## 🌟 Advantages

- Provides a centralized donor information system.
- Makes donor searching easier.
- Supports blood request creation and tracking.
- Provides separate user and administrator modules.
- Maintains application data using a MySQL database.
- Demonstrates practical implementation of Advanced Java technologies.

---

## 🔮 Future Enhancements

- Email and SMS notifications.
- Location-based donor searching.
- Improved password security using password hashing.
- Mobile application integration.
- Advanced reporting and analytics.
- Real-time blood availability updates.

---

## 🎓 Academic Project

This project was developed as part of the **Advanced Java Lab** to demonstrate practical knowledge of Java web application development using JSP, Servlets, JDBC, MySQL, and Apache Tomcat.

---

## 👩‍💻 Developer

**LALAM PADMINI**

**Roll Number:** 24VV1A1236

---

## 📜 License

This project is developed for academic and educational purposes.
