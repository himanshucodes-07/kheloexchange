package com.gamewarrior.Game.Warrior.dao;

import com.gamewarrior.Game.Warrior.model.Wallet;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.util.List;

public interface WalletRepo extends JpaRepository<Wallet, Integer> {
	
	@Query("SELECT w.userId from Wallet w order by w.totalDeposit desc")
	public List<Integer> get5TopUserOnTheBasisOfMaximumDeposit(Pageable pageable);
}
