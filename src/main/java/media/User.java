package media;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

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
    private List<Media> medias = new ArrayList<>();

    @OneToMany(cascade = CascadeType.ALL, mappedBy="userSharing")
    private List<Sharing> sharings = new ArrayList<>();

    @OneToMany(cascade = CascadeType.ALL, mappedBy="userShared")
    private List<Sharing> shared = new ArrayList<>();



}