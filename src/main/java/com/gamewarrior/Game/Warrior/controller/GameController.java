package com.gamewarrior.Game.Warrior.controller;

import java.io.IOException;
import java.util.Collections;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.gamewarrior.Game.Warrior.exception.GameException;
import com.gamewarrior.Game.Warrior.exception.MyIdException;
import com.gamewarrior.Game.Warrior.exception.UserException;
import com.gamewarrior.Game.Warrior.exception.WalletException;
import com.gamewarrior.Game.Warrior.model.Game;
import com.gamewarrior.Game.Warrior.model.GameImage;
import com.gamewarrior.Game.Warrior.model.MyId;
import com.gamewarrior.Game.Warrior.model.User;
import com.gamewarrior.Game.Warrior.model.WalletBalanceTransferRequest;
import com.gamewarrior.Game.Warrior.service.GameImageService;
import com.gamewarrior.Game.Warrior.service.GameService;
import com.gamewarrior.Game.Warrior.service.MyIdService;
import com.gamewarrior.Game.Warrior.service.UserService;
import com.gamewarrior.Game.Warrior.service.WalletBalanceTransferRequestService;
import com.gamewarrior.Game.Warrior.service.WalletService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class GameController {
	@Autowired
	private GameService gameService;
	@Autowired
	private GameImageService gameImageService;
	@Autowired
	private HttpServletRequest urlRequest;
	@Autowired
	private UserService userService;
	@Autowired
	private MyIdService myIdService;
	@Autowired
	private WalletService walletService;
	@Autowired
	private WalletBalanceTransferRequestService walletBalanceTransferRequestService;
	
	@GetMapping("/gameLink")
	public ResponseEntity<List<Game>> fetchGames(){
		List<Game> games = gameService.fetchAllGames();
		
		return new ResponseEntity<List<Game>>(games, HttpStatus.OK);
	}
	
	@GetMapping("/fetchIdDetails")
	public void fetchIdDetailsHandler(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		
		session.setAttribute("idDetails", "idDetails");
		
		try {
			List<Game> games = gameService.fetchAllGames();
			System.out.println(games);
			List<MyId> myIds =  gameService.fetchMyIds(session);
			
			session.setAttribute("games", games);
			session.setAttribute("myIds", myIds);
		}
		catch(UserException userException) {
			session.setAttribute("errorMessage", "Invalid User! please login");

		}
		response.sendRedirect("ids");
	}
	
	@PostMapping("/fetchGameLink")
	@ResponseBody
	public ResponseEntity<List<MyId>> fetchMyGameLink(@RequestBody Map<String, Object> map){
		Integer userId = (Integer) map.get("id");
		
		return new ResponseEntity<>(gameService.fetchMyGame(userId), HttpStatus.ACCEPTED);
	}
	
	@GetMapping("/fetchMyId")
	public void fetchMyIdHandler(HttpServletResponse response, HttpServletRequest request) throws IOException {
		HttpSession session = request.getSession();
		
		try {
			List<MyId> myIds =  gameService.fetchMyIds(session);
		
			session.setAttribute("myIds", myIds);
			response.sendRedirect("walletBalanceTransferToAnotherWebsiteRequest");
		}
		catch(UserException userException) {
			session.setAttribute("errorMessage", userException.getMessage());
			response.sendRedirect("login");
		}
	}
	
	@PostMapping("/fetchGame")
	public String fetchGameDetailHandler(HttpServletResponse response, HttpServletRequest request) throws IOException {
		HttpSession session = request.getSession();
		Integer userId= (Integer)session.getAttribute("userId");
		
		if(userId==null) {
			session.setAttribute("errorMessage", "Invalid user!! please Login");
			response.sendRedirect("login");
		}
		else {
			Integer gameId= Integer.parseInt(request.getParameter("gameId"));
			
			if(gameId==null) {
				response.sendRedirect("ids");
			}
			else {
				try {
					Game game= gameService.fetchGameById(gameId);
					
					request.setAttribute("game", game);
				}
				catch (Exception exception) {
					session.setAttribute("errorMessage", "Invalid Game");
					response.sendRedirect("ids");
				}
			}
		}
		return "create-id";
	}
	
	@PostMapping("/processCreateId")
	public void processCreateIdRequestHandler(HttpServletRequest request, HttpServletResponse response, @RequestParam Integer gameId, @RequestParam Double amount, @RequestParam String username) throws GameException, IOException, MessagingException {
		HttpSession session = request.getSession();
		Integer userId = (Integer) session.getAttribute("userId");
		
		try {
			gameService.createIdRequest(userId, gameId, username, amount, session);
			
			session.setAttribute("message", "Request has been taken. It will be process within 2 days.");
			response.sendRedirect("fetchIdDetails");
		}
		catch(UserException userException) {
			session.setAttribute("errorMessage", userException.getMessage());
			response.sendRedirect("login");
		}
		catch(GameException gameException) {
			session.setAttribute("errorMessage", gameException.getMessage());
			response.sendRedirect("ids");
		}
		catch(Exception exception) {
			session.setAttribute("errorMessage", exception.getMessage());
			response.sendRedirect("ids");
		}
	}
	
	@PostMapping("/gameImageUpload")
	public void gameImageUploadHandler(@RequestParam MultipartFile file, @RequestParam String subject, @RequestParam String message,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		GameImage gameImage = new GameImage();
		
		gameImage.setMessage(message);
		gameImage.setSubject(subject);
		
		String filename = gameImageService.uploadGameImage(file);
		String baseUrl = ServletUriComponentsBuilder.fromRequestUri(urlRequest).replacePath(null).build().toUriString();
		String path = baseUrl + "/uploads/admin/" + filename;
		path = path.replace("127.0.0.1:4050", "kheloexchanges.com");
		
		gameImage.setImageLink(path);
		
		gameImageService.saveTheGameImage(gameImage);
		session.setAttribute("message", "Image successfully uploaded");
		response.sendRedirect("fetchGameImages");
	}
	
	@GetMapping("/fetchGameImages")
	public void fetchGameImagesHandler(HttpServletRequest request, HttpServletResponse response) throws IOException {
		List<GameImage> gameImages =gameImageService.fetchAllGameImage();
		HttpSession session = request.getSession();
		
		session.setAttribute("gameImages", gameImages);
		response.sendRedirect("newGameImageUpload");
	}
	
	@PostMapping("/deleteImage")
	public void deleteImageHandler(@RequestParam Integer id, HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		
		try {
			gameImageService.deleteImage(id);
			session.setAttribute("message", "Image successfully deleted!");
		}
		catch(Exception exception) {
			session.setAttribute("errorMessage", exception.getMessage());
		}
		response.sendRedirect("/fetchGameImages");
	}
	
	@GetMapping("/home")
	public String newGameImagesHandler(HttpSession session) {
		List<GameImage> gameImages= gameImageService.fetchAllGameImage();
		
		Collections.sort(gameImages, (a, b) -> b.getId().compareTo(a.getId()));
		
		session.setAttribute("gameImages", gameImages);
		
		return "index"; 
	}
	
	@PostMapping("/changePasswordMyId")
	public ResponseEntity<MyId> changePasswordMyIdHandler(@RequestBody Map<String, Object> map) throws MyIdException {
		Integer id = Integer.parseInt(map.get("id").toString());
		String password = (String) map.get("password");
		
		return new ResponseEntity<> (myIdService.changePasswordOfMyId(id, password), HttpStatus.ACCEPTED);
	}
	
	@ResponseBody
	@PostMapping("/takeRequestForWalletMoneyDeposit")
	public WalletBalanceTransferRequest takeRequestForWalletMoneyDepositHandler(@RequestBody Map<String, Object> map, HttpServletRequest request, HttpServletResponse response) throws UserException, MyIdException, WalletException {
		HttpSession session = request.getSession();
		
		Integer userId = (Integer) session.getAttribute("userId");
		
		String game= (String) map.get("id");
		Integer myGameId = Integer.parseInt(game);
		
		String amountInString = (String) map.get("amount");
		Double amount = Double.parseDouble(amountInString);
		
		User user = userService.fetchProfile(userId);
		MyId myId = myIdService.fetchMyIdById(myGameId);
		
		WalletBalanceTransferRequest walletBalanceTransferRequest = new WalletBalanceTransferRequest();
		walletBalanceTransferRequest.setAmount(amount);
		walletBalanceTransferRequest.setMobile(user.getMobile());
		walletBalanceTransferRequest.setName(user.getFirstName()+" "+user.getLastName());
		walletBalanceTransferRequest.setWebsite(myId.getWebsite());
		walletBalanceTransferRequest.setWebsiteName(myId.getWebsiteName());
		walletBalanceTransferRequest.setWebsiteUsername(myId.getUsername());
		walletBalanceTransferRequest.setUserId(userId);
		
		if(walletService.walletAmountDeduction(amount, userId, session, "wallet balance transfer to "+ myId.getWebsiteName())) {
			return walletBalanceTransferRequestService.saveWalletBalanceTransferRequestObject(walletBalanceTransferRequest);
		}
		else {
			throw new WalletException("Insufficent balance!");
		}
	}
}