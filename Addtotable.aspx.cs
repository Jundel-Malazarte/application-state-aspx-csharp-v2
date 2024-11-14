using System;
using System.Data;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ApplicationState
{
    public partial class CartPage : Page
    {
        private static int productCounter = 1; // Counter for product numbers

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
            DataTable table = new DataTable();
            table.Columns.Add("ProductNumber", typeof(int));
            table.Columns.Add("ProductName", typeof(string));
            table.Columns.Add("Quantity", typeof(int));
            table.Columns.Add("Price", typeof(decimal));
            table.Columns.Add("Total", typeof(decimal));
            return table;
        }

        private void BindCartTable()
        {
            DataTable cartTable = Application["CartTable"] as DataTable;
            Repeater.DataSource = cartTable;
            Repeater.DataBind();
            UpdateCartTotal(cartTable); // Update total after binding
        }

        private void UpdateCartTotal(DataTable cartTable)
        {
            decimal totalAmount = cartTable.AsEnumerable().Sum(row => row.Field<decimal>("Total"));
            lblTotal.Text = "Php " + totalAmount.ToString("N2");
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
                existingRow["Total"] = price * (currentQty + 1);
            }
            else
            {
                DataRow newRow = cartTable.NewRow();
                newRow["ProductNumber"] = productCounter++;
                newRow["ProductName"] = productName;
                newRow["Quantity"] = 1;
                newRow["Price"] = price;
                newRow["Total"] = price;
                cartTable.Rows.Add(newRow);
            }
            BindCartTable();
        }

        protected void Clear_Click(object sender, EventArgs e)
        {
            Application["CartTable"] = CreateCartTable();
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

        private void UpdateQuantity(string productInfo, int change)
        {
            string[] productData = productInfo.Split(',');
            int productNumber = int.Parse(productData[0]);
            DataTable cartTable = Application["CartTable"] as DataTable;

            DataRow row = cartTable.AsEnumerable()
                .FirstOrDefault(r => r.Field<int>("ProductNumber") == productNumber);

            if (row != null)
            {
                int currentQty = row.Field<int>("Quantity");
                decimal price = row.Field<decimal>("Price");

                int newQty = currentQty + change;
                if (newQty > 0)
                {
                    row["Quantity"] = newQty;
                    row["Total"] = newQty * price;
                }
                else
                {
                    cartTable.Rows.Remove(row);
                }
            }
            BindCartTable();
        }

        protected void DeleteProduct(object sender, CommandEventArgs e)
        {
            int productNumber = int.Parse(e.CommandArgument.ToString());
            DataTable cartTable = Application["CartTable"] as DataTable;

            DataRow row = cartTable.AsEnumerable()
                .FirstOrDefault(r => r.Field<int>("ProductNumber") == productNumber);

            if (row != null)
            {
                cartTable.Rows.Remove(row);
            }
            BindCartTable();
        }
    }
}