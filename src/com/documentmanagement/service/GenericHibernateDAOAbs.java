package com.documentmanagement.service;

import java.lang.reflect.Field;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.impl.CriteriaImpl;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.transaction.annotation.Transactional;

import com.documentmanagement.service.util.ProjectionHandler;


public abstract class GenericHibernateDAOAbs<T> extends HibernateDaoSupport implements GenericHibernateDAO<T> {
	protected Class<T> persistentClass;
	private ProjectionHandler projectionHandler;

	public GenericHibernateDAOAbs(Class<T> persistentClass) {
		if (persistentClass == null) {
			throw new IllegalArgumentException("persistentClass is required");
		}
		this.persistentClass = persistentClass;
	}

	public List<T> findAll() {
		return findByCriteria(getDetachedCriteria());
	}

	protected DetachedCriteria getDetachedCriteria(Criterion... criterion) {
		DetachedCriteria criteria = DetachedCriteria.forClass(persistentClass);
		criteria = addCriterion(criteria, criterion);
		return applyProjectionHandler(criteria);
	}

	protected DetachedCriteria getDetachedCriteria(String entity, Criterion... criterion) {
		DetachedCriteria criteria = DetachedCriteria.forEntityName(entity);
		criteria = addCriterion(criteria, criterion);
		return applyProjectionHandler(criteria);
	}
	
	private DetachedCriteria addCriterion(DetachedCriteria criteria, Criterion... criterion) {
		for (Criterion c : criterion) {
			criteria.add(c);
		}
		return criteria;
	}
	
	private DetachedCriteria applyProjectionHandler(DetachedCriteria criteria) {
		if (projectionHandler != null) {
			criteria = projectionHandler.getProjection(criteria);
		}
		return criteria;
	}
	
	@SuppressWarnings( { "unchecked" })
	protected final List<T> findByCriteria(DetachedCriteria criteria, Integer firstResult, Integer maxResults) {
		return (List<T>) findObjectByCriteria(criteria, firstResult, maxResults);
	}

	@SuppressWarnings( { "unchecked" })
	protected final List<T> findByCriteria(DetachedCriteria criteria) {
		return (List<T>) findObjectByCriteria(criteria);
	}
	
	protected final T getByCriteria(DetachedCriteria criteria) {
		List<T> list = findByCriteria(criteria);
		T t = list.size() > 0 ? list.get(0) : null;
		return t;
	}
	
	@Transactional(readOnly = true)
	@SuppressWarnings("unchecked")
	protected final List<Object> findObjectByCriteria(DetachedCriteria criteria) {
		return getMyHibernateTemplate().findByCriteria(criteria);
	}
	
	@SuppressWarnings("unchecked")
	protected final List<Object> findObjectByCriteria(DetachedCriteria criteria, Integer firstResult, Integer maxResults) {
		return getMyHibernateTemplate().findByCriteria(criteria, firstResult, maxResults);
	}
	
	
	
	protected final Object getObjectByCriteria(DetachedCriteria criteria) {
		List<Object> list = findObjectByCriteria(criteria);
		return list.size() > 0 ? list.get(0) : null;
	}

	@SuppressWarnings("unchecked")
	protected final List<T> findByNamedQuery(String queryName, Map<String, Object> params) {
		return (List<T>) findObjectByNamedQuery(queryName, params);
	}
	
	@SuppressWarnings("unchecked")
	protected final T[] getByNamedQuery(String queryName, Map<String, Object> params) {
		return (T[]) getObjectByNamedQuery(queryName, params);
	}
	
	protected final List<?> findObjectByNamedQuery(String queryName, Map<String, Object> params) {
		List<String> pn = new ArrayList<String>(params.size());
		List<Object> v = new ArrayList<Object>(params.size());
		for (Entry<String, Object> param : params.entrySet()) {
			pn.add(param.getKey());
			v.add(param.getValue());
		}
		String[] paramNames = pn.toArray(new String[pn.size()]);
		Object[] values = v.toArray(new Object[v.size()]);
		return getHibernateTemplate().findByNamedQueryAndNamedParam(queryName, paramNames, values);
	}
	
	protected final Object getObjectByNamedQuery(String queryName, Map<String, Object> params) {
		List<?> list = findObjectByNamedQuery(queryName, params);
		return list.size() > 0 ? list.get(0) : null;
	}
	
	@Transactional
	protected final int bulkUpdate(String hql) {
		return getMyHibernateTemplate().bulkUpdate(hql);
	}
	
	@Transactional
	protected final int bulkUpdate(String hql, Object... values) {
		return getMyHibernateTemplate().bulkUpdate(hql, values);
	}
	
	@Transactional
	protected final int bulkUpdateByNamedQuery(String queryName, Object... values) {
		Query query = getSession().getNamedQuery(queryName);
		for (int i = 0; i < values.length; i++) {
			query.setParameter(i, values[i]);
		}
		return query.executeUpdate();
	}
	
	@Transactional
	public T save(T object) {
		return (T) getMyHibernateTemplate().merge(object);
	}

	@Transactional
	public T save(String entity, T object) {
		return (T) getMyHibernateTemplate().merge(entity, object);
	}
	
	@Transactional
	public void saveAll(List<T> entities) {
		getMyHibernateTemplate().saveOrUpdateAll(entities);
	}

	@Transactional
	public void delete(T entity) {
		getMyHibernateTemplate().delete(entity);
	}

	@Transactional
	public void deleteAll(List<T> entities) {
		getMyHibernateTemplate().deleteAll(entities);
	}
	
	protected HibernateTemplate getMyHibernateTemplate() {
		return new HibernateTemplate(getSessionFactory());
	}
	
	@Override
	public void setProjectionHandler(ProjectionHandler projectionHandler) {
		this.projectionHandler = projectionHandler;
	}

}
