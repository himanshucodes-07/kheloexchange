package com.gamewarrior.Game.Warrior.model;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import jakarta.persistence.CollectionTable;
import jakarta.persistence.Column;
import jakarta.persistence.ElementCollection;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.SequenceGenerator;
import lombok.Data;

@Data
@Entity
public class Game {
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "gameGenerator")
	@SequenceGenerator(name="gameGenerator", sequenceName = "gameGen", allocationSize = 1, initialValue = 50000)
	private Integer id;
	private String websiteName;
	private String website;
	private String logo;
	private Integer minimumBet;
	private Integer minimumWithdrawal;
	private Integer minimumMaintainingBalance;
	private Integer maximumWithrawal;
	@ElementCollection(fetch = FetchType.EAGER)
	private List<String> gameName= new ArrayList<>();	
	
}
