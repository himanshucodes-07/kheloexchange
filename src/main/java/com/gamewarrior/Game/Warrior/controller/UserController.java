package com.gamewarrior.Game.Warrior.controller;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gamewarrior.Game.Warrior.dao.UserRepo;
import com.gamewarrior.Game.Warrior.exception.ContestException;
import com.gamewarrior.Game.Warrior.exception.UserException;
import com.gamewarrior.Game.Warrior.exception.WalletException;
import com.gamewarrior.Game.Warrior.model.Contest;
import com.gamewarrior.Game.Warrior.model.DepositRequest;
import com.gamewarrior.Game.Warrior.model.Message;
import com.gamewarrior.Game.Warrior.model.MyId;
import com.gamewarrior.Game.Warrior.model.User;
import com.gamewarrior.Game.Warrior.model.WalletBalanceTransferRequest;
import com.gamewarrior.Game.Warrior.model.WithdrawRequest;
import com.gamewarrior.Game.Warrior.service.ClientService;
import com.gamewarrior.Game.Warrior.service.ContestService;
import com.gamewarrior.Game.Warrior.service.DepositRequestService;
import com.gamewarrior.Game.Warrior.service.MyIdService;
import com.gamewarrior.Game.Warrior.service.UserService;
import com.gamewarrior.Game.Warrior.service.WalletBalanceTransferRequestService;
import com.gamewarrior.Game.Warrior.service.WalletService;
import com.gamewarrior.Game.Warrior.service.WithdrawRequestService;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {
	@Autowired
	private UserService userService;
	@Autowired
	private ClientService clientService;
	@Autowired
	private MyIdService myIdService;
	@Autowired
	private DepositRequestService depositRequestService;
	@Autowired
	private WithdrawRequestService withdrawRequestService;
	@Autowired
	private ContestService contestService;
	@Autowired
	private WalletService walletService;
	@Autowired
	private WalletBalanceTransferRequestService walletBalanceTransferRequestService;

	@GetMapping("/logout")
	public void logout(HttpServletRequest request, HttpServletResponse response) throws IOException {
		userService.logout(request, response);
	}
	
	@PostMapping("/forgotpassword")
	public void forgetPasswordHandler(@RequestParam String email, HttpServletRequest request, HttpServletResponse response) throws MessagingException, IOException {
		HttpSession session = request.getSession();
		
		try {
			userService.forgetPassword(email);
			session.setAttribute("forgotemail", email);
			
			response.sendRedirect("forgot-otp");
		}
		catch(UserException exception) {
			session.setAttribute("errorMessage", exception.getMessage());
			
			response.sendRedirect("registration");
		}
	}
	
	
	@PostMapping("/updatepassword")
	public void updatePasswordHandler(@RequestParam String password, @RequestParam String confirmPassword, HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		
		if(!password.equals(confirmPassword)) {
			session.setAttribute("errorMessage", "Password does not match");
			System.out.println("Hi");
			response.sendRedirect("changePassword");
		}
		else {
			try {
				userService.updatePassword(password, session);
				
				session.setAttribute("message", "Greeting! Successfully reset/change your password. Please login");
				
				response.sendRedirect("login");
			} catch (Exception exception) {
				session.setAttribute("errorMessage", exception.getMessage());
				
				response.sendRedirect("registration");
			}
		}
	}
	
	@GetMapping("/resentOtp")
	public void resentOtpHandler(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		String userEmail = (String)session.getAttribute("email");
		
		if(userEmail==null) {
			session.setAttribute("errorMessage", "Unauthorized user!!");
			
			response.sendRedirect("/registration");
		}
		else {
			try {
				userService.resentOtp(userEmail);
				
				session.setAttribute("message", "Otp resent successfully");
			} catch (Exception e) {
				session.setAttribute("errorMessage", "Something went wrong!!");
			}
			response.sendRedirect("otp");
		}
	}
	
	@GetMapping("/resentForgetOtp")
	public void resentForgetOtpHandler(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		String userEmail = (String)session.getAttribute("forgotemail");

		if(userEmail==null) {
			session.setAttribute("errorMessage", "Unauthorized user!!");
			
			response.sendRedirect("/registration");
		}
		else {
			try {
				userService.resentOtp(userEmail);
				
				session.setAttribute("message", "Otp resent successfully");
			} catch (Exception e) {
				session.setAttribute("errorMessage", "Something went wrong!!");
			}
			response.sendRedirect("forgot-otp");
		}
	}
	
	@GetMapping("/fetchProfile")
	public void fetchProfileDataHandler(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		Integer userId= (Integer)session.getAttribute("userId");
		
		try {
			User user = userService.fetchProfile(userId);
			
			request.setAttribute("email", user.getEmail());
			request.setAttribute("name", user.getFirstName()+" "+user.getLastName());
			request.setAttribute("referralCode", user.getReferralCode());
			request.setAttribute("referralPoint", user.getReferralPoint());
			
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("profile");
			
			requestDispatcher.include(request, response);
		} catch (Exception exception) {
			session.setAttribute("errorMessage", exception.getMessage());
			
			response.sendRedirect("login");
		}
	}
	
    @GetMapping("/fetchPendingRequest")
    public void fetchPendingRequestHandler(HttpServletRequest request, HttpServletResponse response) throws IOException {
    	HttpSession session = request.getSession();
    	Integer userId = (Integer)session.getAttribute("userId");
    	
    	List<MyId> pendingMyIds= myIdService.pendingRequestofMyIdForPerticularUserId(userId);
    	List<DepositRequest> pendingDepositRequests = depositRequestService.fetchPendingDepositRequestByUserId(userId);
    	List<WithdrawRequest> pendingWithdrawRequests = withdrawRequestService.fetchPendingWithdrawRequestByUserId(userId);
    	List<WalletBalanceTransferRequest> pendingWalletBalanceTransferRequests =
    			walletBalanceTransferRequestService.findPendingWalletBalanceTransferRequests(userId, false);
    	
    	session.setAttribute("pendingMyIds", pendingMyIds);
    	session.setAttribute("pendingDepositRequests", pendingDepositRequests);
    	session.setAttribute("pendingWithdrawRequests", pendingWithdrawRequests);
    	session.setAttribute("pendingWalletBalanceTransferRequests", pendingWalletBalanceTransferRequests);
    	
    	response.sendRedirect("/pendingRequest");
    }
    
    @ResponseBody
    @PostMapping("/registerInContest")
    public Contest registerInContestHandler(@RequestBody Map<String, Object> map, HttpServletRequest request, HttpServletResponse response) throws IOException, ContestException, WalletException, UserException {
    	String teamName = (String) map.get("teamName");
    	HttpSession session = request.getSession();
    	Integer userId = (Integer) session.getAttribute("userId");
    	
    	if(contestService.isAlreadyExistInContest(userId)) {
    		throw new ContestException("You already registered in contest!");
    	}
    	else {
    		if(walletService.walletAmountDeduction(1000.0, userId, session, "IPL Prediction contest participate")) {
    			Contest contest = new Contest();
		    	
    			try {
		    		User user = userService.fetchProfile(userId);
		    		
		    		contest.setEmail(user.getEmail());
		    		contest.setMobile(user.getMobile());
		    		contest.setTeamName(teamName);
		    		contest.setUserId(userId);
		    		contest.setName(user.getFirstName()+" "+user.getLastName());
		    	}
		    	catch(UserException userException) {
		    		walletService.walletAmountAddition(1000.0, userId, session, "Refund");
		    		throw new ContestException("Something went wrong!");
		    	}
		    	contest = contestService.registerInContest(contest);
		    	
		    	return contest;
    		}
    		else {
    			throw new ContestException("Insufficient balance, Contest participate fee is "+1000);
    		}
    	}
    }
    
    @GetMapping("/fetchAllIplContestParticipantUser")
    public void fetchAllIplContestParticipantUserHandler(HttpServletRequest request, HttpServletResponse response) throws IOException {
    	HttpSession session = request.getSession();
    	List<Contest> list = contestService.fetchAllIPLParticipantUser();
    	System.out.println(list);
    	session.setAttribute("iplContestParticipantUser", list);
    	response.sendRedirect("/contestParticipantInformation");
    }
    
    @PostMapping("/allUser")
    @ResponseBody
    public ResponseEntity<List<User>> allUserHandler(){
    	return new ResponseEntity<> (userService.fetchAllUser(), HttpStatus.ACCEPTED);
    }
    
    @PostMapping("/changePasswordUser")
    public ResponseEntity<User> changePasswordUserHandler(@RequestBody Map<String, Object> map) throws UserException, NoSuchAlgorithmException, MessagingException{
    	Integer id = Integer.parseInt(map.get("id").toString());
    	String password = (String) map.get("password");
    	
    	return new ResponseEntity<>(userService.changePassword(id, password), HttpStatus.ACCEPTED);
    }
}