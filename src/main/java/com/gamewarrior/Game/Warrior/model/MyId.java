package com.gamewarrior.Game.Warrior.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.SequenceGenerator;
import lombok.Data;

@Data
@Entity
public class MyId {
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "idGenerator")
	@SequenceGenerator(name="idGenerator", sequenceName = "idGen", allocationSize = 1, initialValue = 1000000)
	private Integer id;
	private String website;
	private String websiteName;
	private String logo;
	private String username;
	private String password;
	@Column(unique = true)
	private Integer accountRequestId;
	private Integer userId;
	private Boolean status=false;
	
}
