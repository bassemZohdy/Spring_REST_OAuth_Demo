package org.spring.web.rest.service.impl;

import java.util.List;

import org.spring.web.rest.model.Person;
import org.spring.web.rest.repository.PersonRepository;
import org.spring.web.rest.service.PersonService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PersonServiceImpl implements PersonService {

	@Autowired
	PersonRepository repository;

	public Person getPerson(Long id) {
		return repository.get(id);
	}

	public List<Person> getAllPersons() {
		return repository.findAll();
	}

	public Person addPerson(Person person) {
		Long id = repository.add(person);
		return repository.get(id);
	}

	public Person updatePerson(Person person) {
		repository.update(person);
		return person;
	}

	public Person deletePerson(Long id) {
		Person temp = new Person();
		BeanUtils.copyProperties(repository.get(id), temp);
		repository.delete(id);
		return temp;
	}
}
