package controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import dao.CustomerDAO;
import model.Customer;

@RestController
public class CustomerController {
	static CustomerDAO c = new CustomerDAO();

//	@RequestMapping(value = "/", method = RequestMethod.GET)
//	public ModelAndView index() {
//		return new ModelAndView("index");
//	}

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView homePage() {
		ModelAndView mav = new ModelAndView("index");
		return mav;
	}

	@RequestMapping(value = "/list", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public List<Customer> showAllDataToRestfulAPI() {
		return c.getAll();
	}

	@RequestMapping(value = "/delete/{id}", method = RequestMethod.DELETE, produces = "application/json;charset=UTF-8")
	@ResponseBody
	// @PathVariable: truyền đường dẫn
	public int deleteCustomer(@PathVariable int id) {
		c.delete(id);
		return id;
	}

	@RequestMapping(value = "/add", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public int addCustomer(@RequestBody Customer customer) {
		//System.out.println("abckld");
		try {
			c.add(customer);
			return 1;
		} catch (Exception e) {
			return 0;
		}

	}

	@RequestMapping(value = "/update", method = RequestMethod.PUT, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Customer updateCustomer(@RequestBody Customer customer) {
		c.update(customer);
		return customer;
	}

}