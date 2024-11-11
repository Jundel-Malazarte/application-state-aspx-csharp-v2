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
                existingRow["Total"] = (decimal)existingRow["Total"] / currentQty * (currentQty + 1);
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

        private void BindCartTable()
        {
            DataTable cartTable = Application["CartTable"] as DataTable;
            RepeaterCart.DataSource = cartTable;
            RepeaterCart.DataBind();

            decimal total = 0;
            foreach (DataRow row in cartTable.Rows)
            {
                total += (decimal)row["Total"];
            }

            if (lblTotal != null)
            {
                lblTotal.Text = "Php " + total.ToString("N2");
            }
        }

        private DataTable CreateCartTable()
        {
            DataTable cartTable = new DataTable();
            cartTable.Columns.Add("ProductNumber", typeof(int));
            cartTable.Columns.Add("ProductName", typeof(string));
            cartTable.Columns.Add("Quantity", typeof(int));
            cartTable.Columns.Add("Total", typeof(decimal));
            return cartTable;
        }

        protected void IncrementQty(object sender, CommandEventArgs e)
        {
            int productNumber = int.Parse(e.CommandArgument.ToString().Split(',')[0]);
            int change = int.Parse(e.CommandArgument.ToString().Split(',')[1]);
            UpdateQuantity(productNumber, change);
        }

        protected void DecrementQty(object sender, CommandEventArgs e)
        {
            int productNumber = int.Parse(e.CommandArgument.ToString().Split(',')[0]);
            int change = int.Parse(e.CommandArgument.ToString().Split(',')[1]);
            UpdateQuantity(productNumber, change);
        }

        private void UpdateQuantity(int productNumber, int change)
        {
            DataTable cartTable = Application["CartTable"] as DataTable;
            foreach (DataRow row in cartTable.Rows)
            {
                if ((int)row["ProductNumber"] == productNumber)
                {
                    int currentQty = (int)row["Quantity"];
                    int newQty = currentQty + change;
                    if (newQty < 1) newQty = 1; // Ensure quantity doesn't go below 1
                    row["Quantity"] = newQty;
                    row["Total"] = (decimal)row["Total"] / currentQty * newQty; // Update total with new quantity
                    break;
                }
            }
            Application["CartTable"] = cartTable;
            BindCartTable();
        }

        protected void DeleteProduct(object sender, CommandEventArgs e)
        {
            int productNumber = int.Parse(e.CommandArgument.ToString());
            DeleteProductFromCart(productNumber);
        }

        private void DeleteProductFromCart(int productNumber)
        {
            DataTable cartTable = Application["CartTable"] as DataTable;
            foreach (DataRow row in cartTable.Rows)
            {
                if ((int)row["ProductNumber"] == productNumber)
                {
                    cartTable.Rows.Remove(row);
                    break;
                }
            }
            Application["CartTable"] = cartTable;
            BindCartTable();
        }
    }
}
