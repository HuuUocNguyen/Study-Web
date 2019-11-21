package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.mysql.jdbc.PreparedStatement;

import control.JDBCConnection;
import model.User;

public class UserDAO {
	public static ArrayList<User> getList() throws ClassNotFoundException, SQLException {
		Connection conn = JDBCConnection.getMySQLConnection();
		ArrayList<User> list = new ArrayList<User>();
		String sql = "SELECT * FROM user";
		
		try {
			PreparedStatement ps = (PreparedStatement) conn.prepareCall(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				User user = new User();
				user.setId(rs.getInt("id"));
				user.setName(rs.getString("name"));
				list.add(user);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		//Connection conn = JDBCConnection.getMySQLConnection();
		for(int i=0; i<UserDAO.getList().size(); i++) {
			System.out.println(UserDAO.getList().get(i).getId()+" "+UserDAO.getList().get(i).getName());
		}
	}
}
