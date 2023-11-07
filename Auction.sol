// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;
contract english_auction
{
    address payable owner;
    mapping(address=>uint) amount;
    uint highest_bid=0;
    address highest_address;
    bool auction_completed=false;
    uint starttime;
    uint endtime;
    uint duration=2*60;
    constructor(){
        owner=payable (msg.sender);
        starttime=block.timestamp;
        endtime=starttime+duration;
    }
    modifier onlyOwner{
        require(msg.sender==owner);
        _;
    }
    modifier beforeAuction
    {
        require(block.timestamp<endtime);
        _;
    }
    modifier afterAuction
    {
        require(block.timestamp>endtime);
        _;
    }
    function make_bid() public payable beforeAuction 
    {
        require(msg.value>highest_bid,"not highest bid");
        amount[msg.sender]=msg.value;
        highest_address=msg.sender;
        highest_bid=msg.value;
    }
    function withdraw() public beforeAuction
    {
        require(msg.sender!=highest_address,"not high");
        require(amount[msg.sender]>0,"not bid made");
        uint t=amount[msg.sender];
        payable (msg.sender).transfer(t);
    }
    function endAuction() public onlyOwner afterAuction returns (address) 
    {
        if(!auction_completed)
        {
            auction_completed=true;
        }
        payable(highest_address).transfer(highest_bid);
        amount[highest_address]=0;
        return highest_address;
    }
}
