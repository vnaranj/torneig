package com.partidos;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class PartidosServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<String> partidos = new ArrayList<String>();
        partidos.add("Barcelona - Real Madrid");
        partidos.add("Sevilla - Valencia");
        partidos.add("Atletico de Madrid - Athletic Club");
        partidos.add("Real Sociedad - Betis");
        partidos.add("Villareal - Levante");

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.println("[");
        for (int i = 0; i < partidos.size(); i++) {
            out.println("{\"partido\":\"" + partidos.get(i) + "\"}" + (i != partidos.size() - 1 ? "," : ""));
        }
        out.println("]");
    }
}
