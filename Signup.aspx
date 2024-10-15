<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Signup.aspx.cs" Inherits="ApplicationState.Signup" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sign Up</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
    <style>
        body {
            margin: 0;
            background-color: #ECEFF1;
            display: absolute;
            justify-content: center;
            align-items: center;
            height: 100vh;
            font-family: Arial, sans-serif;
            background: url('../img/background.jpg') no-repeat;
            background-size: cover;
            background-position: center;
        }

        #container {
            background-color: white;
            border-radius: 20px;
            height: 400px;
            width: 380px;
            padding: 20px;
            text-align: center;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            box-shadow: 1px 1px 21px 0px rgba(21,21,21,1);
            -webkit-box-shadow: 1px 1px 21px 0px rgba(21,21,21,1);
            -moz-box-shadow: 1px 1px 21px 0px rgba(21,21,21,1);
        }

        #form-box {
            height: 100.5%;
            width: 110%;
            padding-bottom: 70.10px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }


        #header {
            background-color: #00b0ff;
            width: 100.5%;
            height: 100px;
            display: flex;
            font-size: 1rem;
            align-items: center;
            justify-content: center;
            color: #eceff1;
            border-radius: 20px 20px 0 0;
            
        }

        .input-icon {
            display: flex;
            align-items: center;
            width: 100%;
            margin-bottom: 15px;
            position: relative;
        }

        .input-icon i {
            padding: 10px;
            background-color: #00b0ff;
            color: white;
            border-radius: 5px 0 0 5px;
            font-size: 1rem;
        }

        .input-icon input {
            width: 100%;
            padding: 10px;
            border-radius: 0 5px 5px 0;
            border: 1px solid #ccc;
            box-sizing: border-box;
            flex-grow: 1;
        }

        #button-login #add-user {
            width: 100%;
            padding: 10px;
            background-color: #00b0ff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1rem;
        }

        #button-login #add-user:hover {
            background-color: #009be5;
            opacity: 0.8;
        }

        #signin {
            display: flex;
            justify-content: center;
            margin-top: 10px;
            color: #212121;
            text-decoration: none;
            font-size: 0.9rem;
            margin-top: 10px;
        }

        #signin a {
            color: #00b0ff;
            text-decoration: none;
        }
    </style>
<body>
    <!-- Container Box -->
    <div id="container" runat="server">
        <form id="form-box">
            <h3 id="header">SIGN UP FORM</h3>
            <div class="input-text">
                <div class="input-icon">
                    <i class="fas fa-user"></i>
                    <input type="text" id="uname" name="uname" placeholder="Username" required>
                </div>
                <div class="input-icon">
                    <i class="fas fa-envelope"></i>
                    <input type="email" id="email" name="email" placeholder="Email" required>
                </div>
                <div class="input-icon">
                    <i class="fas fa-lock"></i>
                    <input type="password" id="pass" name="password" placeholder="Password" required>
                </div>
                <div class="input-icon">
                    <i class="fas fa-lock"></i>
                    <input type="password" id="confirm-pass" name="confirm-password" placeholder="Confirm Password" required>
                </div>
                </div>
                <!-- Submit Button -->
                <div id="button-login">
                    <input type="submit" id="add-user" name="add" value="Sign Up">
                </div>
                <!-- Sign In Link -->
                <div id="signin">
                    <p>Already have an account? <a href="./Login.aspx" id="signin-link">Sign In</a></p>
                </div>
        </form>
    </div>
</body>
</html>
