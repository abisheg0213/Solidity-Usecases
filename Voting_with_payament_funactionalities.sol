// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;
contract voting{
    mapping (address=>bool) public payment;
    struct candidate{
        string name;
        uint no;
    }
    address owner;
    constructor(){
        owner=msg.sender;
    }
    enum Stage{reg,vote,res}
    Stage stage=Stage.reg;
    mapping (address=>candidate) candidates;
    mapping (address=>bool) isvoted;
    address[] can;
    address[] voters;
    function pay_fess() public payable 
    {
        require(msg.value==100);
        payment[msg.sender]=true;
    }
    modifier onlyOwner()
    {
        require(msg.sender==owner);
        _;
    }
    function register_candidate(address can_add,string memory _name) public onlyOwner
    {
        require(payment[can_add]==true,"payament not done");
        require(stage==Stage.reg,"stage problem");
        can.push(can_add);
        candidates[can_add].name=_name;
    }
    function register_voter(address v) public onlyOwner
    {
        require(stage==Stage.reg);
        isvoted[v]=false;
        voters.push(v);
    }
    function vote_for(address cand_add) public 
    {
        require(stage==Stage.vote);
        require(isvoted[msg.sender]==false);
        candidates[cand_add].no+=1;
    }
    function start_vote() public onlyOwner
    {
        stage=Stage.vote;
    }
    function end_vote() public onlyOwner
    {
        stage=Stage.res;
    }
    function delecare_result() public onlyOwner view returns (address) 
    {
        address add;
        uint max=0;
        for (uint i=0;i<can.length;i++)
        {
            if(candidates[can[i]].no>max)
            {
                max=candidates[can[i]].no;
                add=can[i];
            }
        }
        return add;
    }
}
