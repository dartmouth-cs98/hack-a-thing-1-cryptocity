pragma solidity ^0.4.11;

pragma solidity ^0.4.11;

contract Casino {
   address owner;
   function Casino(uint _minimumBet){
      owner = msg.sender;
      if(_minimumBet != 0 ) minimumBet = _minimumBet;
   }
   function kill(){
      if(msg.sender == owner)
         selfdestruct(owner);
   }

   uint minimumBet;
   uint totalBet;
   uint numberOfBets;
   uint maxAmountOfBets = 100;
   address[] players;
   struct Player {
      uint amountBet;
      uint numberSelected;
   }
   mapping(address => Player) playerInfo;

   // To bet for a number between 1 and 10 both inclusive

  function bet(uint number) payable{
     assert(checkPlayerExists(msg.sender) == false);
     assert(number >= 1 && number <= 10);
     assert(msg.value >= minimumBet);
     playerInfo[msg.sender].amountBet = msg.value;
     playerInfo[msg.sender].numberSelected = number;
     numberOfBets += 1;
     players.push(msg.sender);
     totalBet += msg.value;

     if(numberOfBets >= maxAmountOfBets) generateNumberWinner();

  }

  function checkPlayerExists(address player) returns(bool){
     for(uint i = 0; i < players.length; i++){
        if(players[i] == player) return true;
     }
     return false;
  }

  // Generates a number between 1 and 10
  function generateNumberWinner(){
     uint numberGenerated = block.number % 10 + 1; // This isn't secure
     distributePrizes(numberGenerated);
  }


}
