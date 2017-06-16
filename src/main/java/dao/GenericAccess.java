package dao;

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

    public <T> void add(T object)
    {

        em.getTransaction().begin();
        em.persist(object);
        em.getTransaction().commit();
    }

    public <T> void delete(Class<T> type,Integer id)
    {

        em.getTransaction().begin();
        T obj = em.find(type, id);
        em.remove(obj);

        em.getTransaction().commit();

    }

    public <T> List<T> list(T type)
    {
        em.getTransaction().begin();
        List<T> list = em.createQuery("Select a from " + type.getClass().getSimpleName()  + " a")
                .getResultList();

        em.getTransaction().commit();

        return list;
    }

    public <T> T getById(Class<T> type, Integer id)
    {
        em.getTransaction().begin();

        T obj = em.find(type, id);
        em.getTransaction().commit();

        return obj;
    }
}
