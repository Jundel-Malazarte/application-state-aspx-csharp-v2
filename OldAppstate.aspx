<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OldAppstate.aspx.cs" Inherits="ApplicationState.OldAppstate" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Application State</title>
    <link rel="icon" href="./img/Dotnet.png" />
    <script type="text/javascript">
        function validateForm() {
            var idNumber = document.getElementById('<%= TextBox0.ClientID %>').value;
            var firstName = document.getElementById('<%= TextBox1.ClientID %>').value;
            var lastName = document.getElementById('<%= TextBox2.ClientID %>').value;

            var regexID = /^[0-9]+$/; // Regex for digits only
            var              * 
                         *              * regexName = /^[A-Za-z]+$/; // Regex for letters only

            if (!regexID.test(idNumber)) {
                alert("Please enter a valid ID number (digits only).");
                return false; // Prevent form submission
            }
            /**
                if (!regexName.test(firstName)) {
                    alert("Please enter letters only for the First Name.");
                    return true;
                }

                if (!regexName.test(lastName)) {
                    alert("Please enter letters only for the Last Name.");
                    return true;
                }
            
            */
            

            return true;
        }
    </script>
</head>
<style>
    /* Main body and form styling */
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        padding: 0px;
        margin: 0px;
    }
    .container {
        background-color: white;
        position: relative;
        padding-top: 50%;
    }
    #form {
        height: 45%;
        width: 20%;
        background-color: #eceff1;
        padding: 30px;
        border-radius: 10px;
        position: absolute;
        border: solid 1px;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
    }

    #Button1 {
        padding: 5px;
        padding-top: 10px;
        border: none;
        border-radius: 5px;
        background-color: #311b92;
        color: white;
        font-weight: bold;
        width: 100px;
        height: 30px;
    }

    #ButtonClear {
        padding: 5px;
        padding-top: 10px;
        border: none;
        border-radius: 5px;
        background-color: #ff3d00; /* Color for clear button */
        color: white;
        font-weight: bold;
        width: 100px;
        height: 30px;
    }

    #TextBox0, #TextBox1, #TextBox2, #courselist {
        height: 25px;
        border-radius: 5px;
        border: none;
    }
    #courselist {
        width: 100px;
        height: 28px;
    }

    /* Styling for the output box */
    .output-box {
        align-content: center;
        align-items: center;
        margin-top: 20px;
        padding: 10px;
        background-color: white;
        border: none;
        border: 0.1px solid #212121;
        border-radius: 5px;
        width: 85%;
        text-align: left;
        font-weight: bold;
    }

    .output-box p {
        margin: 5px 0;
    }

</style>
<body>
    <div class="container" runat="server">
        <form id="form" runat="server" onsubmit="return validateForm();">
            <!-- ID Number field -->
            <asp:Label ID="Label1" runat="server" Text="ID Number"></asp:Label>
            <asp:TextBox ID="TextBox0" runat="server" required></asp:TextBox>
            <br /><br />
            <!-- First name field -->
            <asp:Label ID="Label2" runat="server" Text="First Name"></asp:Label>
            <asp:TextBox ID="TextBox1" runat="server" required></asp:TextBox>
            <br /><br />
            <!-- Last name field -->
            <asp:Label ID="Label3" runat="server" Text="Last Name"></asp:Label>
            <asp:TextBox ID="TextBox2" runat="server" required></asp:TextBox>
            <br /><br />
            <!-- Courses field -->
            <asp:Label ID="Label4" runat="server" Text="Course:"></asp:Label>
            <asp:DropDownList ID="courselist" runat="server"></asp:DropDownList>
            <br /><br />
            <!-- Submit Button -->
            <asp:Button ID="Button1" runat="server" Text="Submit" OnClick="Button1_Click" />
            <!-- Clear Button -->
            <asp:Button ID="ButtonClear" runat="server" Text="Clear" OnClick="ButtonClear_Click" />
            <br /><br />

            <!-- Output box to display submitted data -->
            <div class="output-box" runat="server" id="outputBox" visible="false">
                <p><asp:Label ID="lblidnumber" runat="server" Text="ID Number: "></asp:Label></p>
                <p><asp:Label ID="lblfirstname" runat="server" Text="Firstname: "></asp:Label></p>
                <p><asp:Label ID="lbllastname" runat="server" Text="Lastname: "></asp:Label></p>
                <p><asp:Label ID="lblcourse" runat="server" Text="Course: "></asp:Label></p>
            </div>
        </form>
    </div>
</body>
</html>
