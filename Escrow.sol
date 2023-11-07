// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;
contract escrow{
    address agent;
    constructor()
    {
        agent=msg.sender;
    }
    event deposit_made(address payee,uint amount);
    event withdraw_made(address payee,uint amount);
    mapping (address=>uint) deposits;
    modifier onlyAgent{
        require(msg.sender==agent);
        _;
    }
    function deposit(address payee) public payable onlyAgent
    {
        deposits[payee]+=msg.value;
        emit deposit_made(payee, msg.value);
    }
    function withdraw(address payee) public onlyAgent
    {
        payable(payee).transfer(deposits[payee]);
        emit withdraw_made(payee,deposits[payee] );
        deposits[payee]=0;
    } 
}
