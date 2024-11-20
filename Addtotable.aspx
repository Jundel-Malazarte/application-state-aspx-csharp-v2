=<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Addtotable.aspx.cs" Inherits="ApplicationState.CartPage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add to Table</title>
    <link rel="icon" href="img/Dotnet.png" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" />
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #eceff1;
        }
        .container {
            background-color: white;
            width: 890px;
            margin: auto;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            margin-top: 8%;
        }
        .action-btn, .Btn-clear, .btn-decrement, .btn-increment, .btn-delete {
            padding: 10px;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .Btn-clear {
            margin-left: 35px;
            margin-top: 10px;
        }

        .action-btn { background-color: #304ffe; }
        .Btn-clear { background-color: #ff3d00; }
        .btn-decrement { background-color: #ff6e40; }
        .btn-increment { background-color: #304ffe; }
        .btn-delete { background-color: #d50000; }
    </style>
</head>
<body>
    <form id="Form1" runat="server" class="form">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
        <div class="container">
            <h2 class="text-center">Items Available</h2>
            <div class="row text-center">
                <div class="col-md-3 col-sm-6">
                    <asp:Image ID="ColgateImage" runat="server" ImageUrl="img/colgate.jpg" CssClass="img-fluid" />
                    <p>Colgate (25.00)</p>
                    <asp:Button ID="AddColgate" runat="server" CssClass="action-btn" Text="Add Colgate" CommandName="Add" CommandArgument="Colgate,25" OnCommand="AddToCart_Click" />
                </div>
                <div class="col-md-3 col-sm-6">
                    <asp:Image ID="Palmolive" runat="server" ImageUrl="img/palmolive.jpg" CssClass="img-fluid" />
                    <p>Palmolive (10.00)</p>
                    <asp:Button ID="AddPalmolive" runat="server" CssClass="action-btn" Text="Add Palmolive" CommandName="Add" CommandArgument="Palmolive,10" OnCommand="AddToCart_Click" />
                </div>
                <div class="col-md-3 col-sm-6">
                    <asp:Image ID="Gatorade" runat="server" ImageUrl="img/gatorade.jpg" CssClass="img-fluid" />
                    <p>Gatorade (35.00)</p>
                    <asp:Button ID="AddGatorade" runat="server" CssClass="action-btn" Text="Add Gatorade" CommandName="Add" CommandArgument="Gatorade,35" OnCommand="AddToCart_Click" />
                </div>
                <div class="col-md-3 col-sm-6">
                    <asp:Image ID="HeadShoulder" runat="server" ImageUrl="img/head&shoulder.jpg" CssClass="img-fluid" />
                    <p>Head & Shoulder (12.00)</p>
                    <asp:Button ID="AddHeadShoulder" runat="server" CssClass="action-btn" Text="Add Shampoo" CommandName="Add" CommandArgument="Head&Shoulder,12" OnCommand="AddToCart_Click" />
                </div>
            </div>
            <asp:Button ID="ClearCart" runat="server" CssClass="btn-clear" Text="Clear" OnClick="Clear_Click" />
            <div class="output-box">
                <h2 class="text-center">Cart</h2>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Product Number</th>
                                    <th>Product Name</th>
                                    <th>Quantity</th>
                                    <th>Subtotal</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="Repeater" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td><%# Eval("ProductNumber") %></td>
                                            <td><%# Eval("ProductName") %></td>
                                            <td>
                                                <asp:Button ID="DecrementQty" runat="server" Text="-" CssClass="btn-decrement" CommandName="UpdateQty" CommandArgument='<%# Eval("ProductNumber") + ",-1" %>' OnCommand="UpdateQuantity_Click" />
                                                <span><%# Eval("Quantity") %></span>
                                                <asp:Button ID="IncrementQty" runat="server" Text="+" CssClass="btn-increment" CommandName="UpdateQty" CommandArgument='<%# Eval("ProductNumber") + ",1" %>' OnCommand="UpdateQuantity_Click" />
                                            </td>
                                            <td><%# Eval("SubTotal", "Php {0:N2}") %></td>
                                            <td>
                                                <asp:Button ID="DeleteProduct" runat="server" CssClass="btn-delete" Text="Delete" CommandName="Delete" CommandArgument='<%# Eval("ProductNumber") %>' OnCommand="DeleteProduct_Click" />
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
            <h3 class="text-center">
                <asp:UpdatePanel ID="UpdatePanelTotal" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        Total:<asp:Label ID="lblTotal" runat="server" Text="Php 0.00"></asp:Label>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </h3>
        </div>
    </form>
</body>
</html>