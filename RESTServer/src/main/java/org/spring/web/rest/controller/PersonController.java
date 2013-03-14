package org.spring.web.rest.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.spring.web.rest.model.Person;
import org.spring.web.rest.service.PersonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

@Controller
@RequestMapping("/")
public class PersonController {

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(
				dateFormat, false));
	}

	@Autowired
	private PersonService personService;

	@RequestMapping(value = "/person/{id}", method = RequestMethod.GET)
	@ResponseBody
	public Person getPerson(@PathVariable("id") Long id) {
		return personService.getPerson(id);
	}

	@RequestMapping(value = "/persons", method = RequestMethod.GET)
	@ResponseBody
	public List<Person> getPersons() {
		return personService.getAllPersons();
	}

	@RequestMapping(value = "/person/", method = RequestMethod.POST)
	public @ResponseBody
	Person createPerson(@RequestBody Person person) {
		return personService.addPerson(person);
	}

	@RequestMapping(value = "/person/{id}", method = RequestMethod.PUT)
	public @ResponseBody
	Person updatePerson(@PathVariable("id") Long id,
			@Valid @RequestBody Person person) {
		person.setId(id);
		Person tempPerson = personService.updatePerson(person);
		return tempPerson;

	}

	@RequestMapping(value = "/person/{id}", method = RequestMethod.DELETE)
	public @ResponseBody
	Person deletePerson(@PathVariable("id") Long id) {
		return personService.deletePerson(id);
	}

	@ExceptionHandler({ EmptyResultDataAccessException.class,
			NullPointerException.class })
	@ResponseStatus(reason = "Reason", value = HttpStatus.NOT_FOUND)
	public void handleEmptyResultDataAccessException(
			EmptyResultDataAccessException ex, HttpServletRequest request) {
		return;
	}
}
