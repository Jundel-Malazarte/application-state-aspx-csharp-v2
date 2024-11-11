<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Addtotable.aspx.cs" Inherits="ApplicationState.CartPage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Add to table</title>
    <link rel="icon" href="./img/Dotnet.png" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
    <!-- <link rel="stylesheet" href="" /> -->
</head>
    <style>
        * {
            margin: 0;
            padding: 0;
        }

        body {
         font-family: 'Poppins', sans-serif;
         background-color: #eceff1;
        }
        /* Container Style */
        .container {
            padding: 20px;
        }

        p {
            font-size: 16px; /*Standard*/
        }

        /*Image container height */
        .col-md-3 col-sm-6 product-item {
            height: 250px;
            width: 300px;
        }
        
        /** Form style  */
        .container {
            background-color: white;
            width: 890px;
            margin: auto;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            /* Center */
            margin-top: 10%;
        }

        /** Button submit  */
        .action-btn {
            padding: 10px;
            background-color: #304ffe;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        /* clear button */
        .Btn-clear {
            height: 40px;
            width: 80px;
            margin-top: 20px;
            padding: 10px;
            background-color: #ff3d00;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        /* output box - table syle */ 
        .output-box {
            margin-top: 20px;
            width: 100%;
            background-color: white;
            padding: 20px;
            border-radius: 10px;
        }
        /* Table style */
        table {
            width: 100%;
        }
        /* Button decrement */
        .btn-decrement {
            padding: 5px 10px;
            background-color: #ff6e40;
            color: white;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }

        .btn-increment {
            padding: 5px 10px;
            background-color: #304ffe;
            color: white;
            border: none;
            cursor: pointer;
        }

        .btn-delete {
            padding: 5px 10px;
            background-color: #d50000;
            color: white;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }

        /*For btn-action add hover */
        .action-btn:hover {
            background-color: #304ffe;
            opacity: 0.8;
        }

        /*For bnt-clear hover */
        .Btn-clear:hover {
            background-color: #ff3d00;
            opacity: 0.8;
        }

        /*For decrement hover */
        .btn-decrement:hover {
            background-color: #ff6e40;
            opacity: 0.8;
        }
        /*For increment hover */
        .btn-increment:hover { 
            background-color: #304ffe;
            opacity: 0.8;
        }

        /*For delete hover */
        .btn-delete:hover {
            background-color: #d50000;
            opacity: 0.8;
        }

        /* Active btn-action add */
        .action-btn:active {
            background-color: #304ffe;
            opacity: 150%;
            box-shadow: 2px 2px 2px 2px #304ffe;
        }

        /* Active btn-clear */
        .Btn-clear:active {
            background-color: #ff3d00;
            opacity: 150%;
            box-shadow: 2px 2px 2px 2px #ff3d00;
        }
        /* Active btn-decrement */
        .btn-decrement:active {
            background-color: #ff6e40;
            opacity: 100%;
            box-shadow: 2px 2px 2px 2px #ff6e40;
        }
        /* Active btn-increment */
        .btn-increment:active {
            background-color: #304ffe;
            opacity: 100%;
            box-shadow: 2px 2px 2px 2px #304ffe;
        }
        /* Active btn-delete */
        .btn-delete:active {
            background-color: #d50000;
            opacity: 100%;
            box-shadow: 2px 2px 2px 2px #d50000;
        }
        
    </style>
<body>
    <form id="Form1" runat="server" class="form">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true" />

        <div class="container">
            <h2 class="text-center">Items Available</h2>
            <br />
            <div class="row text-center">
                <div class="col-md-3 col-sm-6 product-item">
                    <asp:Image ID="Colgate" runat="server" ImageUrl="../img/colgate.jpg" CssClass="img-fluid" />
                    <p>Colgate (25.00)</p>
                    <asp:Button CssClass="action-btn" Text="Add Colgate" runat="server" CommandName="Add" CommandArgument="Colgate,25" OnCommand="AddToCart_Click" />
                </div>
                <div class="col-md-3 col-sm-6 product-item">
                    <asp:Image ID="Palmolive" runat="server" ImageUrl="../img/palmolive.jpg" CssClass="img-fluid" />
                    <p>Palmolive (10.00)</p>
                    <asp:Button CssClass="action-btn" Text="Add Palmolive" runat="server" CommandName="Add" CommandArgument="Palmolive,10" OnCommand="AddToCart_Click" />
                </div>
                <div class="col-md-3 col-sm-6 product-item">
                    <asp:Image ID="Gatorade" runat="server" ImageUrl="../img/gatorade.jpg" CssClass="img-fluid" />
                    <p>Gatorade (35.00)</p>
                    <asp:Button CssClass="action-btn" Text="Add Gatorade" runat="server" CommandName="Add" CommandArgument="Gatorade,35" OnCommand="AddToCart_Click" />
                </div>
                <div class="col-md-3 col-sm-6 product-item">
                    <asp:Image ID="HeadShoulder" runat="server" ImageUrl="../img/head&shoulder.jpg" CssClass="img-fluid" />
                    <p>Head&Shoulder(12.00)</p>
                    <asp:Button CssClass="action-btn" Text="Add Shampoo" runat="server" CommandName="Add" CommandArgument="Head&Shoulder,12" OnCommand="AddToCart_Click" />
                </div>
            </div>
           <asp:Button CssClass="Btn-clear" Text="Clear" runat="server" ID="clear" OnClick="clear_Click" />

            <div class="output-box">
                <h2 class="text-center">Cart</h2>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
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
                                <asp:Repeater ID="RepeaterCart" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td><%# Eval("ProductNumber") %></td>
                                            <td><%# Eval("ProductName") %></td>
                                            <td>
                                                <!-- Decrement and Increment Buttons -->
                                                <asp:Button ID="btnDecrement" runat="server" Text="-" CommandName="DecrementQty" CommandArgument='<%# Eval("ProductNumber") + ",-1" %>' OnCommand="DecrementQty" CssClass="btn-decrement" />
                                                <span><%# Eval("Quantity") %></span>
                                                <asp:Button ID="btnIncrement" runat="server" Text="+" CommandName="IncrementQty" CommandArgument='<%# Eval("ProductNumber") + ",1" %>' OnCommand="IncrementQty" CssClass="btn-increment" />
                                            </td>
                                            <td><%# "Php " + Eval("Total", "{0:N2}") %></td> 
                                            <td><asp:Button ID="btnDelete" runat="server" Text="Delete" CommandName="DeleteProduct" CommandArgument='<%# Eval("ProductNumber") %>' OnCommand="DeleteProduct" CssClass="btn-delete" /></td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>

            <!-- Move the Total display section outside of the Repeater -->
            <div class="text-center">
                <h3>Total: <span><asp:Label ID="lblTotal" runat="server" Text="0"></asp:Label></span></h3>
            </div>
        </div>
    </form>
    <script>
        // <td><%# Eval("Total", "{0:C}") %></td>
        // increment/decrement
        function updateQuantity(productNumber, change) {
            __doPostBack('IncrementQty', productNumber + ',' + change);
        }

        // for deleting product
        function deleteProduct(productNumber) {
            __doPostBack('DeleteProduct', productNumber);
        }
    </script>
</body>
</html>