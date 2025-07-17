package com.gamewarrior.Game.Warrior.service;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.List;

import javax.mail.MessagingException;

import com.gamewarrior.Game.Warrior.exception.UserException;
import com.gamewarrior.Game.Warrior.model.User;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public interface UserService {
	public void logout(HttpServletRequest request, HttpServletResponse response)throws IOException;
	
	public void forgetPassword(String email)throws UserException, MessagingException;

	public void updatePassword(String password, HttpSession session)throws UserException, NoSuchAlgorithmException, MessagingException;

	public void resentOtp(String userEmail) throws MessagingException;

	public User fetchProfile(Integer userId) throws UserException;
	
	public void saveUserDetail(User user);
	
	public void checkReferral(HttpSession session) throws UserException;
	
	public void depositReferralPoint(Integer userId, Integer referralPoint) throws UserException;
	
	public User findUserByReferralCode(String referralCode) throws UserException;
	
	public void redeemUserReferralPoint(Integer userId, Integer referralPoint) throws UserException, MessagingException;
	
	public List<User> fetchAllUser();
	
	public User changePassword(Integer userId, String password) throws UserException, NoSuchAlgorithmException, MessagingException;
	
	public User registerUser(User user)throws UserException, MessagingException;
	
	public User fetchUserByEmail(String email)throws UserException;
}
