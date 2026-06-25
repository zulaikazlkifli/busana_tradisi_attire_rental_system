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
import java.sql.ResultSet;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;


@WebServlet("/UpdateAccessoryServlet")
@MultipartConfig
public class UpdateAccessoryServlet extends HttpServlet {

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

        String accessoryID = request.getParameter("accessoryID");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String attireID = request.getParameter("attireID");

        String imagePath = "";

        try (Connection con = getConnection()) {

            // ambil image lama dulu
            String oldImage = "";
            PreparedStatement ps1 = con.prepareStatement(
                "SELECT pictureURL FROM accessory WHERE accessoryID=?"
            );
            ps1.setString(1, accessoryID);
            ResultSet rs = ps1.executeQuery();

            if (rs.next()) {
                oldImage = rs.getString("pictureURL");
            }

            // check ada upload baru ke tak
            Part imagePart = request.getPart("image");

            if (imagePart != null && imagePart.getSize() > 0) {

                String originalFileName = Paths.get(
                        imagePart.getSubmittedFileName()
                ).getFileName().toString();

                String extension = originalFileName.substring(
                        originalFileName.lastIndexOf('.')
                );

                String fileName = "ACC_" + UUID.randomUUID() + extension;

                String baseUploadPath = getServletContext().getInitParameter("UPLOAD_BASE");
                String uploadDirPath = baseUploadPath + File.separator + "accessory";

                File uploadDir = new File(uploadDirPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();

                String fullPath = uploadDirPath + File.separator + fileName;

                try (InputStream is = imagePart.getInputStream();
                     FileOutputStream fos = new FileOutputStream(fullPath)) {

                    byte[] buffer = new byte[1024];
                    int bytesRead;

                    while ((bytesRead = is.read(buffer)) != -1) {
                        fos.write(buffer, 0, bytesRead);
                    }
                }

                imagePath = "accessory/" + fileName;

            } else {
                // guna image lama
                imagePath = oldImage;
            }

            // UPDATE DB
            String sql = "UPDATE accessory SET accessoryName=?, description=?, pictureURL=?, price=?, quantity=?, attireID=? WHERE accessoryID=?";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, name);
            ps.setString(2, description);
            ps.setString(3, imagePath);
            ps.setDouble(4, price);
            ps.setInt(5, quantity);
            ps.setString(6, attireID);
            ps.setString(7, accessoryID);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
        
        HttpSession session = request.getSession();
        session.setAttribute("msg", "Accessory updated successfully!");

        response.sendRedirect("ViewAccessoryOwnerServlet");
    }
}