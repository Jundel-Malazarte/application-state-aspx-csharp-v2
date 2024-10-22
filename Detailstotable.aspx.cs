using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Configuration;

namespace ApplicationState
{
    public partial class Detailstotable : Page
    {
        // Connection string to the database from Web.config
        // private string connectionString = ConfigurationManager.ConnectionStrings["DetailsDBConnectionString"].ConnectionString;
        private string connectionString = ConfigurationManager.ConnectionStrings["DetailsDBConnectionString"].ConnectionString;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Bind the data to the table when the page first loads
                BindDetailsToTable();
            }
        }

        // Handles the logic when the Submit button is clicked
        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            // Capture the form data
            string name = Name.Text;
            string address = Address.Text;
            string age = Age.Text;
            string gender = rdoMale.Checked ? "Male" : rdoFemale.Checked ? "Female" : "";

            // Ensure that one gender is selected before submission
            if (string.IsNullOrEmpty(gender))
            {
                // Add error message if gender is not selected (optional)
                return;
            }

            // Insert the captured data into the database
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                string query = "INSERT INTO Details (Name, Address, Age, Gender) VALUES (@Name, @Address, @Age, @Gender)";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Name", name);
                    cmd.Parameters.AddWithValue("@Address", address);
                    cmd.Parameters.AddWithValue("@Age", age);
                    cmd.Parameters.AddWithValue("@Gender", gender);
                    cmd.ExecuteNonQuery();
                }
            }

            // Bind the updated list to the table
            BindDetailsToTable();

            // Clear the form fields after submission
            ClearFormFields();
        }

        // Method to bind the details from the database to the table (Repeater control)
        private void BindDetailsToTable()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                string query = "SELECT ID, Name, Address, Age, Gender FROM Details";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        DetailsRepeater.DataSource = dt;
                        DetailsRepeater.DataBind();
                    }
                }
            }
        }

        // Method to clear the form fields after submission
        private void ClearFormFields()
        {
            Name.Text = string.Empty;
            Address.Text = string.Empty;
            Age.Text = string.Empty;
            rdoMale.Checked = false;
            rdoFemale.Checked = false;
        }
    }
}
