package controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.CustomerDAO;
import model.Customer;

@Controller
public class CustomerController {
	static CustomerDAO c = new CustomerDAO();
	
	@RequestMapping("/")
	public String index() {
		return "index";
	}
	
	@RequestMapping(value = "/list", method = RequestMethod.GET, produces  = "application/json;charset=UTF-8")
	@ResponseBody
	public List<Customer> showAllDataToRestfulAPI() {
		return c.getAll();
	}
	
	@RequestMapping(value = "/delete/{id}", method = RequestMethod.DELETE, produces  = "application/json;charset=UTF-8")
	@ResponseBody
	// @PathVariable: truyền đường dẫn
	public int deleteCustomer(@PathVariable int id) {
		c.delete(id);
		return 1;
	}
	
	@RequestMapping(value = "/add", method = RequestMethod.POST, produces  = "application/json;charset=UTF-8")
	@ResponseBody
	public Customer addCustomer(@RequestBody Customer customer) {
		c.add(customer);
		return customer;
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.PUT, produces  = "application/json;charset=UTF-8")
	@ResponseBody
	public Customer updateCustomer(@RequestBody Customer customer) {
		c.update(customer);
		return customer;
	}
	
}