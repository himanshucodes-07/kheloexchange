package com.gamewarrior.Game.Warrior.service;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.time.LocalDateTime;
import java.util.List;

import javax.mail.MessagingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gamewarrior.Game.Warrior.configure.SecurityConfig;
import com.gamewarrior.Game.Warrior.dao.ReferralRepo;
import com.gamewarrior.Game.Warrior.dao.UserRepo;
import com.gamewarrior.Game.Warrior.exception.UserException;
import com.gamewarrior.Game.Warrior.model.Notification;
import com.gamewarrior.Game.Warrior.model.Referral;
import com.gamewarrior.Game.Warrior.model.User;
import com.gamewarrior.Game.Warrior.model.Wallet;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Service
public class UserServiceImpl implements UserService{
	@Autowired
	private EmailService emailService;
	@Autowired
	private UserRepo userRepo;
	@Autowired
	private SecurityConfig securityConfig;
	@Autowired
	private ReferralRepo referralRepo;

	@Override
	public void logout(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Expires", "0");
		
		if(session.getAttribute("userId")==null) {
			response.sendRedirect("login");
		}
		else {
			session.removeAttribute("userId");
			session.removeAttribute("balance");
			session.invalidate();
			
			response.sendRedirect("/");
		}
	}

	@Override
	public void forgetPassword(String email) throws UserException, MessagingException {
		User user = userRepo.findByEmail(email);
		
		if(user==null) {
			throw new UserException("Invalid user!! please register.");
		}
		String otp= emailService.sendOtpEmail(email);
		Notification notification = new Notification();
		
		user.setOtp(otp);
		user.setTimestamp(LocalDateTime.now());
		notification.setUserId(user.getId());
        notification.setSubject("Validation Otp");
        notification.setMessage("OTP has been sent to email "+user.getEmail());
        
        user.getNotifications().add(notification);
		
        userRepo.save(user);
	}

	@Override
	public void updatePassword(String password, HttpSession session) throws UserException, NoSuchAlgorithmException, MessagingException {
		String userEmail = String.valueOf(session.getAttribute("forgotemail"));
		
		if(userEmail==null) {
			throw new UserException("Invalid user!! please register.");
		}
		User user = userRepo.findByEmail(userEmail);
		
		if(user==null) {
			throw new UserException("Unauthorized user!!");
		}
		user.setPassword(securityConfig.encryptPassword(password));
		
		emailService.sendGreetingEmailForResetPassword(user);
		
		userRepo.save(user);
		
		session.removeAttribute("forgotemail");
		session.removeAttribute("verifiedOtp");
	}

	@Override
	public void resentOtp(String userEmail) throws MessagingException {
		String otp = emailService.sendOtpEmail(userEmail);
		User user = userRepo.findByEmail(userEmail);
		
		user.setOtp(otp);
		user.setTimestamp(LocalDateTime.now());
		
		userRepo.save(user);
	}

	@Override
	public User fetchProfile(Integer userId) throws UserException {
		return userRepo.findById(userId).orElseThrow(() -> new UserException("Invalid User!!"));
	}

	@Override
	public void saveUserDetail(User user) {
		userRepo.save(user);
	}

	@Override
	public void checkReferral(HttpSession session) throws UserException {
		String email = (String)session.getAttribute("email");
		
		session.removeAttribute("email");
		
		User user = userRepo.findByEmail(email);
		Referral referral = referralRepo.findByReferralUserId(user.getId());
		
		if(referral!=null) {
			User referrerUser =  fetchProfile(referral.getReferrerUserId());
			
			referrerUser.setReferralPoint(referrerUser.getReferralPoint()+100);
			
			saveUserDetail(referrerUser);
		}
	}

	@Override
	public User findUserByReferralCode(String referralCode) throws UserException {
		User user = userRepo.findByReferralCode(referralCode);
		
		if(user!=null)
			return user;
		
		throw new UserException("Invalid referralCode! please go back and try again.");
	}

	@Override
	public void redeemUserReferralPoint(Integer userId, Integer referralPoint) throws UserException, MessagingException {
		User user = fetchProfile(userId);
		
		user.setReferralPoint(user.getReferralPoint() - referralPoint);
		
		saveUserDetail(user);
		emailService.sendCustomMessage(user.getEmail(), "Successfully redeem the points", "Your points "+referralPoint + " are successfully redeem.", user);
	}

	@Override
	public void depositReferralPoint(Integer userId, Integer referralPoint) throws UserException {
		Referral referral = referralRepo.findByReferralUserId(userId);
		
		if(referral!=null) {
			User referrerUser =  fetchProfile(referral.getReferrerUserId());
			
			referrerUser.setReferralPoint(referrerUser.getReferralPoint()+referralPoint);
			
			saveUserDetail(referrerUser);
		}
	}

	@Override
	public List<User> fetchAllUser() {
		return userRepo.findAll();
	}

	@Override
	public User changePassword(Integer userId, String password) throws UserException, NoSuchAlgorithmException, MessagingException {
		User user = fetchProfile(userId);
		
		user.setPassword(securityConfig.encryptPassword(password));
		
		emailService.sendGreetingEmailForResetPassword(user);
		
		return userRepo.save(user);
	}

	@Override
	public User registerUser(User user) throws UserException, MessagingException {
		User user1 = userRepo.findByEmail(user.getEmail());

        if(user1 !=null && user1.isVerify()){
            throw new UserException("User already registered! You can login or use another email id");
        }
       
        String otp= this.emailService.sendOtpEmail(user.getEmail());
        
        if(user1!= null){
            user.setId(user1.getId());
            
            user.setNotifications(user1.getNotifications());
            user.setWallet(user1.getWallet());
        }
        user.setOtp(otp);
        user.setTimestamp(LocalDateTime.now());
        
        user= userRepo.save(user);
        
    	if(user.getWallet()==null) {
    		Wallet wallet = new Wallet();
            Notification notification = new Notification();
            
            wallet.setGeneralWallet(0.0);
            wallet.setWithdrawableWallet(0.0);
            wallet.setUserId(user.getId());
            
            notification.setSubject("Validation Otp");
            notification.setMessage("OTP has been sent to email "+user.getEmail());
            notification.setUserId(user.getId());
            
            user.getNotifications().add(notification);
            user.setWallet(wallet);
            
            user = userRepo.save(user);
    	}
        return user;
	}

	@Override
	public User fetchUserByEmail(String email) throws UserException {
		User user= userRepo.findByEmail(email);
		
		if(user==null)
			throw new UserException("Invalid Email id, Please contact to Customer Care/Admin.");
		
		return user;
	}
}