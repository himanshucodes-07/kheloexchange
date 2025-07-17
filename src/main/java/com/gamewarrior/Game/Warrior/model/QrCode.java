package com.gamewarrior.Game.Warrior.model;

import java.time.LocalDateTime;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.SequenceGenerator;
import lombok.Data;

@Entity
@Data
public class QrCode {
	@Id
	@GeneratedValue(strategy= GenerationType.SEQUENCE, generator = "qrCodeGenerator")
	@SequenceGenerator(name ="qrCodeGenerator", sequenceName ="qrCodeGen", allocationSize = 1, initialValue = 80000)
	private Integer qrCodeId;
	private String path;
	private String displayName;
	private Integer maximumLimitOneTransaction;
	private LocalDateTime uploadedDateAndTime = LocalDateTime.now();
	
}
