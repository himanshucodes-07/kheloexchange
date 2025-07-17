package com.gamewarrior.Game.Warrior.service;

import java.util.List;
import java.util.Map;

import com.gamewarrior.Game.Warrior.model.Match;

public interface MatchService {

    List<Match> getAllMatches();

    List<Match> getLiveMatches();

    List<List<String>> getPointTable();
}
