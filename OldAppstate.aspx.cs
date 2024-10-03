using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ApplicationState
{
    public partial class OldAppstate : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Clear Application state on initial page load (refresh)
                Application["IDNumber"] = null;
                Application["Firstname"] = null;
                Application["Lastname"] = null;
                Application["Course"] = null;

                LoadCourse();
            }
        }

        // Load courses in the dropdown list
        public void LoadCourse()
        {
            ListItem cc1 = new ListItem("BSCrim");
            ListItem cc2 = new ListItem("BSIT");
            ListItem cc3 = new ListItem("BSCS");
            ListItem cc4 = new ListItem("BSIS");
            ListItem cc5 = new ListItem("BSCPE");
            ListItem cc6 = new ListItem("BSED");
            ListItem cc7 = new ListItem("BEED");

            courselist.Items.Add(cc1);
            courselist.Items.Add(cc2);
            courselist.Items.Add(cc3);
            courselist.Items.Add(cc4);
            courselist.Items.Add(cc5);
            courselist.Items.Add(cc6);
            courselist.Items.Add(cc7);
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            int idNumber;
            string firstName = TextBox1.Text;
            string lastName = TextBox2.Text;

            // Server-side validation for numeric ID number
            if (!int.TryParse(TextBox0.Text, out idNumber))
            {
                lblidnumber.Text = "Invalid ID Number. Please enter digits only.";
                return; // Exit the method without saving
            }

            // Server-side validation for letters only in First Name and Last Name
            if (!System.Text.RegularExpressions.Regex.IsMatch(firstName, @"^[A-Za-z]+$"))
            {
                lblfirstname.Text = "First Name can only contain letters.";
                return;
            }

            if (!System.Text.RegularExpressions.Regex.IsMatch(lastName, @"^[A-Za-z]+$"))
            {
                lbllastname.Text = "Last Name can only contain letters.";
                return;
            }

            // Save the input data into Application state
            Application["IDNumber"] = idNumber.ToString();
            Application["Firstname"] = firstName;
            Application["Lastname"] = lastName;
            Application["Course"] = courselist.SelectedItem.Text;

            // Display the values in labels in the output box
            lblidnumber.Text = "ID Number: " + Application["IDNumber"].ToString();
            lblfirstname.Text = "Firstname: " + Application["Firstname"].ToString();
            lbllastname.Text = "Lastname: " + Application["Lastname"].ToString();
            lblcourse.Text = "Course: " + Application["Course"].ToString();

            // Show the output box
            outputBox.Visible = true;
        }

        // Clear the fields when the clear button is clicked
        protected void ButtonClear_Click(object sender, EventArgs e)
        {
            // Clear the input fields
            TextBox0.Text = "";
            TextBox1.Text = "";
            TextBox2.Text = "";
            courselist.SelectedIndex = -1;

            // Hide the output box
            outputBox.Visible = false;
        }
    }
}
