package services;

import dao.GenericAccess;
import media.User;

import java.util.List;

/**
 * Created by alexa on 16/06/2017.
 */
public class UserService
{
    private static GenericAccess<User> userAccess = new GenericAccess<>();

    public static void add(String login, String email)
    {
        User user = new User();
        user.setEmail(email);
        user.setLogin(login);
        userAccess.add(user);
    }

    public static void delete(Integer id)
    {
        userAccess.delete(User.class, id);
    }

    public static  User getById(Integer id)
    {
        return userAccess.getById(User.class, id);
    }

    public static List<User> list()
    {
        return userAccess.list(new User());
    }
}
