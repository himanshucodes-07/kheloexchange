package com.gamewarrior.Game.Warrior.model;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.SequenceGenerator;
import lombok.Data;

@Entity
@Data
public class Contest {
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "contestGenerator")
	@SequenceGenerator(name="contestGenerator", sequenceName = "contestGen", initialValue = 10000, allocationSize = 1)
	private Integer id;
	private String name;
	@Column(unique = true)
	private String email;
	@Column(unique= true)
	private Integer userId;
	private String mobile;
	private String teamName;
	private LocalDateTime timestamp= LocalDateTime.now();
	
	
}