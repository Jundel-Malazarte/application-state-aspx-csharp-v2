 <%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Addtocart.aspx.cs" Inherits="ApplicationState.Addtocart" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add to cart</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
</head>
    <style>
        body {
            font-family: 'Poppins', sans-serif; 
            margin: 0px;
            padding: 0px;
            background-color: #eceff1;
        }
        /* Container style */
        .container {
            padding: 10px;
            padding-top: 50%;
            position: relative;
        }

        /* Form style */
        .form {
            background-color: white;
            height: 52%;
            width: 20%;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            justify-content: center;
            padding: 10px;
            border-radius: 10px;
            border: solid 0.2px;
        }
        .form h2 {
            margin: 10px;
        }

        /* Button Add Item */
        .Btn-submit {
            padding: 10px;
            margin: 5px;
            margin-top: 10px;
            margin-left: 20px;
            background-color: #00c853;
            color: #eceff1;
            border: none;
            border-radius: 5px;
            font-size: 0.8rem;
            font-weight: 700;
            cursor: pointer;
        }
        .Btn-clear {
            width: 80px;
            padding: 10px;
            margin: 5px;
            margin-top: 10px;
            margin-left: 5px;
            background-color: #ff3d00;
            color: #eceff1;
            border: none;
            border-radius: 5px;
            font-size: 0.8rem;
            font-weight: 700;
            cursor: pointer;
        }

        .output-box {
            margin-top: 10px;
            padding: 5px;
            background-color: #f5f5f5;
            border: none;
            border-radius: 5px;
            width: 80%;
            height: 45%;
        }

        .output-box p {
            padding: 2px;
            margin: 2px;
        }

        .output-box h2 {
            margin: 10px;
        }

        .output-box h3 {
            padding: 5px;
            padding-bottom: 10px;
        }
    </style>

<body>
    <div class="container" runat="server">
        <form class="form" runat="server" onsubmit=" return validateForm()">
            <h2>Items Available</h2>
            <br />
            <asp:CheckBoxList ID="checkbox" runat="server">
                <asp:ListItem Value="25">Colgate (Php 25.00)</asp:ListItem>
                <asp:ListItem Value="10">Palmolive (Php 10.00)</asp:ListItem>
                <asp:ListItem Value="35">Gatorade (Php 35.00)</asp:ListItem>
                <asp:ListItem Value="12">Head&Shoulder (Php 12.00)</asp:ListItem>
            </asp:CheckBoxList>
            <asp:Button CssClass="Btn-submit" Text="Add Item" runat="server" ID="submit" OnClick="submit_Click" />
            <asp:Button CssClass="Btn-clear" Text="Clear" runat="server" ID="clear" OnClick="clear_Click" />
            <!-- Output Box -->
            <div class="output-box" runat="server" id="outputBox" visible="true">
                <h2>List of Orders</h2>
                <p><asp:Label ID="lblcolgate" runat="server" Text=""></asp:Label></p>
                <p><asp:Label ID="lblpalmolive" runat="server" Text=""></asp:Label></p>
                <p><asp:Label ID="lblgatorade" runat="server" Text=""></asp:Label></p>
                <p><asp:Label ID="lblheadShoulder" runat="server" Text=""></asp:Label></p>
                <h3>Total: <asp:Label ID="lblTotal" runat="server" Text=""></asp:Label> Php</h3>
            </div>
        </form>
    </div>
</body>
</html>
