package com.gamewarrior.Game.Warrior.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import com.gamewarrior.Game.Warrior.dao.WalletRepo;
import com.gamewarrior.Game.Warrior.dto.Status;
import com.gamewarrior.Game.Warrior.exception.UserException;
import com.gamewarrior.Game.Warrior.exception.WalletException;
import com.gamewarrior.Game.Warrior.model.User;
import com.gamewarrior.Game.Warrior.model.Wallet;
import com.gamewarrior.Game.Warrior.model.WalletTransaction;

import jakarta.servlet.http.HttpSession;

@Service
public class WalletServiceImpl implements WalletService{
	@Autowired
	private WalletRepo walletRepo;
	@Autowired
	private UserService userService;
	private final Double DIVISION_PERCENTAGE =80.0; 

	@Override
	public Wallet getWalletByUserId(Integer userId) throws WalletException, UserException {
		User user = userService.fetchProfile(userId);
		
		if(user==null)
			throw new WalletException("Invalid user! please register.");
		
		return user.getWallet();
	}

	@Override
	public boolean walletAmountDeduction(Double amount, Integer userId, HttpSession session, String remark) throws WalletException, UserException {
		Wallet wallet = getWalletByUserId(userId);
		double withdraw = amount;
		
		if(wallet.getGeneralWallet()<amount) {
			if((wallet.getGeneralWallet()+wallet.getWithdrawableWallet())<amount) {
				return false;
			}
			else {
				amount = amount - wallet.getGeneralWallet();
				
				wallet.setGeneralWallet(0.0);
				wallet.setWithdrawableWallet(wallet.getWithdrawableWallet()-amount);
			}
		}
		else {
			wallet.setGeneralWallet(wallet.getGeneralWallet()-amount);
		}
		if(!remark.equalsIgnoreCase("refund"))
		wallet.setTotalWithdraw(wallet.getTotalWithdraw()+ withdraw);
		
		addTransactionDetailInWallet(wallet, amount, Status.DR, remark);
		updateWallet(wallet);
		setSessionOfTheWallet(wallet, session);
		
		return true;
	}

	@Override
	public boolean walletAmountAddition(Double amount, Integer userId, HttpSession session, String remark) throws WalletException, UserException {
		Wallet wallet = getWalletByUserId(userId);
		
		Double withdrawableAmount = amount*(DIVISION_PERCENTAGE/100);
		System.out.println(withdrawableAmount);
		Double generalAmount = amount - withdrawableAmount;
		
		wallet.setGeneralWallet(wallet.getGeneralWallet()+generalAmount);
		wallet.setWithdrawableWallet(wallet.getWithdrawableWallet() + withdrawableAmount);
		
		if(!remark.equalsIgnoreCase("refund"))
			wallet.setTotalDeposit(wallet.getTotalDeposit()+ amount);
		
		addTransactionDetailInWallet(wallet, amount, Status.CR, remark);
		
		updateWallet(wallet);
		setSessionOfTheWallet(wallet, session);
		
		return true;
	}

	@Override
	public Wallet updateWallet(Wallet wallet) throws WalletException {
		if(wallet==null)
			throw new WalletException("Invalid user! please register.");
		
		return walletRepo.save(wallet);
	}

	@Override
	public boolean generalWalletAmountDeduction(Double amount, Integer userId, HttpSession session, String remark) throws WalletException, UserException {
		Wallet wallet = getWalletByUserId(userId);
		
		if(wallet.getGeneralWallet()<amount)
			return false;
		
		wallet.setGeneralWallet(wallet.getGeneralWallet()-amount);
		
		if(!remark.equalsIgnoreCase("refund"))
			wallet.setTotalWithdraw(wallet.getTotalWithdraw()+amount);
		
		addTransactionDetailInWallet(wallet, amount, Status.DR, remark);
		
		updateWallet(wallet);
		setSessionOfTheWallet(wallet, session);
		
		return true;
	}

	@Override
	public boolean withdrawableWalletAmountDeduction(Double amount, Integer userId, HttpSession session, String remark) throws WalletException, UserException {
		Wallet wallet = getWalletByUserId(userId);
		
		if(wallet.getWithdrawableWallet() < amount)
			return false;
		
		wallet.setWithdrawableWallet(wallet.getWithdrawableWallet()-amount);
		
		if(!remark.equalsIgnoreCase("refund"))
			wallet.setTotalWithdraw(wallet.getTotalWithdraw()+amount);
		
		addTransactionDetailInWallet(wallet, amount, Status.DR, remark);
		
		updateWallet(wallet);
		setSessionOfTheWallet(wallet, session);
		
		return true;
	}

	@Override
	public void setSessionOfTheWallet(Wallet wallet, HttpSession session) throws WalletException {
		session.setAttribute("generalWallet", wallet.getGeneralWallet());
		session.setAttribute("withdrawableWallet", wallet.getWithdrawableWallet());
		session.setAttribute("balance", (wallet.getGeneralWallet()+wallet.getWithdrawableWallet()));
	}

	@Override
	public void addTransactionDetailInWallet(Wallet wallet, Double amount, Status status, String remark) {
		WalletTransaction walletTransaction = new WalletTransaction();
		
		walletTransaction.setAmount(amount);
		walletTransaction.setStatus(status);
		walletTransaction.setTotalAmount(wallet.getGeneralWallet()+wallet.getWithdrawableWallet());
		walletTransaction.setRemark(remark);
		
		wallet.getWalletTransactions().add(walletTransaction);
	}

	@Override
	public Double totalAmountOfWallet(Integer userId) throws WalletException, UserException {
		Wallet wallet= getWalletByUserId(userId);
		return wallet.getGeneralWallet()+wallet.getWithdrawableWallet();
	}

	@Override
	public boolean withdrawableWalletAmountAddition(Double amount, Integer userId, HttpSession session, String remark) throws WalletException, UserException {
		Wallet wallet = getWalletByUserId(userId);
		
		Double withdrawableAmount = amount;
		
		wallet.setWithdrawableWallet(wallet.getWithdrawableWallet() + withdrawableAmount);
		
		if(!remark.equalsIgnoreCase("refund"))
			wallet.setTotalDeposit( wallet.getTotalDeposit()+ withdrawableAmount);
		
		addTransactionDetailInWallet(wallet, amount, Status.CR, remark);
		
		updateWallet(wallet);
		setSessionOfTheWallet(wallet, session);
		
		return true;
	}

	@Override
	public List<User> findMaximumDepositUser() throws UserException {
		List<Integer> userIdList = walletRepo.get5TopUserOnTheBasisOfMaximumDeposit(PageRequest.of(0, 5));
		List<User> userList = new ArrayList<>();
		
		for(Integer userId: userIdList) {
			userList.add(userService.fetchProfile(userId));
		}
		return userList;
	}

}
