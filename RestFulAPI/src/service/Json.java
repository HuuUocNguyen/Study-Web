package service;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import control.JDBCConnection;
import dao.UserDAO;
import model.User;

@WebServlet(urlPatterns = {"/json"})
public class Json extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		resp.setContentType("application/json");
		UserDAO userDAO = new UserDAO();
		Gson gson = new Gson();
		PrintWriter printWriter = resp.getWriter();
		try {
			for(int i=0; i<userDAO.getList().size(); i++) {
				printWriter.println(gson.toJson(userDAO.getList().get(i)));
			}
			
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		for (int i = 0; i < UserDAO.getList().size(); i++) {
			System.out.println(UserDAO.getList().get(i).getId() + " " + UserDAO.getList().get(i).getName());
		}
		//System.out.println(UserDAO.getList());
	}
}
