package com.partidos;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.Gson;
import com.model.Partido;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class PartidosServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public PartidosServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Establece la conexión con la base de datos
        Connection conn = null;
        Statement stmt = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://db:3306/mydatabase";
            conn = DriverManager.getConnection(url, "root", "mypassword");

            // Ejecuta la consulta y almacena los resultados en una lista de objetos Partido
            List<Partido> partidos = new ArrayList<>();
            stmt = conn.createStatement();
            String sql = "SELECT  p.id, p.hora, \n" +
                    "       eq1.id AS equipo1_id, eq1.nombre AS equipo1_nombre, \n" +
                    "       eq2.id AS equipo2_id, eq2.nombre AS equipo2_nombre, \n" +
                    "       p.equipo1_goles, p.equipo2_goles \n" +
                    "   FROM partidos p \n" +
                    "   JOIN equipos eq1 ON p.equipo1_id = eq1.id \n" +
                    "   JOIN equipos eq2 ON p.equipo2_id = eq2.id;";

            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                String id = rs.getString("id");
                String equipo1Id = rs.getString("equipo1_id");
                String equipo2Id = rs.getString("equipo2_id");
                String equipo1 = rs.getString("equipo1_nombre");
                String equipo2 = rs.getString("equipo2_nombre");
                String fecha = rs.getString("hora");
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                Partido partido = new Partido(id, equipo1Id, equipo2Id, equipo1, equipo2, sdf.parse(fecha));
                partidos.add(partido);
            }

            // Convierte la lista de objetos Partido a formato JSON y la envía como
            // respuesta al cliente
            Gson gson = new Gson();
            String json = gson.toJson(partidos);
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print(json);
            out.flush();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } catch (ParseException e) { // si no se formatea bien la fecha
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null)
                    stmt.close();
                if (conn != null)
                    conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

}
