package com.gamewarrior.Game.Warrior.controller;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import com.gamewarrior.Game.Warrior.configure.SecurityConfig;
import com.gamewarrior.Game.Warrior.exception.AccountRequestException;
import com.gamewarrior.Game.Warrior.exception.MyIdException;
import com.gamewarrior.Game.Warrior.exception.UserException;
import com.gamewarrior.Game.Warrior.model.AccountRequest;
import com.gamewarrior.Game.Warrior.model.Admin;
import com.gamewarrior.Game.Warrior.model.CreateIdRequestDto;
import com.gamewarrior.Game.Warrior.model.Game;
import com.gamewarrior.Game.Warrior.model.MyId;
import com.gamewarrior.Game.Warrior.model.UpiDetail;
import com.gamewarrior.Game.Warrior.model.User;
import com.gamewarrior.Game.Warrior.model.WalletBalanceTransferRequest;
import com.gamewarrior.Game.Warrior.service.AccountRequestService;
import com.gamewarrior.Game.Warrior.service.AdminService;
import com.gamewarrior.Game.Warrior.service.GameService;
import com.gamewarrior.Game.Warrior.service.MyIdService;
import com.gamewarrior.Game.Warrior.service.UpiDetailService;
import com.gamewarrior.Game.Warrior.service.UserService;
import com.gamewarrior.Game.Warrior.service.WalletBalanceTransferRequestService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class AdminController {
	@Autowired
	private AdminService adminService;
	@Autowired
	private MyIdService myIdService;
	@Autowired
	private AccountRequestService accountRequestService;
	@Autowired
	private UserService userService;
	@Autowired
	private GameService gameService;
	@Autowired
    private SecurityConfig securityConfig;
	@Autowired
	private UpiDetailService upiDetailService;
	
	private final String CHARACTER = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    private final int CODE_LENGTH = 8;
	
	@PostMapping("/verifyAdmin")
	public void verifyAdmin(HttpServletRequest request, HttpServletResponse response, @RequestParam String adminEmail, @RequestParam String adminPassword) throws IOException {
		HttpSession session = request.getSession();
		try {
			Admin admin = adminService.verifyAdmin(adminEmail, adminPassword);
			
			session.setAttribute("adminId", admin.getId());
			response.sendRedirect("adminDashboard");
		}
		catch(Exception exception) {
			session.setAttribute("errorMessage", exception.getMessage());
			response.sendRedirect("admin-login");
		}
	}
	
	@GetMapping("/adminLogout")
	public void adminLogoutHandler(HttpServletRequest request, HttpServletResponse response) throws IOException {
		adminService.logoutAdmin(request, response);
	}
	
	@GetMapping("/fetchCreateId")
	public void fetchCreateIdHandler(HttpServletRequest request, HttpServletResponse response) throws AccountRequestException, IOException {
		HttpSession session = request.getSession();
		List<CreateIdRequestDto> createIdRequestDtos = new ArrayList<>();
		List<MyId> myIds= myIdService.fetchAllCreateIdRequest(false);
		
		for(MyId myId: myIds) {
			if(myId.getStatus())
				continue;
			CreateIdRequestDto createIdRequestDto = new CreateIdRequestDto();
			createIdRequestDto.setId(myId.getId());
			createIdRequestDto.setLogo(myId.getLogo());
			createIdRequestDto.setWebsite(myId.getWebsite());
			createIdRequestDto.setWebsiteName(myId.getWebsiteName());
			
//			System.out.println("Hello: "+myId.getAccountRequestId());
			
			AccountRequest accountRequest= accountRequestService.getAccountRequestById(myId.getAccountRequestId());
			
			createIdRequestDto.setAmount(accountRequest.getAmount());
			createIdRequestDto.setExpectedUsername(accountRequest.getProposalUsername());
			
			createIdRequestDtos.add(createIdRequestDto);
		}
		session.setAttribute("createIdRequests", createIdRequestDtos);
		
		response.sendRedirect("createIdRequest");
	}
	
	@PostMapping("/submitUsernameAndPassword")
	public void submitUsernameAndPasswordHandler(@RequestParam String username, @RequestParam String password, @RequestParam Integer id, HttpServletRequest request, HttpServletResponse response) throws MyIdException, IOException {
		HttpSession session = request.getSession();
		MyId myId= myIdService.fetchMyIdById(id);
		
		myId.setUsername(username);
		myId.setPassword(password);
		myId.setStatus(true);
		
		myIdService.saveMyId(myId);
		
		session.setAttribute("message", "Successfully update!");
		response.sendRedirect("fetchCreateId");
	}
	
	@PostMapping("/updateGame")
	public void updateGameLinkHandler(@RequestParam String websiteName, @RequestParam String website, @RequestParam String logo, 
			@RequestParam Integer minimumBet, @RequestParam Integer minimumWithdrawal, @RequestParam Integer minimumMaintainingBalance,
			@RequestParam Integer maximumWithdrawal, HttpServletRequest request, HttpServletResponse response) throws IOException {
		String[] games = request.getParameterValues("game");
		Game game = new Game();
		HttpSession session = request.getSession();
		if(games!=null) {
			System.out.println(games[0]);
			for(String gameName: games) {
				game.getGameName().add(gameName);
			}
		}
		game.setLogo(logo);
		game.setMaximumWithrawal(maximumWithdrawal);
		game.setMinimumBet(minimumBet);
		game.setMinimumMaintainingBalance(minimumMaintainingBalance);
		game.setMinimumWithdrawal(minimumWithdrawal);
		game.setWebsite(website);
		game.setWebsiteName(websiteName);
		
		gameService.saveGame(game);
		
		session.setAttribute("message", "Successfully update the game link!");
		response.sendRedirect("fetchGames");
	}
	
	@GetMapping("/fetchGames")
	public void fetchGamesHandler(HttpServletResponse response, HttpServletRequest request) throws IOException {
		HttpSession session = request.getSession();
		
		request.setAttribute("fetchGames", "fetchGames");
		List<Game> games = gameService.fetchAllGames();
		
		session.setAttribute("games", games);
		response.sendRedirect("updateGameWebsite");
	}
	
	@PostMapping("/deleteGame")
	public void deleteGameHandler(@RequestParam Integer gameId, HttpServletResponse response, HttpServletRequest request) throws IOException{
		HttpSession session = request.getSession();
		
		if(gameService.deleteTheGameById(gameId)) {
			session.setAttribute("message", "Successfully delete the game!");
		}
		else {
			session.setAttribute("errorMessage", "Something went wrong.");
		}
		response.sendRedirect("fetchGames");
	}
	
	@GetMapping("/fetchAllUpi")
	public void fetchAllUpiHandler(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		
		session.setAttribute("fetchAllUpi", "fetchAllUpi");
		
		List<UpiDetail> upiDetails = upiDetailService.fetchAllUpiDetails();
		
		if(upiDetails.isEmpty()) {
			session.setAttribute("errorMessage", "Upi/Account Detail(s) not available! Please contact to Admin.");
		}
		session.setAttribute("upiDetails", upiDetails);
		
		response.sendRedirect("updatePaymentMethod");
	}
	
	@PostMapping("/updateUpi")
	public void updateUpiHandler(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam String displayName, @RequestParam String upiId, @RequestParam String img) throws IOException {
		UpiDetail upiDetail = new UpiDetail();
		HttpSession session = request.getSession();
		
		upiDetail.setDisplayName(displayName);
		upiDetail.setImg(img);
		upiDetail.setUpiId(upiId);
		
		upiDetailService.saveUpiDetail(upiDetail);
		session.setAttribute("message", "Successfully update the UPI link!");
		response.sendRedirect("fetchAllUpi");
	}
	
	@PostMapping("/newUserRegister")
	public ResponseEntity<User> newUserRegisterHandler(@RequestBody Map<String, Object> map) throws NoSuchAlgorithmException, UserException, MessagingException{
		User user = new User();
		
		user.setFirstName((String)map.get("firstName"));
		user.setLastName((String)map.get("lastName"));
		user.setEmail((String) map.get("email"));
		user.setMobile((String)map.get("mobile"));
		user.setPassword(securityConfig.encryptPassword((String)map.get("password")));
		user.setVerify(true);
		user.setReferralCode(generateReferralCode());
		
		return new ResponseEntity<>(userService.registerUser(user), HttpStatus.ACCEPTED);
	}
	
	private String generateReferralCode() {
    	SecureRandom random = new SecureRandom();
    	StringBuilder referralCode = new StringBuilder(CODE_LENGTH);
    	
    	for(int i=0; i<CODE_LENGTH; i++) {
    		int index = random.nextInt(CHARACTER.length());
    		
    		referralCode.append(CHARACTER.charAt(index));
    	}
    	return referralCode.toString();
    }
}