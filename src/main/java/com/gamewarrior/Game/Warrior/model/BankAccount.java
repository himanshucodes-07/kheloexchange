package com.gamewarrior.Game.Warrior.model;

import java.time.LocalDateTime;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.SequenceGenerator;
import lombok.Data;

@Data
@Entity
public class BankAccount {
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator= "bankAccountGenerator")
	@SequenceGenerator(name = "bankAccountGenerator", sequenceName = "bankAccountGen", initialValue = 100, allocationSize = 1)
	private Integer bankAccountId;
	private String accountNumber;
	private String ifsc;
	private String accountHolderName;
	private String bankName;
	private Integer maximumLimitPerTransaction;
	private LocalDateTime addedDateAndTime = LocalDateTime.now();
	
	
}