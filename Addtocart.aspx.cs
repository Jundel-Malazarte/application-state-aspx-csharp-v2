using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;

namespace ApplicationState
{
    public partial class Addtocart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Retrieve items from Application state and display if they exist
                if (Application["SelectedItems"] != null && Application["TotalAmount"] != null)
                {
                    List<string> selectedItems = (List<string>)Application["SelectedItems"];
                    decimal totalAmount = (decimal)Application["TotalAmount"];
                    DisplaySelectedItems(selectedItems, totalAmount);
                }
            }
        }

        protected void submit_Click(object sender, EventArgs e)
        {
            List<string> selectedItems = new List<string>();
            decimal totalAmount = 0;

            // Loop through checked items in the CheckBoxList and calculate the total amount
            foreach (ListItem item in checkbox.Items)
            {
                if (item.Selected)
                {
                    selectedItems.Add(item.Text);
                    totalAmount += Convert.ToDecimal(item.Value);  // Add item price
                }
            }

            // Save the selected items and total amount in Application state
            Application["SelectedItems"] = selectedItems;
            Application["TotalAmount"] = totalAmount;

            // Display the selected items and total amount in the labels
            DisplaySelectedItems(selectedItems, totalAmount);
        }

        private void DisplaySelectedItems(List<string> items, decimal totalAmount)
        {
            // Clear all labels before displaying new items
            lblcolgate.Text = "";
            lblpalmolive.Text = "";
            lblgatorade.Text = "";
            lblheadShoulder.Text = "";

            // Display the items based on what was selected
            foreach (string item in items)
            {
                if (item.Contains("Colgate"))
                {
                    lblcolgate.Text = item;
                }
                else if (item.Contains("Palmolive"))
                {
                    lblpalmolive.Text = item;
                }
                else if (item.Contains("Gatorade"))
                {
                    lblgatorade.Text = item;
                }
                else if (item.Contains("Head&Shoulder"))
                {
                    lblheadShoulder.Text = item;
                }
            }

            // Display total amount
            lblTotal.Text = totalAmount.ToString("F2"); // Format as 2 decimal places
        }

        // Clear button function
        protected void clear_Click(object sender, EventArgs e)
        {
            // Clear application state
            Application["SelectedItems"] = null;
            Application["TotalAmount"] = null;

            // Clear the checkbox selections
            foreach (ListItem item in checkbox.Items)
            {
                item.Selected = false;
            }

            // Clear the output labels
            lblcolgate.Text = "";
            lblpalmolive.Text = "";
            lblgatorade.Text = "";
            lblheadShoulder.Text = "";
            lblTotal.Text = "";

            // Optionally, you can also clear any other state or values if needed
        }
    }
}
