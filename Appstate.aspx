<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Appstate.aspx.cs" Inherits="ApplicationState.Appstate" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Application State Elnet</title>
    <script type="text/javascript">
        function validateForm() {
            var idNumber = document.getElementById('<%= intNum.ClientID %>').value;
            var firstName = document.getElementById('<%= txtFirstName.ClientID %>').value;
            var lastName = document.getElementById('<%= txtLastName.ClientID %>').value;

            var regexID = /^[0-9]+$/; // Regex for digits only for ID number
            var regexName = /^[A-Za-z]+$/; // Regex for letters only of Firstname / Lastname

            // Validate ID Number
            if (!regexID.test(idNumber)) {
                alert("Please enter a valid ID number (digits only).");
                return false; // Prevent form submission
            }

            // Validate First Name
            if (!regexName.test(firstName)) {
                alert("Please enter a valid first name (letters only).");
                return false; // Prevent form submission
            }

            // Validate Last Name
            if (!regexName.test(lastName)) {
                alert("Please enter a valid last name (letters only).");
                return false; // Prevent form submission
            }

            return true; // Allow form submission if all validations pass | return true if the field is correct
        }
    </script>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding: 0;
            margin: 0;
            background-color: #f5f5f5;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            background-color: white;
            height: 450px;
            width: 300px;
            padding: 10px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            border: 1px solid #ccc;
            position: relative;
        }

        #form {
            height: 92%;
            width:86%;
            background-color: #eceff1;
            padding: 20px;
            border-radius: 10px;
        }

        label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }

        .input-field {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            border: none;
            border-radius: 5px;
            box-shadow: 0 0 3px rgba(0, 0, 0, 0.1);
        }

        #ddlCourse {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        #btnSubmit {
            width: 100%;
            padding: 10px;
            background-color: #311b92;
            color: white;
            border: none;
            border-radius: 5px;
            font-weight: bold;
            cursor: pointer;
        }

        #btnSubmit:hover {
            background-color: #4527a0;
        }

        #lblResult {
            margin-top: 15px;
            font-size: 1rem;
            color: #304ffe;
        }

        /* Styling for headings */
        h3 {
            margin: 0;
            font-size: 1.2rem;
            text-align: center;
            color: #311b92;
        }

        .container2 {
            margin-top: 20px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f1f1f1;
        }

        .output-item {
            margin: 5px 0;
        }
    </style>
</head>
<body>
    <div class="container" runat="server" onsubmit="return validateForm();">
        <form id="form" runat="server">
            <h3>Application Form</h3>
            <!-- ID Number -->
            <label for="intNum">ID Number:</label>
            <asp:TextBox ID="intNum" runat="server" MaxLength="10" onkeypress="validateNumberInput(event)" CssClass="input-field"></asp:TextBox>

            <!-- First name -->
            <label for="txtFirstName">First Name:</label>
            <asp:TextBox ID="txtFirstName" runat="server" CssClass="input-field"></asp:TextBox>

            <!-- Last name -->
            <label for="txtLastName">Last Name:</label>
            <asp:TextBox ID="txtLastName" runat="server" CssClass="input-field"></asp:TextBox>

            <!-- Course -->
            <label for="ddlCourse">Course:</label>
            <asp:DropDownList ID="ddlCourse" runat="server" CssClass="input-field">
                <asp:ListItem Value="BSIT">BSIT</asp:ListItem>
                <asp:ListItem Value="BSCS">BSCS</asp:ListItem>
                <asp:ListItem Value="BSIS">BSIS</asp:ListItem>
                <asp:ListItem Value="BSCE">BSCE</asp:ListItem>
                <asp:ListItem Value="BEED">BEED</asp:ListItem>
                <asp:ListItem Value="BSBA">BSBA</asp:ListItem>
                <asp:ListItem Value="BSHM">BSHM</asp:ListItem>
                <asp:ListItem Value="BSME">BSME</asp:ListItem>
                <asp:ListItem Value="BSEE">BSEE</asp:ListItem>
                <asp:ListItem Value="BSCA">BSCA</asp:ListItem>
                <asp:ListItem Value="BSIE">BSIE</asp:ListItem>
            </asp:DropDownList>
            <!-- Address -->
            <label for="txtAddress">Address:</label>
            <asp:TextBox ID="txtAddress" runat="server" CssClass="input-field"></asp:TextBox>
            <!-- Submit Button -->
            <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-primary" OnClick="btnSubmit_Click" />
        </form>

        <!-- Display Submitted Values -->
        <div class="container2" runat="server">
            <div class="output-item"><strong>ID Number:</strong> <asp:Label ID="lblIDNumber" runat="server"></asp:Label></div>
            <div class="output-item"><strong>First Name:</strong> <asp:Label ID="lblFirstName" runat="server"></asp:Label></div>
            <div class="output-item"><strong>Last Name:</strong> <asp:Label ID="lblLastName" runat="server"></asp:Label></div>
            <div class="output-item"><strong>Course:</strong> <asp:Label ID="lblCourse" runat="server"></asp:Label></div>
            <div class="output-item"><strong>Address:</strong> <asp:Label ID="lblAddress" runat="server"></asp:Label></div>
        </div>
    </div>
</body>
</html>
