<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Addtotable.aspx.cs" Inherits="ApplicationState.Addtotable" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Add to table</title>
    <link rel="icon" href="./img/Dotnet.png" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
    <!-- Bootstrap CSS from CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #eceff1;
        }

        .container {
            padding: 20px;
        }

        p {
            font-size: 16px;
        }

        .form {
            background-color: white;
            width: 890px;
            margin: auto;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }

        .Btn-submit {
            padding: 10px;
            background-color: #3d5afe;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .Btn-clear {
            height: 40px;
            width: 80px;
            padding: 10px;
            background-color: #ff3d00;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .output-box {
            margin-top: 20px;
            width: 100%;
            background-color: white;
            padding: 20px;
            border-radius: 10px;
        }

        table {
            width: 100%;
        }

        .quantity-btn {
            padding: 5px;
            background-color: #eceff1;
            border: none;
            cursor: pointer;
        }

        .action-btn {
            padding: 5px 10px;
            background-color: #3d5afe;
            color: white;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }

        .delete-btn {
            background-color: #d50000;
        }

        /* Product styles */
        .product-item {
            text-align: center;
            margin-bottom: 20px;
        }

        #Colgate, #Palmolive, #Gatorade, #HeadShoulder {
            height: 100px;
            width: 100px;
            margin: 2px;
            padding: 5px;
            border-radius: 10px;
        }

        .quantity-btn {
            padding: 5px 10px;
            background-color: #3d5afe;
            color: white;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }

    </style>
</head>
<body>
    <div class="container">
        <form id="Form1" class="form" runat="server">
            <h2 class="text-center">Items Available</h2>
            <div class="row text-center">
                <div class="col-md-3 col-sm-6 product-item">
                    <asp:Image ID="Colgate" runat="server" ImageUrl="../img/colgate.jpg" CssClass="img-fluid" />
                    <p>Colgate (Php 25.00)</p>
                    <asp:Button CssClass="action-btn" Text="Add Colgate" runat="server" CommandName="Add" CommandArgument="Colgate,25" OnCommand="AddToCart_Click" />
                </div>
                <div class="col-md-3 col-sm-6 product-item">
                    <asp:Image ID="Palmolive" runat="server" ImageUrl="../img/palmolive.jpg" CssClass="img-fluid" />
                    <p>Palmolive (Php 10.00)</p>
                    <asp:Button CssClass="action-btn" Text="Add Palmolive" runat="server" CommandName="Add" CommandArgument="Palmolive,10" OnCommand="AddToCart_Click" />
                </div>
                <div class="col-md-3 col-sm-6 product-item">
                    <asp:Image ID="Gatorade" runat="server" ImageUrl="../img/gatorade.jpg" CssClass="img-fluid" />
                    <p>Gatorade (Php 35.00)</p>
                    <asp:Button CssClass="action-btn" Text="Add Gatorade" runat="server" CommandName="Add" CommandArgument="Gatorade,35" OnCommand="AddToCart_Click" />
                </div>
                <div class="col-md-3 col-sm-6 product-item">
                    <asp:Image ID="HeadShoulder" runat="server" ImageUrl="../img/head&shoulder.jpg" CssClass="img-fluid" />
                    <p>Head&Shoulder(Php 12.00)</p>
                    <asp:Button CssClass="action-btn" Text="Add Shampoo" runat="server" CommandName="Add" CommandArgument="Head&Shoulder,12" OnCommand="AddToCart_Click" />
                </div>
            </div>
            
            <asp:Button CssClass="Btn-clear" Text="Clear" runat="server" ID="clear" OnClick="clear_Click" />

            <div class="output-box">
                <h2 class="text-center">Cart</h2>
                <asp:GridView ID="Gv1" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered" OnRowCommand="Gv1_RowCommand" OnRowDeleting="Gv1_RowDeleting">
                    <Columns>
                        <asp:BoundField DataField="Product_number" HeaderText="Product Number" />
                        <asp:BoundField DataField="Product_name" HeaderText="Product Name" />
                        <asp:TemplateField HeaderText="Quantity">
                            <ItemTemplate>
                                <button class="quantity-btn" type="button" onclick="decrementQty('<%# Eval("Product_number") %>')">-</button>
                                <asp:Label ID="lblQty" runat="server" Text='<%# Eval("Quantity") %>'></asp:Label>
                                <button class="quantity-btn" type="button" onclick="incrementQty('<%# Eval("Product_number") %>')">+</button>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Total" HeaderText="Subtotal" />
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:Button ID="Button2" CssClass="action-btn delete-btn" Text="Delete" runat="server" CommandName="Delete" CommandArgument='<%# Eval("Product_number") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <div id="total-container">
                    <h3>Total: <asp:Label ID="lblTotal" runat="server" Text="0"></asp:Label></h3>
                </div>
            </div>
        </form>
    </div>
    <!-- Bootstrap JS from CDN -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script>
        function incrementQty(productNumber) {
            __doPostBack('IncrementQty', productNumber);
        }

        function decrementQty(productNumber) {
            __doPostBack('DecrementQty', productNumber);
        }
    </script>
</body>
</html>
