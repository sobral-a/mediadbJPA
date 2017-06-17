package main;

import dao.GenericAccess;
import media.User;
import org.jboss.weld.environment.se.Weld;
import org.jboss.weld.environment.se.WeldContainer;
import services.UserService;

import javax.inject.Inject;
import javax.persistence.Entity;
import javax.persistence.EntityManager;
import java.util.List;
import org.jboss.weld.environment.se.Weld;

/**
 * Created by Kevin on 10/06/2017.
 */

public class Main {

    @Inject
    private EntityManager em;

    public static void main(String[] args)
    {
        Weld weld = new Weld();
        WeldContainer container = weld.initialize();

        UserService userService = container.select(UserService.class).get();

        userService.add("sobral_r", "sobral_r@epita.fr");
        List<User> users = userService.list();
        User user = userService.getById(2);
        System.out.println(user.toString());

        container.shutdown();
    }
}
