package com.gamewarrior.Game.Warrior.controller;

import java.io.IOException;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class EndPointMappingClass {
	@GetMapping("/login")
	public String login() {
		return "login";
	}
	
	@GetMapping("/")
	public void index(HttpServletResponse response, HttpServletRequest request) throws IOException, ServletException {
		RequestDispatcher rd= request.getRequestDispatcher("home");
		rd.include(request, response);
	}
	
	@GetMapping("/registration")
	public String registration() {
		return "registration";
	}

	@GetMapping("/profile")
	public String profile() {
		return "profile";
	}
	
	@GetMapping("/contact")
	public String contact() {
		return "contact";
	}
	
	@GetMapping("/forgotpswd")
	public String forgotpswd() {
		return "forgotpswd";
	}
	
	@GetMapping("/otp")
	public String otp() {
		return "otp";
	}
	
	@GetMapping("/review")
	public String review() {
		return "review";
	}
	
	@GetMapping("/single-blog")
	public String single_blog() {
		return "single-blog";
	}
	
	@GetMapping("/termsandcondition")
	public String termsAndCondition() {
		return "terms-and-condition";
	}
	
	@GetMapping("/passbook")
	public String passbook() {
		return "passbook";
	}
	
	@GetMapping("/ids")
	public String ids() {
		return "ids";
	}
	
	@GetMapping("/fetchnotification")
	public String notification() {
		return "notification";
	}
	
	@GetMapping("/deposit")
	public String deposit() {
		return "deposit";
	}
	
	@GetMapping("/withdraw")
	public String withdraw() {
		return "withdraw";
	}
	
	@GetMapping("/forgot-otp")
	public String forgetOtp() {
		return "forgot-otp";
	}
	
	@GetMapping("/changePassword")
	public String changePassword() {
		return "change-password";
	}
	
	@GetMapping("/createId")
	public String createId(){
		return "create-id";
	}
	
	@GetMapping("/admin-login")
	public String adminLogin() {
		return "admin/admin-login";
	}
	
	@GetMapping("/adminDashboard")
	public String adminDashboard() {
		return "admin/admin-dashboard";
	}
	
	@GetMapping("/depositRequest")
	public String depositRequest() {
		return "admin/depositRequest";
	}
	
	@GetMapping("/createIdRequest")
	public String createIdRequest() {
		return "admin/createIdRequest";
	}
	
	@GetMapping("/updateGameWebsite")
	public String updateGameWebsite() {
		return "admin/updateGameWebsite";
	}
	
	@GetMapping("/updatePaymentMethod")
	public String updatePaymentMethod() {
		return "admin/updatePaymentMethod";
	}
	
	@GetMapping("/adminWithdrawRequest")
	public String adminWithdrawRequest() {
		return "admin/adminWithdrawRequest";
	}
	
	@GetMapping("/pendingRequest")
	public String pendingRequest() {
		return "pendingRequest";
	}
	
	@GetMapping("/contestForm")
	public String contestForm() {
		return "contestForm";
	}
	
	@GetMapping("/contestParticipantInformation")
	public String contestgParticipantInformation() {
		return "admin/contestParticipantInformation";
	}
	
	@GetMapping("/newGameImageUpload")
	public String newGameImageUpload() {
		return "admin/newGameImageUpload";
	}
	
	@GetMapping("/walletBalanceTransferToAnotherWebsiteRequest")
	public String walletBalanceTransferToAnotherWebsiteRequest() {
		return "walletBalanceTransferToAnotherWebsiteRequest";
	}
	
	@GetMapping("/adminWalletBalanceTransferRequest")
	public String WalletBalanceTransferRequest() {
		return "admin/adminWalletBalanceTransferRequest";
	}
	
	@GetMapping("/registerNewUser")
	public String registerNewUser() {
		return "admin/registerNewUser";
	}
	
	@GetMapping("/game-link")
	public String game_link() {
		return "game-link";
	}
	
	@GetMapping("/adminWinnerUserNameAnnounce")
	public String adminWinnerUserNameAnnounce() {
		return "admin/adminWinnerUserNameAnnounce";
	}
}