package com.partidos;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
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

public class ResultadoServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public ResultadoServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Establece la conexión con la base de datos
        Connection conn = null;
        PreparedStatement stmt = null;
        try {

            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://db:3306/mydatabase";
            conn = DriverManager.getConnection(url, "root", "mypassword");

            // Obtiene los parámetros del body
            Gson gson = new Gson();
            Partido partido = gson.fromJson(request.getReader(), Partido.class);

            // Prepara la sentencia SQL para hacer el inseesrt
            String sql = "UPDATE partidos SET equipo1_goles = ?, equipo2_goles = ? WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, partido.getGolesLocal());
            stmt.setInt(2, partido.getGolesVisitante());
            stmt.setInt(3, Integer.parseInt(partido.getId()));

            // Ejecuta el insert
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                // Si se ha actualizado correctamente, devuelve un mensaje de éxito
                response.setContentType("text/plain");
                response.setCharacterEncoding("UTF-8");
                PrintWriter out = response.getWriter();
                out.println("Resultado actualizado");
                out.flush();
            } else {
                // Si no se ha actualizado correctamente, devuelve un mensaje de error
                response.setContentType("text/plain");
                response.setCharacterEncoding("UTF-8");
                PrintWriter out = response.getWriter();
                out.println("Error actualizando datos");
                out.flush();
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error SQL");
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
