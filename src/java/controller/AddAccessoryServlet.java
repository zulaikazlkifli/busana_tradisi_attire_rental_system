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
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;


@WebServlet("/AddAccessoryServlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 10
)
public class AddAccessoryServlet extends HttpServlet {

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return java.sql.DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/btarsystem",
                "root",
                "root123"
        );
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accessoryID = "ACC" + System.currentTimeMillis();
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String attireID = request.getParameter("attireID");

        // ===== IMAGE UPLOAD =====
        Part imagePart = request.getPart("image");

        if (imagePart == null || imagePart.getSize() == 0) {
            throw new ServletException("No image uploaded");
        }

        // SAFE FILE NAME
        String originalFileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
        String extension = originalFileName.substring(originalFileName.lastIndexOf('.'));
        String fileName = "ACC_" + UUID.randomUUID() + extension;

        // ===== SAVE INSIDE PROJECT (IMPORTANT FIX) =====
        String uploadDirPath =
        getServletContext().getRealPath("/uploads/accessory");
        
        System.out.println(uploadDirPath);
        File uploadDir = new File(uploadDirPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        String fullPath = uploadDirPath + File.separator + fileName;
        System.out.println(fullPath);
        // SAVE FILE
        try (InputStream is = imagePart.getInputStream();
                FileOutputStream fos = new FileOutputStream(fullPath)) {

            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = is.read(buffer)) != -1) {
                fos.write(buffer, 0, bytesRead);
            }
        }

        // SAVE PATH FOR DATABASE
        String imagePath = "accessory/" + fileName;

        // ===== INSERT DATABASE =====
        try (Connection con = getConnection()) {

            String sql = "INSERT INTO accessory(accessoryID, accessoryName, description, pictureURL, price, quantity, attireID) VALUES (?,?,?,?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, accessoryID);
            ps.setString(2, name);
            ps.setString(3, description);
            ps.setString(4, imagePath);
            ps.setDouble(5, price);
            ps.setInt(6, quantity);
            ps.setString(7, attireID);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

        HttpSession session = request.getSession();
        session.setAttribute("msg", "Accessory added successfully!");

        response.sendRedirect("ViewAccessoryOwnerServlet");
    }
}
