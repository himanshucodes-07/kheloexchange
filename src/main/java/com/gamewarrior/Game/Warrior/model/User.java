package com.gamewarrior.Game.Warrior.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Data
@NoArgsConstructor
@EqualsAndHashCode
@Entity
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "userGenerator")
    @SequenceGenerator(name = "userGenerator", sequenceName = "userGen", allocationSize = 1, initialValue = 1)
    private Integer id;
    private String firstName;
    private String lastName;
    @Column(unique = true)
    private String email;
    private String mobile;
    @Column(unique=true)
    private String referralCode;
    private Integer referralPoint=0;
    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    private String password;
    private LocalDateTime timestamp;
    private LocalDateTime joiningDateTime = LocalDateTime.now();
    private String otp;
    private boolean isVerify;
    @OneToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private Wallet wallet;
    @OneToMany(cascade = CascadeType.ALL)
    private List<Notification> notifications = new ArrayList<>();
    
}