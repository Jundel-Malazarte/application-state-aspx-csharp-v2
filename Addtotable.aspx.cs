using System;
using System.Data;
using System.Linq;
using System.Web.UI.WebControls;

namespace ApplicationState
{
    public partial class Addtotable : System.Web.UI.Page
    {
        private DataTable tb;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCartFromApplicationState();
            }
            else
            {
                // Handle quantity change event triggered by JavaScript
                string eventTarget = Request["__EVENTTARGET"];
                string eventArgument = Request["__EVENTARGUMENT"];

                if (eventTarget == "IncrementQty")
                {
                    IncrementQty(eventArgument);
                }
                else if (eventTarget == "DecrementQty")
                {
                    DecrementQty(eventArgument);
                }
                else if (eventTarget == "DeleteProduct")
                {
                    RemoveSingleQuantity(eventArgument);
                }
            }
        }

        protected void AddToCart_Click(object sender, CommandEventArgs e)
        {
            string[] args = e.CommandArgument.ToString().Split(',');
            string productName = args[0];
            decimal productPrice = decimal.Parse(args[1]);

            AddRowToTable(productName, productPrice);
            Gv1.DataSource = tb;
            Gv1.DataBind();
            UpdateTotal();
        }

        private void AddRowToTable(string productName, decimal productPrice)
        {
            tb = (DataTable)Application["Cart"] ?? CreateTable();

            DataRow existingRow = tb.AsEnumerable()
                .FirstOrDefault(row => row["Product_name"].ToString() == productName);

            if (existingRow != null)
            {
                int currentQuantity = Convert.ToInt32(existingRow["Quantity"]);
                currentQuantity++;
                existingRow["Quantity"] = currentQuantity;
                existingRow["Total"] = productPrice * currentQuantity;
            }
            else
            {
                DataRow row = tb.NewRow();
                row["Product_number"] = tb.Rows.Count + 1;
                row["Product_name"] = productName;
                row["Quantity"] = 1;
                row["Total"] = productPrice;
                tb.Rows.Add(row);
            }

            Application["Cart"] = tb; // Update Application state with the current cart
        }

        private DataTable CreateTable()
        {
            tb = new DataTable();
            tb.Columns.Add("Product_number", typeof(int));
            tb.Columns.Add("Product_name", typeof(string));
            tb.Columns.Add("Quantity", typeof(int));
            tb.Columns.Add("Total", typeof(decimal));

            Application["Cart"] = tb;
            return tb;
        }

        private void LoadCartFromApplicationState()
        {
            tb = (DataTable)Application["Cart"] ?? CreateTable();
            Gv1.DataSource = tb;
            Gv1.DataBind();
            UpdateTotal();
        }

        protected void clear_Click(object sender, EventArgs e)
        {
            Application["Cart"] = null;
            tb = CreateTable();
            Gv1.DataSource = tb;
            Gv1.DataBind();
            lblTotal.Text = "0";
        }

        private void IncrementQty(string productNumber)
        {
            UpdateQuantity(productNumber, 1);
        }

        private void DecrementQty(string productNumber)
        {
            UpdateQuantity(productNumber, -1);
        }

        private void UpdateQuantity(string productNumber, int change)
        {
            tb = (DataTable)Application["Cart"];
            foreach (DataRow row in tb.Rows)
            {
                if (row["Product_number"].ToString() == productNumber)
                {
                    int quantity = Convert.ToInt32(row["Quantity"]) + change;

                    if (quantity >= 1)
                    {
                        row["Quantity"] = quantity;
                        decimal pricePerItem = Convert.ToDecimal(row["Total"]) / (quantity - change);
                        row["Total"] = pricePerItem * quantity;
                    }
                    break;
                }
            }

            Application["Cart"] = tb;
            Gv1.DataSource = tb;
            Gv1.DataBind();
            UpdateTotal();
        }

        private void UpdateTotal()
        {
            tb = (DataTable)Application["Cart"];
            decimal total = tb.AsEnumerable().Sum(row => Convert.ToDecimal(row["Total"]));
            lblTotal.Text = total.ToString("F2");
        }

        protected void Gv1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                string productNumber = e.CommandArgument.ToString();
                RemoveSingleQuantity(productNumber);
            }
        }

        private void RemoveSingleQuantity(string productNumber)
        {
            tb = (DataTable)Application["Cart"];
            DataRow rowToUpdate = tb.AsEnumerable()
                .FirstOrDefault(row => row["Product_number"].ToString() == productNumber);

            if (rowToUpdate != null)
            {
                int quantity = Convert.ToInt32(rowToUpdate["Quantity"]);

                if (quantity > 1)
                {
                    rowToUpdate["Quantity"] = quantity - 1;
                    decimal pricePerItem = Convert.ToDecimal(rowToUpdate["Total"]) / quantity;
                    rowToUpdate["Total"] = pricePerItem * (quantity - 1);
                }
                else
                {
                    tb.Rows.Remove(rowToUpdate);
                }

                int i = 1;
                foreach (DataRow row in tb.Rows)
                {
                    row["Product_number"] = i++;
                }

                Application["Cart"] = tb;
                Gv1.DataSource = tb;
                Gv1.DataBind();
                UpdateTotal();
            }
        }
    }
}
