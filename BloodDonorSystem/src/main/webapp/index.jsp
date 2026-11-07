<%@ page language="java" 
    contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%> 
 
<!DOCTYPE html> 
<html> 
 
<head> 
 
<meta charset="UTF-8"> 
 
<title>Blood Donor Finder System</title> 
 
<style> 
 
* { 
    box-sizing: border-box; 
} 
 
body { 
    margin: 0; 
    font-family: Arial, sans-serif; 
 
    min-height: 100vh; 
 
    background: 
        linear-gradient( 
            135deg, 
            #8e0e00, 
            #c31432, 
            #240b36 
        ); 
 
    color: white; 
 
    display: flex; 
    justify-content: center; 
    align-items: center; 
} 
 
.container { 
 
    width: 90%; 
    max-width: 900px; 
 
    text-align: center; 
 
    padding: 60px 40px; 
 
    background: rgba(255,255,255,0.12); 
 
    border: 1px solid rgba(255,255,255,0.25); 
 
    border-radius: 25px; 
 
    backdrop-filter: blur(12px); 
 
    box-shadow: 
        0 15px 40px rgba(0,0,0,0.35); 
} 
 
.icon { 
    font-size: 75px; 
    margin-bottom: 10px; 
} 
 
h1 { 
    font-size: 42px; 
    margin: 10px 0; 
} 
 
.subtitle { 
    font-size: 20px; 
    margin: 15px 0 35px; 
 
    color: #ffe5e5; 
} 
 
.buttons { 
 
    display: flex; 
 
    justify-content: center; 
 
    gap: 20px; 
 
    flex-wrap: wrap; 
} 
 
.btn { 
 
    display: inline-block; 
 
    padding: 14px 35px; 
 
    border-radius: 30px; 
 
    text-decoration: none; 
 
    font-size: 18px; 
 
    font-weight: bold; 
 
    transition: 0.3s; 
 
    min-width: 150px; 
} 
 
.login-btn { 
 
    background: white; 
 
    color: #c31432; 
} 
 
.register-btn { 
 
    background: #c31432; 
 
    color: white; 
 
    border: 2px solid white; 
} 


/* ================= ADMIN LOGIN ================= */

.admin-btn {

    background: #240b36;

    color: white;

    border: 2px solid #ffd6d6;

}

.admin-btn:hover {

    background: white;

    color: #240b36;

}

 
.btn:hover { 
 
    transform: translateY(-4px); 
 
    box-shadow: 
        0 8px 20px rgba(0,0,0,0.3); 
} 


/* ================= ADMIN TEXT ================= */

.admin-text {

    margin-top: 25px;

    font-size: 14px;

    color: #ffe5e5;

}

 
.features { 
 
    display: flex; 
 
    justify-content: center; 
 
    gap: 25px; 
 
    margin-top: 45px; 
 
    flex-wrap: wrap; 
} 
 
.feature { 
 
    width: 200px; 
 
    padding: 20px; 
 
    background: rgba(255,255,255,0.1); 
 
    border-radius: 15px; 
} 
 
.feature-icon { 
 
    font-size: 35px; 
} 
 
.feature h3 { 
 
    margin: 10px 0 5px; 
} 
 
.feature p { 
 
    font-size: 14px; 
 
    color: #f5dada; 
} 
 
.footer { 
 
    margin-top: 35px; 
 
    font-size: 13px; 
 
    color: #eadada; 
} 
 
</style> 
 
</head> 
 
<body> 
 
<div class="container"> 
 
    <div class="icon"> 
        🩸 
    </div> 
 
    <h1> 
        Blood Donor Finder System 
    </h1> 
 
    <p class="subtitle"> 
        Connecting Blood Donors with People in Need 
    </p> 
 
 
    <!-- USER LOGIN & REGISTER BUTTONS --> 
 
    <div class="buttons"> 
 
        <a href="login.jsp" 
           class="btn login-btn"> 
            🔐 Login 
        </a> 
 
        <a href="register.jsp" 
           class="btn register-btn"> 
            📝 Register 
        </a> 
 
    </div>


    <!-- ADMIN LOGIN -->

    <div class="admin-text">

        Are you an administrator?

    </div>

    <div class="buttons" style="margin-top: 12px;">

        <a href="admin-login.jsp"
           class="btn admin-btn">

            🔑 Admin Login

        </a>

    </div>
 
 
    <!-- FEATURES --> 
 
    <div class="features"> 
 
        <div class="feature"> 
 
            <div class="feature-icon"> 
                🔍 
            </div> 
 
            <h3> 
                Find Donors 
            </h3> 
 
            <p> 
                Search for available blood donors easily. 
            </p> 
 
        </div> 
 
 
        <div class="feature"> 
 
            <div class="feature-icon"> 
                ❤️ 
            </div> 
 
            <h3> 
                Save Lives 
            </h3> 
 
            <p> 
                Connect people who need blood with donors. 
            </p> 
 
        </div> 
 
 
        <div class="feature"> 
 
            <div class="feature-icon"> 
                🩸 
            </div> 
 
            <h3> 
                Blood Requests 
            </h3> 
 
            <p> 
                Create and manage blood donation requests. 
            </p> 
 
        </div> 
 
    </div> 
 
 
    <div class="footer"> 
 
        © 2026 Blood Donor Finder System 
 
    </div> 
 
</div> 
 
</body> 
 
</html>