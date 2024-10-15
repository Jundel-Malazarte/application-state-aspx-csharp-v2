<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ApplicationState.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login page</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
    <style>
        body {
            margin: 0;
            background-color: #ECEFF1;
            position: relative;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            font-family: Arial, sans-serif;
            background: url('../img/background.jpg') no-repeat;
            background-size: cover;
            background-position: center;
        }
        /* Container style */
        #container {
            background-color: white;
            border-radius: 20px;
            width: 380px;
            height: fit-content;
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
            -webkit-box-shadow: 1px 1px 21px 0px rgba(21,21,21,0.74);
            -moz-box-shadow: 1px 1px 21px 0px rgba(21,21,21,1);
        }

        /* Form style */
        #form-box {
            width: 100%;
            height: 282px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            margin-top: 10px;
            margin-bottom: 40px;   
        }

        /*  Header style H1 */
        #header {
            background-color: #00b0ff;
            width: 110.5%;
            height: 90px;
            display: flex;
            font-size: 1rem;
            align-items: center;
            justify-content: center;
            color: #eceff1;
            border-radius: 20px 20px 0 0;
            margin-bottom: 10px;
            padding: 0;
        }

        /* Icon style */
        .input-icon {
            display: flex;
            align-items: center;
            width: 100%;
            margin-bottom: 15px;
            position: relative;
        }
        .input-icon i {
            padding: 10px;
            margin-top: 5px;
            background-color: #00b0ff;
            color: white;
            border-radius: 5px 0 0 5px;
            font-size: 1rem;
        }

        /* Input text style */
        .input-icon input {
            width: 100%;
            padding: 10px;
            border-radius: 0 5px 5px 0;
            border: 1px solid #ccc;
            box-sizing: border-box;
            flex-grow: 1;
        }
        .input-text {
            width: 100%;
            margin-bottom: 15px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .input-text input {
            width: calc(100% - 20px);
            padding: 10px;
            margin-top: 5px;
            border-radius: 5px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        /* Forgot Password Style */
        .options {
            width: 100%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 10px;
            margin-bottom: 15px;
            padding: 0 20px;
        }

        /* Remember me sliding style */
        .remember-me {
            display: flex;
            position: relative;
            color: #212121;
            font-size: 0.9rem;
            align-items: center;
        }

        .forgot-password {
            font-size: 0.9rem;
        }

        .forgot-password a {
            color: #00b0ff;
            text-decoration: none;
        }

        .forgot-password a:hover {
            text-decoration: underline;
        }

        #button-submit {
            width: 100%;
            display: flex;
            justify-content: center;
        }

        #button-login #add-user {
            width: calc(160% - 20px);
            padding: 10px;
            background-color: #00b0ff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1rem;
        }

        #button-login #add-user:hover {
            background-color:  #00b0ff;
            opacity: 0.8;
        }


        /* Remember me slider*/
        .switch {
            position: relative;
            display: inline-block;
            width: 40px;
            height: 20px;
            margin-right: 10px; /* Space between switch and label */
        }

        /* Hide default checkbox */
        .switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }

        /* Slider styling */
        .slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #ccc;
            transition: .4s;
            border-radius: 20px;
        }

        /* Round slider styling */
        .slider.round {
            border-radius: 34px;
        }

        .slider.round:before {
            border-radius: 50%;
        }

        /* Position of the slider's handle */
        .slider:before {
            position: absolute;
            content: "";
            height: 14px;
            width: 14px;
            left: 3px;
            bottom: 3px;
            background-color: white;
            transition: .4s;
            border-radius: 50%;
        }

        /* Change background and position when checked */
        input:checked + .slider {
            background-color: #00b0ff;
        }

        input:checked + .slider:before {
            transform: translateX(20px);
        }

        /* Label styling */
        .remember-me label {
            color: #212121;
            font-size: 0.9rem;
            cursor: pointer;
        }

        #signup {
            display: flex;
            color: #212121;
            text-decoration: none;
            font-size: 0.9rem;
            justify-content: center;
            margin-top: 10px;
        }

        #signup a {
            color: #00b0ff;
            text-decoration: none;
        }
    </style>
    <body>
    <!-- Container Box -->  
    <div id="container" runat="server">
        <form id="form-box">
            <div id="header">
                <h3>LOGIN FORM</h3>
            </div>
            <div class="input-text">
                <div class="input-icon">
                    <i class="fas fa-user"></i>
                    <input type="text" id="uname" name="uname" placeholder="Username" required>
                </div>
                <div class="input-icon">
                    <i class="fas fa-lock"></i>
                    <input type="password" id="pass" name="password" placeholder="Password" required>
                </div>               
                <!-- Login Button -->
                <div id="button-login">
                    <input type="submit" id="add-user" name="add" value="Login">
                </div>
                
                <!-- Remember Me and Forgot Password -->
                <div class="options">
                    <div class="remember-me">
                        <label class="switch">
                            <input type="checkbox" id="checkbox" name="remember">
                            <span class="slider round"></span>
                        </label>
                        <label for="checkbox">Remember Me</label>
                    </div>
                    <div class="forgot-password">
                        <i class="fas fa-question-circle"></i>
                        <a href="#">Forgot Password?</a>
                    </div>                    
                </div>
                <div id="signup">
                    <p>Don't have an account?<a href="./Signup.aspx" id="signup-link"> Sign Up</a></p>
                </div>    
            </div>
        </form>
    </div>
</body>
</html>
    