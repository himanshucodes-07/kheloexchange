package com.gamewarrior.Game.Warrior.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.gamewarrior.Game.Warrior.model.Match;
import com.gamewarrior.Game.Warrior.service.MatchService;

import java.util.List;

@RestController
@RequestMapping("/match")
public class MatchController {

    @Autowired
    private MatchService matchSerivce;

    public MatchController(MatchService matchSerivce) {
        this.matchSerivce = matchSerivce;
    }

    @GetMapping("/live")
    public ResponseEntity<List<Match>> getLiveMatches() {
        return new ResponseEntity<>(this.matchSerivce.getLiveMatches(), HttpStatus.OK);
    }

    @GetMapping("/")
    public ResponseEntity<List<Match>> getAllMatches(){
        return new ResponseEntity<>(this.matchSerivce.getAllMatches(), HttpStatus.OK);
    }

    @GetMapping("/point-table")
    public ResponseEntity<?> getPointTable() {
        return new ResponseEntity<>(this.matchSerivce.getPointTable(), HttpStatus.OK);
    }
}

