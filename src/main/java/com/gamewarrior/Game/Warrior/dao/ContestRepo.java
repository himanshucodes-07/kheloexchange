package com.gamewarrior.Game.Warrior.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.gamewarrior.Game.Warrior.model.Contest;

@Repository
public interface ContestRepo extends JpaRepository<Contest, Integer>{
	public Contest findByEmail(String email);
	
	public Contest findByUserId(Integer userId);
}