<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Detailstotable.aspx.cs" Inherits="ApplicationState.Detailstotable" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Details to table</title>
    <link rel="icon" href="./img/Dotnet.png" />
    <style>
        body {
            background-color: #eceff1;
        }
        table {
            margin-top: 20px;
            border-collapse: collapse;
            width: 100%;
        }
        table, th, td {
            border: 1px solid black;
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <div class="container" runat="server">
        <form id="form1" runat="server">
            <div>
                <asp:Label AssociatedControlID="Name" Text="Name:" runat="server"></asp:Label>
                <asp:TextBox ID="Name" runat="server"></asp:TextBox>
            </div>
            <div>
                <asp:Label AssociatedControlID="Address" Text="Address:" runat="server"></asp:Label>
                <asp:TextBox ID="Address" runat="server"></asp:TextBox>
            </div>
            <div>
                <asp:Label AssociatedControlID="Age" Text="Age:" runat="server"></asp:Label>
                <asp:TextBox ID="Age" runat="server"></asp:TextBox>
            </div>
            <div class="gender" runat="server">
                <asp:Label Text="Gender:" runat="server"></asp:Label><br />
                <asp:RadioButton ID="rdoMale" GroupName="GenderGroup" Text="Male" runat="server" />
                <asp:RadioButton ID="rdoFemale" GroupName="GenderGroup" Text="Female" runat="server" />
            </div>
            <div>
                <asp:Button ID="SubmitButton" Text="Save" runat="server" OnClick="SubmitButton_Click" />
            </div>
        </form>

        <!-- Table output -->
        <div class="table" runat="server">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Address</th>
                        <th>Age</th>
                        <th>Gender</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="DetailsRepeater" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td><%# Eval("ID") %></td>
                                <td><%# Eval("Name") %></td>
                                <td><%# Eval("Address") %></td>
                                <td><%# Eval("Age") %></td>
                                <td><%# Eval("Gender") %></td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
