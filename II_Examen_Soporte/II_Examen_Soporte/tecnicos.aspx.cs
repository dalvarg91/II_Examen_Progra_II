using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace II_Examen_Soporte
{
    public partial class tecnicos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LlenarGrid();
            }
        }

        protected void LlenarGrid()
        {
            string constr = ConfigurationManager.ConnectionStrings["Conexion"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM tecnicos"))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            datagrid.DataSource = dt;
                            datagrid.DataBind();
                        }
                    }
                }
            }
        }

        public void alertas(String texto)
        {
            string message = texto;
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append("<script type = 'text/javascript'>");
            sb.Append("window.onload=function(){");
            sb.Append("alert('");
            sb.Append(message);
            sb.Append("')};");
            sb.Append("</script>");
            ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", sb.ToString());

        }

        protected void LlenarGridConsulta()
        {
            string constr = ConfigurationManager.ConnectionStrings["Conexion"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT tecnicoid, nombre, especialidad FROM tecnicos WHERE tecnicoid = " + int.Parse(tcodigo.Text)+""))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            datagrid.DataSource = dt;
                            datagrid.DataBind();
                        }
                    }
                }
            }
        }




        protected void Button1_Click(object sender, EventArgs e)
        {
            if (Clases.tecnicos.Agregar(tnombre.Text, tespecialidad.Text) > 0)
            {
                LlenarGrid();
                alertas("Datos de tecnicos ingresados");
            }
            else
            {
                alertas("Error al ingresar los datos");
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            if (Clases.tecnicos.Modificar(int.Parse(tcodigo.Text), tnombre.Text, tespecialidad.Text) > 0)
            {
                LlenarGrid();
                alertas("Datos de tecnicos actualizados");
            }
            else
            {
                alertas("Error al actualizar los datos");
            }
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            if (Clases.tecnicos.Borrar(int.Parse(tcodigo.Text)) > 0)
            {
                LlenarGrid();
                alertas("Datos borrados");
            }
            else
            {
                alertas("Error al borrar datos");
            }
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            LlenarGridConsulta();
            tcodigo.Text=string.Empty;
        }
    }
}