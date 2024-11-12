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

        protected Repeater RepeaterCart;
        protected Label lblTotal;

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

        protected void clear_Click(object sender, EventArgs e)
        {
            Application["CartTable"] = CreateCartTable();
            BindCartTable();
        }

        protected void AddToCart_Click(object sender, CommandEventArgs e)
        {
            string[] productInfo = e.CommandArgument.ToString().Split(',');
            string productName = productInfo[0];
            decimal price = decimal.Parse(productInfo[1]);

            DataTable cartTable = Application["CartTable"] as DataTable;
            DataRow existingRow = cartTable.Select($"ProductName = '{productName}'").FirstOrDefault();

            if (existingRow != null)
            {
                int currentQty = (int)existingRow["Quantity"];
                existingRow["Quantity"] = currentQty + 1;
                existingRow["Total"] = price * (currentQty + 1); // Recalculate total for the item
            }
            else
            {
                DataRow newRow = cartTable.NewRow();
                newRow["ProductNumber"] = productCounter++;
                newRow["ProductName"] = productName;
                newRow["Quantity"] = 1;
                newRow["Total"] = price;
                cartTable.Rows.Add(newRow);
            }

            Application["CartTable"] = cartTable;
            BindCartTable();
        }

        protected void IncrementQty(object sender, CommandEventArgs e)
        {
            UpdateQuantity(e.CommandArgument.ToString(), 1);
        }

        protected void DecrementQty(object sender, CommandEventArgs e)
        {
            UpdateQuantity(e.CommandArgument.ToString(), -1);
        }

        private void UpdateQuantity(string commandArgument, int change)
        {
            int productNumber = int.Parse(commandArgument.Split(',')[0]);
            DataTable cartTable = Application["CartTable"] as DataTable;

            DataRow row = cartTable.Select($"ProductNumber = {productNumber}").FirstOrDefault();
            if (row != null)
            {
                int currentQty = (int)row["Quantity"];
                int newQty = currentQty + change;

                if (newQty > 0)
                {
                    row["Quantity"] = newQty;
                    decimal price = (decimal)row["Total"] / currentQty;  // Get the price per item
                    row["Total"] = price * newQty;
                }
            }

            Application["CartTable"] = cartTable;
            BindCartTable();
        }

        protected void UpdateProduct(object sender, CommandEventArgs e)
        {
            int productNumber = int.Parse(e.CommandArgument.ToString());
            DataTable cartTable = Application["CartTable"] as DataTable;

            DataRow row = cartTable.Select($"ProductNumber = {productNumber}").FirstOrDefault();
            if (row != null)
            {
                int currentQty = (int)row["Quantity"];
                decimal price = (decimal)row["Total"] / currentQty;  // Get the price per item
                row["Total"] = price * currentQty; // Recalculate the total (even though it's already done in other methods)
            }

            Application["CartTable"] = cartTable;
            BindCartTable();
        }

        protected void DeleteProduct(object sender, CommandEventArgs e)
        {
            int productNumber = int.Parse(e.CommandArgument.ToString());
            DataTable cartTable = Application["CartTable"] as DataTable;

            DataRow row = cartTable.Select($"ProductNumber = {productNumber}").FirstOrDefault();
            if (row != null)
            {
                cartTable.Rows.Remove(row);
            }

            Application["CartTable"] = cartTable;
            BindCartTable();
        }

        private void BindCartTable()
        {
            DataTable cartTable = Application["CartTable"] as DataTable;
            RepeaterCart.DataSource = cartTable;
            RepeaterCart.DataBind();

            // Update the total label after binding
            decimal total = 0;
            foreach (DataRow row in cartTable.Rows)
            {
                total += (decimal)row["Total"];
            }
            lblTotal.Text = "Php " + total.ToString("#,##0.00"); // Ensure formatting (Php without "$")
        }

        private DataTable CreateCartTable()
        {
            DataTable table = new DataTable();
            table.Columns.Add("ProductNumber", typeof(int));
            table.Columns.Add("ProductName", typeof(string));
            table.Columns.Add("Quantity", typeof(int));
            table.Columns.Add("Total", typeof(decimal));
            return table;
        }
    }
}
