package com.gamewarrior.Game.Warrior.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.gamewarrior.Game.Warrior.dao.GameImageRepo;
import com.gamewarrior.Game.Warrior.exception.GameException;
import com.gamewarrior.Game.Warrior.model.GameImage;

@Service
public class GameImageServiceImpl implements GameImageService{
	@Autowired
	private GameImageRepo gameImageRepo;

	@Override
	public String uploadGameImage(MultipartFile file) throws IOException {
		String uploadDir= "uploads";
		uploadDir = createTheFolder(uploadDir+"\\admin");
		String uniqueFileName = generateUniqueFilename(file.getOriginalFilename());
		
		Files.copy(file.getInputStream(), Paths.get(uploadDir+File.separator+uniqueFileName), StandardCopyOption.REPLACE_EXISTING);
		
		return uniqueFileName;
	}

	private String createTheFolder(String location) {
		File file= new File(location);
		
		System.out.println(file.mkdirs());
		
		return location;
	}
	
	private String generateUniqueFilename(String originalFilename) {
        // Get current date and time
        LocalDateTime now = LocalDateTime.now();
        
        // Format the date and time
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmssSSS");
        String formattedDateTime = now.format(formatter);
        
        // Get file extension
        String extension = "";
        int lastIndex = originalFilename.lastIndexOf('.');
        if (lastIndex >= 0) {
            extension = originalFilename.substring(lastIndex);
        }
        
        // Concatenate formatted date/time with a unique identifier
        String uniqueFilename = formattedDateTime + "_" + generateRandomString(6) + extension;
        return uniqueFilename;
    }

    private String generateRandomString(int length) {
        // Generate a random string (you can replace this with any other logic)
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < length; i++) {
            int index = (int) (Math.random() * chars.length());
            sb.append(chars.charAt(index));
        }
        return sb.toString();
    }

	@Override
	public void saveTheGameImage(GameImage gameImage) {
		gameImageRepo.save(gameImage);
	}

	@Override
	public List<GameImage> fetchAllGameImage() {
		return gameImageRepo.findAll();
	}

	@Override
	public void deleteImage(Integer id) throws GameException {
		GameImage gameImage = findGameImageObject(id);
		
		gameImageRepo.delete(gameImage);
	}
	
	private GameImage findGameImageObject(Integer id) throws GameException {
		return gameImageRepo.findById(id).orElseThrow(()-> new GameException("Something went wrong!"));
	}
}
