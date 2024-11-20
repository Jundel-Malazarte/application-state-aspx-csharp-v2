using System;
using System.Data;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ApplicationState
{
    public partial class CartPage : Page
    {
        private static int productCounter = 1;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Application["CartTable"] == null)
                {
                    Application["CartTable"] = CreateCartTable();
                }
                BindCartTable();
            }
        }

        private DataTable CreateCartTable()
        {
            var table = new DataTable();
            table.Columns.Add("ProductNumber", typeof(int));
            table.Columns.Add("ProductName", typeof(string));
            table.Columns.Add("Quantity", typeof(int));
            table.Columns.Add("Price", typeof(decimal));
            table.Columns.Add("SubTotal", typeof(decimal));
            table.Columns.Add("Total", typeof(decimal)); // Add Total column to match your UI
            return table;
        }

        protected void BindCartTable()
        {
            var cartTable = (DataTable)Application["CartTable"];
            UpdateTotals(cartTable);
            Repeater.DataSource = cartTable;
            Repeater.DataBind();
            UpdateOverallTotal(cartTable);

            // Trigger partial postbacks for UpdatePanels
            UpdatePanel1.Update();
            UpdatePanelTotal.Update();
        }

        private void UpdateTotals(DataTable cartTable)
        {
            foreach (DataRow row in cartTable.Rows)
            {
                // Ensure Total mirrors SubTotal or includes additional logic if needed
                row["Total"] = row.Field<decimal>("SubTotal");
            }
        }

        private void UpdateOverallTotal(DataTable cartTable)
        {
            decimal total = cartTable.AsEnumerable().Sum(row => row.Field<decimal>("SubTotal"));
            lblTotal.Text = "Php " + total.ToString("N2");
        }

        protected void AddToCart_Click(object sender, CommandEventArgs e)
        {
            var args = e.CommandArgument.ToString().Split(',');
            string productName = args[0];
            decimal price = Convert.ToDecimal(args[1]);

            var cartTable = (DataTable)Application["CartTable"];
            var row = cartTable.AsEnumerable().FirstOrDefault(r => r.Field<string>("ProductName") == productName);

            if (row != null)
            {
                int currentQuantity = Convert.ToInt32(row["Quantity"]);
                row["Quantity"] = currentQuantity + 1;
                row["SubTotal"] = (currentQuantity + 1) * price;
            }
            else
            {
                cartTable.Rows.Add(productCounter++, productName, 1, price, price, price);
            }

            Application["CartTable"] = cartTable;
            BindCartTable(); // Refresh the cart and total
        }

        protected void UpdateQuantity_Click(object sender, CommandEventArgs e)
        {
            var args = e.CommandArgument.ToString().Split(',');
            int productNumber = Convert.ToInt32(args[0]);
            int change = Convert.ToInt32(args[1]);

            var cartTable = (DataTable)Application["CartTable"];
            var row = cartTable.AsEnumerable().FirstOrDefault(r => r.Field<int>("ProductNumber") == productNumber);

            if (row != null)
            {
                int newQuantity = row.Field<int>("Quantity") + change;

                if (newQuantity <= 0)
                {
                    cartTable.Rows.Remove(row);
                }
                else
                {
                    row["Quantity"] = newQuantity;
                    row["SubTotal"] = newQuantity * row.Field<decimal>("Price");
                }
            }

            Application["CartTable"] = cartTable;
            BindCartTable(); // Refresh the cart and total
        }

        protected void DeleteProduct_Click(object sender, CommandEventArgs e)
        {
            int productNumber = Convert.ToInt32(e.CommandArgument);

            var cartTable = (DataTable)Application["CartTable"];
            var row = cartTable.AsEnumerable().FirstOrDefault(r => r.Field<int>("ProductNumber") == productNumber);

            if (row != null)
            {
                cartTable.Rows.Remove(row);
            }

            Application["CartTable"] = cartTable; // Save changes back to Application state
            BindCartTable();

            if (cartTable.Rows.Count == 0)
            {
                lblTotal.Text = "Php 0.00";
            }
        }

        protected void Clear_Click(object sender, EventArgs e)
        {
            Application["CartTable"] = CreateCartTable();
            BindCartTable();
            lblTotal.Text = "Php 0.00"; // Reset total to zero after clearing
        }
    }
}
