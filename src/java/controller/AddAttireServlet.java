/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Paths;
import java.sql.*;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;


@WebServlet("/AddAttireServlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 10
)
public class AddAttireServlet extends HttpServlet {

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/btarsystem",
                "root",
                "root123"
        );
    }

    // 🔥 FUNCTION GENERATE ID (A001, A002)
    private String generateAttireID(Connection con) throws SQLException {

        String sql = "SELECT attireID FROM attire ORDER BY attireID DESC LIMIT 1";
        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            String lastID = rs.getString("attireID"); // contoh A005
            int num = Integer.parseInt(lastID.substring(1)); // buang 'A'
            num++;

            return "A" + String.format("%03d", num);
        }

        return "A001"; // kalau first data
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            // ================== GET FORM DATA ==================
            String attireName = request.getParameter("attireName");
            String category = request.getParameter("category");
            String size = request.getParameter("size");
            String status = request.getParameter("status");
            String description = request.getParameter("description");
            double rentalPrice = Double.parseDouble(request.getParameter("rentalPrice"));

            HttpSession session = request.getSession();
            String ownerID = (String) session.getAttribute("userID");

            // ================== IMAGE ==================
            Part imagePart = request.getPart("image");

            if (imagePart == null || imagePart.getSize() == 0) {
                throw new ServletException("No image uploaded");
            }

            try (Connection con = getConnection()) {

                // 🔥 GENERATE SHORT ID
                String attireID = generateAttireID(con);

                // ================== FILE NAME ==================
                String originalFileName = Paths.get(imagePart.getSubmittedFileName())
                        .getFileName().toString();

                String extension = originalFileName.substring(originalFileName.lastIndexOf('.'));

                String fileName = attireID + "_" + UUID.randomUUID() + extension;

                // ================== UPLOAD PATH ==================
                String uploadDirPath =
                getServletContext().getRealPath("/uploads/attire");

                File uploadDir = new File(uploadDirPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                String fullImagePath = uploadDirPath + File.separator + fileName;

                // ================== SAVE FILE ==================
                try (InputStream is = imagePart.getInputStream();
                     FileOutputStream fos = new FileOutputStream(fullImagePath)) {

                    byte[] buffer = new byte[1024];
                    int bytesRead;
                    while ((bytesRead = is.read(buffer)) != -1) {
                        fos.write(buffer, 0, bytesRead);
                    }
                }

                String imagePath = "attire/" + fileName;
                // ================== INSERT ==================
                String sql = "INSERT INTO attire(attireID, ownerID, attireName, category, size, rental_price, availabilityStatus, imagePath, description) VALUES (?,?,?,?,?,?,?,?,?)";

                PreparedStatement ps = con.prepareStatement(sql);

                ps.setString(1, attireID);
                ps.setString(2, ownerID);
                ps.setString(3, attireName);
                ps.setString(4, category);
                ps.setString(5, size);
                ps.setDouble(6, rentalPrice);
                ps.setString(7, status);
                ps.setString(8, imagePath);
                ps.setString(9, description);

                ps.executeUpdate();
            }

            // ================== SUCCESS ==================
            response.sendRedirect("ViewAttireServlet?msg=added");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("addAttire.jsp?error=1");
        }
    }
}