package dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.query.Query;

import model.Customer;

public class CustomerDAO {
	static SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();

	public List<Customer> getAll() {
		Session session = sessionFactory.openSession();
		Query query = session.createQuery("from Customer");
		List<Customer> list = query.list();
		for (Customer customer : list) {
			System.out.println(customer.getId() + " " + customer.getName() + " " + customer.getAddress());
		}
		return list;
	}

	public void delete(int id) {
		Session session = sessionFactory.openSession(); // create session
		try {
			session.beginTransaction(); // create 1 example transaction
			Customer customer = session.load(Customer.class, id); // use method load => save object continuity in database
			session.delete(customer); // use method delete => save object continuity in database
			session.getTransaction().commit(); // send transection
		} catch (Exception e) {
			session.getTransaction().rollback(); // transection rollback
			e.printStackTrace();
		}
	}

	public void add(Customer customer) {
		Session session = sessionFactory.openSession();
		try {
			session.beginTransaction();
			session.save(customer);
			session.getTransaction().commit();
		} catch (Exception e) {
			session.getTransaction().rollback();
			e.printStackTrace();
		}
	}

	public void update(Customer customer) {
		Session session = sessionFactory.openSession();
		try {

			session.beginTransaction();
			session.update(customer);
			session.getTransaction().commit();
			session.close();
		} catch (Exception e) {
			session.getTransaction().rollback();
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
		// CustomerDAO customerDAO = new CustomerDAO();
		// customerDAO.delete(5);
		// customerDAO.add(new Customer("Uoc", "Ha Noi"));
		// customerDAO.update(new Customer(7, "GGG", "Ha Noi"));

	}

}
