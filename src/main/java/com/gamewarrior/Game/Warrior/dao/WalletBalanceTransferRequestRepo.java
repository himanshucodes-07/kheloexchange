package com.gamewarrior.Game.Warrior.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.gamewarrior.Game.Warrior.model.WalletBalanceTransferRequest;

@Repository
public interface WalletBalanceTransferRequestRepo extends JpaRepository<WalletBalanceTransferRequest, Integer> {
	public List<WalletBalanceTransferRequest> findByUserIdAndStatus(Integer userId, Boolean status);
}
