package org.spring.web.rest.service;

import java.util.List;

import org.spring.web.rest.model.Person;

public interface PersonService {

	public List<Person> getAllPersons();
	public Person getPerson(Long id);
	public Person addPerson(Person person);
	public Person updatePerson(Person person);
	public Person deletePerson(Long id);

}
