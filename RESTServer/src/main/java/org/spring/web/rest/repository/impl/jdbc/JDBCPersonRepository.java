package org.spring.web.rest.repository.impl.jdbc;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.sql.DataSource;

import org.spring.web.rest.model.Person;
import org.spring.web.rest.repository.PersonRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository("JDBCPersonRepository")
public class JDBCPersonRepository extends JDBCRepository implements
		PersonRepository {

	@Autowired
	public JDBCPersonRepository(DataSource dataSource) {
		super(dataSource);
		ATTRIBUTE_COLUMN_NAMES.put("id", "ID");
		ATTRIBUTE_COLUMN_NAMES.put("firstName", "FIRST_NAME");
		ATTRIBUTE_COLUMN_NAMES.put("lastName", "LAST_NAME");
		ATTRIBUTE_COLUMN_NAMES.put("number", "NUMBER");
		ATTRIBUTE_COLUMN_NAMES.put("birthDate", "BRITH_DATE");
	}

	protected String getTableName() {
		return TABLE_NAME;
	}

	@Transactional(readOnly = true)
	public Person get(Long id) {
		String sql = new String("select * from " + getTableName()
				+ " where id = ? ");
		return jdbcTemplate.queryForObject(sql, new Object[] { id },
				getRowMaper());
	}

	@Transactional
	public Long add(Person o) {
		Long id = o.getId();
		if (id == null) {
			// User Id was not explicitly set, so try to find an appropriate
			// user id
			String sqlCount = "SELECT MAX(ID) + 1 FROM person";
			id = (long) jdbcTemplate.queryForInt(sqlCount);
		}

		String sql = new String("insert into person values(?,?,?,?,?)");
		jdbcTemplate.update(sql, id, o.getFirstName(), o.getLastName(),
				o.getNumber(), o.getBirthDate());

		return id;
	}

	@Transactional
	public void update(Person o) {
		final String sql = "UPDATE person SET FIRST_NAME = ? , LAST_NAME = ?, "
				+ "NUMBER = ?, BRITH_DATE=?  WHERE ID = ?";
		jdbcTemplate.update(sql,
				new Object[] { o.getFirstName(), o.getLastName(),
						o.getNumber(), o.getBirthDate(), o.getId() });
	}

	@Transactional
	public Person delete(Long id) {
		Person temp = get(id);
		String sql = "DELETE FROM person WHERE id = ?";
		jdbcTemplate.update(sql, id);
		return temp;
	}

	@Transactional(readOnly = true)
	public List<Person> findAll() {
		String sql = "SELECT ID, FIRST_NAME, LAST_NAME, NUMBER, BRITH_DATE FROM "
				+ getTableName();
		return (List<Person>) jdbcTemplate.query(sql, getResultSetExtractor());
	}

	@Transactional(readOnly = true)
	public int getCount() {
		String sql = "SELECT Count(*) FROM " + getTableName();
		return jdbcTemplate.queryForInt(sql);
	}

	private RowMapper<Person> getRowMaper() {
		return new RowMapper<Person>() {
			public Person mapRow(ResultSet rs, int arg1) throws SQLException {
				Person person = new Person();
				person.setId(rs.getLong("ID"));
				person.setFirstName(rs.getString("FIRST_NAME"));
				person.setLastName(rs.getString("LAST_NAME"));
				person.setNumber(rs.getInt("NUMBER"));
				person.setBirthDate(rs.getDate("BRITH_DATE"));
				return person;
			}

		};
	}

	@SuppressWarnings("unused")
	private ResultSetExtractor<List<Person>> getResultSetExtractor(){
		return new ResultSetExtractor<List<Person>>() {
			public List<Person> extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				List<Person> list = new ArrayList<Person>();
				Person person;
				while(rs.next()){
					person = new Person();
					person.setId(rs.getLong("ID"));
					person.setFirstName(rs.getString("FIRST_NAME"));
					person.setLastName(rs.getString("LAST_NAME"));
					person.setNumber(rs.getInt("NUMBER"));
					person.setBirthDate(rs.getDate("BRITH_DATE"));
					list.add(person);
				}
				return list;
			}
		};
	}

}
