using System;

namespace ApplicationState
{
    public partial class Appstate : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if the application state has data
                if (Application["IDNumber"] != null && Application["FirstName"] != null && Application["LastName"] != null && Application["Course"] != null && Application["Address"] != null)
                {
                    // Populate the form fields with application state values
                    intNum.Text = Application["IDNumber"].ToString();
                    txtFirstName.Text = Application["FirstName"].ToString();
                    txtLastName.Text = Application["LastName"].ToString();
                    ddlCourse.SelectedValue = Application["Course"].ToString();
                    txtAddress.Text = Application["Address"].ToString();

                    // Display the submitted data in the label
                    lblIDNumber.Text = intNum.Text;
                    lblFirstName.Text = txtFirstName.Text;
                    lblLastName.Text = txtLastName.Text;
                    lblCourse.Text = ddlCourse.SelectedItem.Text;
                    lblAddress.Text = txtAddress.Text;
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            // Retrieve the values from the form controls
            string idnumber = intNum.Text;
            string firstName = txtFirstName.Text;
            string lastName = txtLastName.Text;
            string course = ddlCourse.SelectedValue;
            string address = txtAddress.Text;

            // Store values in the application state
            Application["IDNumber"] = idnumber;
            Application["FirstName"] = firstName;
            Application["LastName"] = lastName;
            Application["Course"] = course;
            Application["Address"] = address;

            // Display the submitted data in the label
            lblIDNumber.Text = idnumber;
            lblFirstName.Text = firstName;
            lblLastName.Text = lastName;
            lblCourse.Text = course;
            lblAddress.Text = address;

            // Optionally, you can also redirect after submission to show updated results
            // Response.Redirect("Appstate.aspx");
        }
    }
}
