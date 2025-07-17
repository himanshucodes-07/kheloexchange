package com.gamewarrior.Game.Warrior.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.gamewarrior.Game.Warrior.model.BankAccount;

public interface BankAccountRepo extends JpaRepository<BankAccount, Integer>{

}
