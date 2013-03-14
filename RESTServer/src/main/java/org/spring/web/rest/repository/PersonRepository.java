package org.spring.web.rest.repository;

import java.util.HashMap;
import java.util.Map;

import org.spring.web.rest.model.Person;
import org.springframework.jdbc.core.RowMapper;

public interface PersonRepository extends GenericRepository<Long, Person> {

	static final String TABLE_NAME = "PERSON";

	static final Map<String,String> ATTRIBUTE_COLUMN_NAMES = new HashMap<String,String>();

}
