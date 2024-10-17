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

        private void CreateTable()
        {
            tb = new DataTable();
            tb.Columns.Add("Product_number", typeof(int));
            tb.Columns.Add("Product_name", typeof(string));
            tb.Columns.Add("Quantity", typeof(int));
            tb.Columns.Add("Total", typeof(decimal));

            Session["Cart"] = tb;
        }

        protected void clear_Click(object sender, EventArgs e)
        {
            Session["Cart"] = null;
            Gv1.DataSource = null;
            Gv1.DataBind();
            lblTotal.Text = "0";
        }

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

        private void UpdateTotal()
        {
            tb = (DataTable)Session["Cart"];
            decimal total = 0;
            foreach (DataRow row in tb.Rows)
            {
                total += Convert.ToDecimal(row["Total"]);
            }
            lblTotal.Text = total.ToString();
        }
    }
}
