package welcom;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet(urlPatterns= {"/hello-servlet"})
public class HelloServlet extends HttpServlet {
	@Override
	public void init() throws ServletException {
		System.out.println("<h1>Welcom Home, tao là trang chủ");
		System.out.println("bat dau servlet");
	}

	@Override
	public void destroy() {
		System.out.println("ket thuc servlet");
	}

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		super.service(req, resp);
		System.out.println("phuong thuc cua request" +req.getMethod());
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html");
		PrintWriter printWriter = resp.getWriter();
		printWriter.println("<h1>Welcom Home, tao là trang chủ");
		printWriter.close();
	}
}
