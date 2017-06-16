package dao;

import media.User;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.util.List;

/**
 * Created by alexa on 16/06/2017.
 */
public class GenericAccess<T>
{

    public void add(T object)
    {
        EntityManagerFactory factory = Persistence.createEntityManagerFactory("factory");
        EntityManager em = factory.createEntityManager();

        em.getTransaction().begin();

        em.persist(object);
        em.getTransaction().commit();
        em.close();
        factory.close();
    }

    public void delete(Class<T> type,Integer id)
    {
        EntityManagerFactory factory = Persistence.createEntityManagerFactory("factory");
        EntityManager em = factory.createEntityManager();

        em.getTransaction().begin();
        T obj = em.find(type, id);
        em.remove(obj);

        em.getTransaction().commit();

        em.close();
        factory.close();

    }

    public List<T> list(T type)
    {
        EntityManagerFactory factory = Persistence.createEntityManagerFactory("factory");
        EntityManager em = factory.createEntityManager();
        em.getTransaction().begin();
        List<T> list = em.createQuery("Select a from " + type.getClass().getSimpleName()  + " a")
                .getResultList();

        em.getTransaction().commit();

        em.close();
        factory.close();
        return list;
    }

    public T getById(Class<T> type, Integer id)
    {
        EntityManagerFactory factory = Persistence.createEntityManagerFactory("factory");
        EntityManager em = factory.createEntityManager();
        em.getTransaction().begin();

        T obj = em.find(type, id);
        em.getTransaction().commit();

        em.close();
        factory.close();
        return obj;
    }
}
