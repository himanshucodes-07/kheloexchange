package com.gamewarrior.Game.Warrior.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.gamewarrior.Game.Warrior.model.QrCode;

public interface QrCodeRepo extends JpaRepository<QrCode, Integer>{

}
