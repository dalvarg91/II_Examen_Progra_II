using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;

namespace II_Examen_Soporte.Clases
{
    public class equipos
    {
        public int equipoid { get; set; }
        public string tipoequipo { get; set; }
        public string modelo { get; set; }
        public int usuarioid { get; set; }

        public equipos(string tipoequipo, string modelo, int usuarioid)
        {
            this.tipoequipo = tipoequipo;
            this.modelo = modelo;
            this.usuarioid = usuarioid;
        }

        public static int Agregar(string tipoequipo, string modelo, int usuarioid)
        {
            int retorno = 0;

            SqlConnection Conn = new SqlConnection();
            try
            {
                using (Conn = conectar.obtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("agregarequipo", Conn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.Add(new SqlParameter("@tipoequipo", tipoequipo));
                    cmd.Parameters.Add(new SqlParameter("@modelo", modelo));
                    cmd.Parameters.Add(new SqlParameter("@usuarioid", usuarioid));

                    retorno = cmd.ExecuteNonQuery();
                }
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                retorno = -1;
            }
            finally
            {
                Conn.Close();
            }

            return retorno;

        }
        public static int Modificar(int codigoequipo, string tipoequipo, string modelo, int codigousuario)
        {
            int retorno = 0;

            SqlConnection Conn = new SqlConnection();
            try
            {
                using (Conn = conectar.obtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("modificarequipo", Conn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.Add(new SqlParameter("@codigoequipo", codigoequipo));
                    cmd.Parameters.Add(new SqlParameter("@tipoequipo", tipoequipo));
                    cmd.Parameters.Add(new SqlParameter("@modelo", modelo));
                    cmd.Parameters.Add(new SqlParameter("@codigousuario", codigousuario));

                    retorno = cmd.ExecuteNonQuery();
                }
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                retorno = -1;
            }
            finally
            {
                Conn.Close();
            }

            return retorno;

        }
        public void Consultar() { }
        public static int Borrar(int codigoequipo,int codigousuario)
        {
            int retorno = 0;

            SqlConnection Conn = new SqlConnection();
            try
            {
                using (Conn = conectar.obtenerConexion())
                {
                    SqlCommand cmd = new SqlCommand("borrarequipo", Conn)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    cmd.Parameters.Add(new SqlParameter("@codigoequipo", codigoequipo));
                    cmd.Parameters.Add(new SqlParameter("@codigousuario", codigousuario));

                    retorno = cmd.ExecuteNonQuery();
                }
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                retorno = -1;
            }
            finally
            {
                Conn.Close();
            }

            return retorno;

        }
    }
}