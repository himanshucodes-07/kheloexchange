package com.gamewarrior.Game.Warrior.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gamewarrior.Game.Warrior.dao.ContestRepo;
import com.gamewarrior.Game.Warrior.model.Contest;

@Service
public class ContestServiceImpl implements ContestService{
	@Autowired
	private ContestRepo contestRepo;
	
	@Override
	public Contest registerInContest(Contest contest) {
		return contestRepo.save(contest);
	}

	@Override
	public boolean isAlreadyExistInContest(Integer userId) {
		Contest contest= contestRepo.findByUserId(userId);
		return contest!= null ? true : false;
	}

	@Override
	public List<Contest> fetchAllIPLParticipantUser() {
		return contestRepo.findAll();
	}

}
