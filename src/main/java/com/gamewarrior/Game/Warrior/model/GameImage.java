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
public class GameImage {
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "gameImageGenerator")
	@SequenceGenerator(name="gameImageGenerator", sequenceName = "gameImageGen", allocationSize = 1, initialValue = 54098)
	private Integer id;
	private String imageLink;
	@Column(columnDefinition = "TEXT")
	private String subject;
	@Column(columnDefinition = "TEXT")
	private String message;
	
}