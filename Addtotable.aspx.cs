using System;
using System.Collections.Generic;
using System.Data;
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
                CreateTable();
            }
            else
            {
                // Handle the quantity change event from JavaScript
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
            }
        }

        // Method to handle adding items to the cart
        protected void AddToCart_Click(object sender, CommandEventArgs e)
        {
            string[] args = e.CommandArgument.ToString().Split(',');
            string productName = args[0];
            string productPrice = args[1];

            AddRowToTable(productName, productPrice);
            Gv1.DataSource = tb;
            Gv1.DataBind();
            UpdateTotal();
        }

        // Method to add a new row for a selected product
        private void AddRowToTable(string productName, string productPrice)
        {
            tb = (DataTable)Session["Cart"];
            DataRow row = tb.NewRow();
            row["Product_number"] = tb.Rows.Count + 1;
            row["Product_name"] = productName;
            row["Quantity"] = 1;
            row["Total"] = productPrice;
            tb.Rows.Add(row);
            Session["Cart"] = tb;
        }

        // Method to create a new DataTable structure for the cart
        private void CreateTable()
        {
            tb = new DataTable();
            tb.Columns.Add("Product_number", typeof(int));
            tb.Columns.Add("Product_name", typeof(string));
            tb.Columns.Add("Quantity", typeof(int));
            tb.Columns.Add("Total", typeof(decimal));

            Session["Cart"] = tb;
        }

        // Method to clear the cart and reset the table
        protected void clear_Click(object sender, EventArgs e)
        {
            Session["Cart"] = null;
            CreateTable(); // Create a new empty table
            Gv1.DataSource = tb;
            Gv1.DataBind();
            lblTotal.Text = "0";
        }

        // Method to handle incrementing the quantity
        private void IncrementQty(string productNumber)
        {
            tb = (DataTable)Session["Cart"];
            foreach (DataRow row in tb.Rows)
            {
                if (row["Product_number"].ToString() == productNumber)
                {
                    int quantity = Convert.ToInt32(row["Quantity"]);
                    quantity++;
                    row["Quantity"] = quantity;
                    decimal price = Convert.ToDecimal(row["Total"]) / (quantity - 1);
                    row["Total"] = price * quantity;
                }
            }
            Gv1.DataSource = tb;
            Gv1.DataBind();
            UpdateTotal();
        }

        // Method to handle decrementing the quantity
        private void DecrementQty(string productNumber)
        {
            tb = (DataTable)Session["Cart"];
            foreach (DataRow row in tb.Rows)
            {
                if (row["Product_number"].ToString() == productNumber)
                {
                    int quantity = Convert.ToInt32(row["Quantity"]);
                    if (quantity > 1)
                    {
                        quantity--;
                        row["Quantity"] = quantity;
                        decimal price = Convert.ToDecimal(row["Total"]) / (quantity + 1);
                        row["Total"] = price * quantity;
                    }
                }
            }
            Gv1.DataSource = tb;
            Gv1.DataBind();
            UpdateTotal();
        }

        // Method to update the total price in the cart
        private void UpdateTotal()
        {
            tb = (DataTable)Session["Cart"];
            decimal total = 0;
            foreach (DataRow row in tb.Rows)
            {
                total += Convert.ToDecimal(row["Total"]);
            }
            lblTotal.Text = total.ToString("F2");
        }

        // Handle row command actions like Update and Delete
        protected void Gv1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                string productNumber = e.CommandArgument.ToString();
                DeleteProduct(productNumber);
            }
        }

        // Method to delete a product from the cart
        private void DeleteProduct(string productNumber)
        {
            tb = (DataTable)Session["Cart"];
            DataRow rowToDelete = null;
            foreach (DataRow row in tb.Rows)
            {
                if (row["Product_number"].ToString() == productNumber)
                {
                    rowToDelete = row;
                    break;
                }
            }

            if (rowToDelete != null)
            {
                tb.Rows.Remove(rowToDelete);
                // Re-index the Product Numbers
                for (int i = 0; i < tb.Rows.Count; i++)
                {
                    tb.Rows[i]["Product_number"] = i + 1;
                }
                Session["Cart"] = tb;
                Gv1.DataSource = tb;
                Gv1.DataBind();
                UpdateTotal();
            }
        }

        // Handle row deleting event from the GridView
        protected void Gv1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            tb = (DataTable)Session["Cart"];

            // Ensure that the index is valid before attempting to delete the row
            int index = e.RowIndex; // Get the index of the row to delete
            if (index >= 0 && index < tb.Rows.Count)
            {
                tb.Rows[index].Delete(); // Remove the row from the DataTable
                tb.AcceptChanges(); // Commit the changes to the DataTable

                // Re-index the Product Numbers to maintain sequence
                for (int i = 0; i < tb.Rows.Count; i++)
                {
                    tb.Rows[i]["Product_number"] = i + 1;
                }

                // Rebind the updated DataTable to the GridView
                Gv1.DataSource = tb;
                Gv1.DataBind();

                // Update the total after deletion
                UpdateTotal();
            }
            else
            {
                // Optional: You can log an error or display a message if the index is invalid.
            }
        }
    }
}
