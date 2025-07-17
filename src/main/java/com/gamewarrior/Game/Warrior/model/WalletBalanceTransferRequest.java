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
public class WalletBalanceTransferRequest {
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "walletBalanceTransferGenerator")
	@SequenceGenerator(name="walletBalanceTransferGenerator", sequenceName = "walletBalanceTransferGen", initialValue = 100000, allocationSize = 1)
	private Integer id;
	private String mobile;
	private String name;
	private String websiteUsername;
	private String websiteName;
	private String website;
	private Double amount;
	private Integer userId;
	private Boolean status= false;
	private String remark;
	private LocalDateTime timestamp= LocalDateTime.now();
	
	
}