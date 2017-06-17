package dao;

import interceptor.Transaction;
import media.User;

import javax.enterprise.context.ApplicationScoped;
import javax.enterprise.context.Initialized;
import javax.inject.Inject;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.util.List;

/**
 * Created by alexa on 16/06/2017.
 */

@ApplicationScoped
public class GenericAccess
{

    @Inject
    private EntityManager em;

    @Transaction
    public <T> void add(T object)
    {
        em.persist(object);
    }

    @Transaction
    public <T> void delete(Class<T> type,Integer id)
    {

        T obj = em.find(type, id);
        em.remove(obj);
    }

    @Transaction
    public <T> List<T> list(T type)
    {
        List<T> list = em.createQuery("Select a from " + type.getClass().getSimpleName()  + " a")
                .getResultList();
        return list;
    }

    @Transaction
    public <T> T getById(Class<T> type, Integer id)
    {
        T obj = em.find(type, id);
        return obj;
    }
}
