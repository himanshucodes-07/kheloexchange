package com.gamewarrior.Game.Warrior.service;

import java.util.List;

import com.gamewarrior.Game.Warrior.model.Contest;

public interface ContestService {
	public Contest registerInContest(Contest contest);
	
	public boolean isAlreadyExistInContest(Integer userId);
	
	public List<Contest> fetchAllIPLParticipantUser();
}
