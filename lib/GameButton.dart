import 'package:flutter/material.dart';
class GameButton {
    final id;
    String text;
    bool enabled;

    GameButton({this.id, this.text = " ", this.enabled = true});
}

class Board {
    List<GameButton> cell;

    Board(bool pcFirst){
        cell = <GameButton>[
            new GameButton(),
            new GameButton(),
            new GameButton(),
            new GameButton(),
            new GameButton(),
            new GameButton(),
            new GameButton(),
            new GameButton(),
            new GameButton(),
        ];

        if(pcFirst){
            this.cell[compMove()].text = 'O';
        }
    }

    String checkWin(Board board){
        if(isWinner(board, 'O')) return "Sorry, O\'s won this time!";
        else if(isWinner(board, 'X')) return "X\'s won this time! Good Job!";
        else if(getPossibleMoves(this).length == 0) return "Tie Game!";
        else return "";
    }

    String playerMove(move){
        if(this.cell[move].text == ' '){
            this.cell[move].text = 'X';
            if(checkWin(this) != ""){
                for(int i=0;i<this.cell.length;i++){
                    this.cell[i].enabled = false;
                }
                return checkWin(this);
            }
            this.cell[compMove()].text = 'O';
            if(checkWin(this) != ""){
                for(int i=0;i<this.cell.length;i++){
                    this.cell[i].enabled = false;
                }
                return checkWin(this);
            }
            return "false";
        } else {
            return "Sorry, this space is occupied!";
        }
    }

    bool isWinner(Board bo, String le){
        return (bo.cell[6].text == le && bo.cell[7].text == le && bo.cell[8].text == le)
            || (bo.cell[3].text == le && bo.cell[4].text == le && bo.cell[5].text == le)
            ||(bo.cell[0].text == le && bo.cell[1].text == le && bo.cell[2].text == le)
            ||(bo.cell[0].text == le && bo.cell[3].text == le && bo.cell[6].text == le)
            ||(bo.cell[1].text == le && bo.cell[4].text == le && bo.cell[7].text == le)
            ||(bo.cell[2].text == le && bo.cell[5].text == le && bo.cell[8].text == le)
            ||(bo.cell[0].text == le && bo.cell[4].text == le && bo.cell[8].text == le)
            ||(bo.cell[2].text == le && bo.cell[4].text == le && bo.cell[6].text == le);
    }

    int evaluate(Board board){
        if(isWinner(board, 'O')) return 1;
        else if(isWinner(board, 'X')) return -1;
        else return 0;
    }
    List<int> minmax(Board cloneB, int depth, String player){
        int infinity = 9999999;
        List<int> best, score;
        if(player == 'O') best = [-1, -infinity];
        else best = [-1, infinity];
        
        if(depth == 0 || evaluate(cloneB) != 0) return [-1, evaluate(cloneB)];

        for(int step in getPossibleMoves(cloneB)){
            cloneB.cell[step].text = player;
            score = minmax(cloneB, depth - 1, (player=='O'?'X':';O'));
            cloneB.cell[step].text = ' ';
            score[0] = step;

            if(player == 'O' && score[1] > best[1]) best = score;
            else if(player == 'X' && score[1] < best[1]) best = score;
        }
        return best;
    }
    List<int> getPossibleMoves(Board board){
        List<int> output = [];
        for(int i=0;i<board.cell.length;i++){
            if(board.cell[i].text == ' ') output.add(i);
        }
        return output;
    }
    int compMove(){
        int depth = getPossibleMoves(this).length;
        if(depth == 0) return -1;
        else if(depth == 9) return 4;
        else return minmax(this, depth, 'O')[0];
    }
}