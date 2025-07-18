package com.gamewarrior.Game.Warrior.model;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.SequenceGenerator;
import lombok.Data;

@Data
@Entity
public class DepositRequest {
	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "requestGenerator")
	@SequenceGenerator(name = "requestGenerator", sequenceName ="requestGen", allocationSize = 1, initialValue = 100000)
	private Integer id;
	private Integer userId;
	private String upiId;
	private String upiName;
	private String accountNumber;
	private String ifsc;
	private String qrPath;
	private String path;
	@Column(unique = true)
	private String utr;
	private Double amount;
	private Boolean status=false;
	private String remark;
	private LocalDateTime timestamp = LocalDateTime.now();
	
}