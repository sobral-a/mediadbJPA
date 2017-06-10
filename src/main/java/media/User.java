package media;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.ArrayList;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class User
{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column
    private String login;

    @Column
    private String email;

    @OneToMany(cascade = CascadeType.ALL, mappedBy="user")
    private ArrayList<Media> medias;

    @OneToMany(cascade = CascadeType.ALL, mappedBy="userSharing")
    private ArrayList<Sharing> sharings;

    @OneToMany(cascade = CascadeType.ALL, mappedBy="userShared")
    private ArrayList<Sharing> shared;



}