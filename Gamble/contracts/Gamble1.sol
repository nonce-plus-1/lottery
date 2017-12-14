pragma solidity ^0.4.14;

contract Gamble1 {

    // stores the entries into an array
    address[] public entries;

   
    uint public winNum;
    uint ticketSize;

    // stores the winning 
    address[] public winningEntries;

    function Gamble1() {
        ticketSize = 10;
    }
    

    // return the amount entries that have been stored into the array
    function getArraySize() constant returns (uint) {
        
        return entries.length;
    }
    /* 
        finds the winners that are linked in sets of 'X' and then push the winnners from the 
        entries array to the new array we created called "winningEntries"
    */
    function findWinners(uint powerB) {

        for (uint i = powerB + 1 ; i < entries.length; i += ticketSize) {
             
             winningEntries.push(entries[i]);

            }
    }

    /*
        stores the entries into the array and returns it when called.
    */
    function getEntries() constant returns (address[]) {
        return entries;
    }
    /*
     returns the winners from the array that has been pulled. 
    */ 
    function getWinners() constant returns(address[]) {
        return winningEntries;
    }

    /*
        to distribute payment, we must first get the number of winners by doins a modulo
        to see how many winners their should be. then get the reward amount by dividing the 
        contract balance into the number of winners. once that is said and done, loop through 
        the winners in the array to make sure the dispribute has been sucessful.
    */
    function distributePay() {

        uint numberOfWinners = entries.length % ticketSize;

        uint reward = this.balance / numberOfWinners;

        for (uint i = 0; i < numberOfWinners; i++) {
            winningEntries[i].transfer(reward);
        }

        
    }

    /*
        create a payable function to initiate the contract only with ETH.
    */

    function() payable {

        entries.push(msg.sender);
        }


    }

    





/*

Gamble1.deployed().then(function(instance){gamble = instance})
amount = web3.toWei(1, "ether")
var account1 = web3.eth.accounts[0]
var account2 = web3.eth.accounts[1]
var account3 = web3.eth.accounts[2]

web3.eth.sendTransaction({to:gamble.address , from: account1 , value: amount })
*/