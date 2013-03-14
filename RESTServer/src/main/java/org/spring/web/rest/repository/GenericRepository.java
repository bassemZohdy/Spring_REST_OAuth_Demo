package org.spring.web.rest.repository;

import java.util.List;

public interface GenericRepository<ID, EntityType> {

	public EntityType get(ID id);

	public Long add(EntityType o);

	public void update(EntityType o);

	public EntityType delete(ID id);

	public List<EntityType> findAll();

	int getCount();
}
