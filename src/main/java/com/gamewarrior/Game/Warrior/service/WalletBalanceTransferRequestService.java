package com.gamewarrior.Game.Warrior.service;

import java.util.List;

import com.gamewarrior.Game.Warrior.exception.WalletException;
import com.gamewarrior.Game.Warrior.model.WalletBalanceTransferRequest;

public interface WalletBalanceTransferRequestService {
	public WalletBalanceTransferRequest saveWalletBalanceTransferRequestObject(WalletBalanceTransferRequest walletBalanceTransferRequest);
	
	public List<WalletBalanceTransferRequest> fetchAllBalanceTransferRequests();
	
	public WalletBalanceTransferRequest findWalletBalanceTransferRequest(Integer id)throws WalletException;
	
	public List<WalletBalanceTransferRequest> findPendingWalletBalanceTransferRequests(Integer userId, Boolean status);
}
