package org.spring.web.rest.repository.impl.jdbc;

import javax.sql.DataSource;

import org.spring.web.rest.repository.GenericRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

public abstract class JDBCRepository {

	protected JdbcTemplate jdbcTemplate;

	public JDBCRepository(DataSource dataSource) {
		jdbcTemplate = new JdbcTemplate(dataSource);
	}

	protected abstract String getTableName();
}
