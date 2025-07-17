package com.gamewarrior.Game.Warrior.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.gamewarrior.Game.Warrior.exception.GameException;
import com.gamewarrior.Game.Warrior.model.GameImage;

public interface GameImageService {
	public String uploadGameImage(MultipartFile file) throws IOException;
	
	public void saveTheGameImage(GameImage gameImage);
	
	public List<GameImage> fetchAllGameImage();
	
	public void deleteImage(Integer id) throws GameException;
}
