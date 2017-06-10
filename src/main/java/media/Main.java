package media;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

/**
 * Created by Kevin on 10/06/2017.
 */

public class Main {
    public static void main(String[] args){
        EntityManagerFactory factory = Persistence.createEntityManagerFactory("factory");
        EntityManager em = factory.createEntityManager();

        em.getTransaction().begin();

        Media media = new Media();
        media.setName("New Media");
        em.persist(media);

        File f = new File();
        f.setFormat("Format");
        f.setPath("path");
        f.setMedia(media);
        media.getFiles().add(f);
        em.merge(f);
        /*Profile profile = new Profile();
        profile.setName("Name");
        em.persist(profile);*/
        em.getTransaction().commit();

        em.close();
        factory.close();
    }
}
