package com.gamewarrior.Game.Warrior.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gamewarrior.Game.Warrior.dao.WalletBalanceTransferRequestRepo;
import com.gamewarrior.Game.Warrior.exception.WalletException;
import com.gamewarrior.Game.Warrior.model.WalletBalanceTransferRequest;

@Service
public class WalletBalanceTransferRequestServiceImpl implements WalletBalanceTransferRequestService{
	@Autowired
	private WalletBalanceTransferRequestRepo walletBalanceTransferRequestRepo;

	@Override
	public WalletBalanceTransferRequest saveWalletBalanceTransferRequestObject(
			WalletBalanceTransferRequest walletBalanceTransferRequest) {
		return walletBalanceTransferRequestRepo.save(walletBalanceTransferRequest);
	}

	@Override
	public List<WalletBalanceTransferRequest> fetchAllBalanceTransferRequests() {
		return walletBalanceTransferRequestRepo.findAll();
	}

	@Override
	public WalletBalanceTransferRequest findWalletBalanceTransferRequest(Integer id) throws WalletException {
		return walletBalanceTransferRequestRepo.findById(id)
				.orElseThrow(() -> new WalletException("Something went wrong! please contact to website owner."));
	}

	@Override
	public List<WalletBalanceTransferRequest> findPendingWalletBalanceTransferRequests(Integer userId, Boolean status) {
		return walletBalanceTransferRequestRepo.findByUserIdAndStatus(userId, status);
	}

}
