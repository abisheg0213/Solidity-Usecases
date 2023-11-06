// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;
contract micro_finance
{
    mapping (address=>uint) invesment_made;
    struct inves{
        address investor;
        uint amount_made;
        uint timestamp;
        bool renewed;
        uint interest_amount;
    }
    uint public invest_rate=3;
    uint public loan_rate=4;
    mapping (uint =>inves) public  inves_log;
    mapping (address=>uint) public  loan_got;
     struct loan{
        address loan_person;
        uint amount_made;
        uint timestamp;
        bool repaid;
        uint interest_amount;
    }
    mapping (uint =>loan) loan_log;
    uint inves_id=0;
    uint loan_id=0;
    function make_invesment() public payable 
    {
        inves_id+=1;
        inves_log[inves_id].investor=msg.sender;
        inves_log[inves_id].amount_made=msg.value;
        inves_log[inves_id].timestamp=block.timestamp;
        inves_log[inves_id].renewed=false;
        invesment_made[msg.sender]=msg.value;
    }
    function renew_investment(uint invesid) public 
    {
        require(msg.sender==inves_log[invesid].investor,"only investor");
        inves_log[invesid].renewed=true;
        invesment_made[msg.sender]=0;
        
        uint interest=(((block.timestamp-inves_log[invesid].timestamp)/60)*inves_log[inves_id].amount_made*invest_rate)/100;
       inves_log[invesid].interest_amount=interest;
        payable (msg.sender).transfer(inves_log[inves_id].amount_made+interest);
    }
    function get_loan(uint req_amount) public 
    {
        loan_id+=1;
        loan_log[loan_id].loan_person=msg.sender;
        loan_log[loan_id].amount_made=req_amount;
        loan_log[loan_id].timestamp=block.timestamp;
        loan_log[loan_id].repaid=false;
        loan_got[msg.sender]=req_amount;
        payable (msg.sender).transfer(req_amount);
    }
    function repay_loan(uint loanid) public payable 
    {
         require(msg.sender==loan_log[loan_id].loan_person,"only loan person");
        loan_log[loan_id].repaid=true;
        loan_got[msg.sender]=0;
    }
    function get_repay_amount(uint id) public view returns(uint)
    {
        return ((((block.timestamp-loan_log[id].timestamp)/60)*loan_log[id].amount_made*4)/100)+loan_log[id].amount_made;
    }
}
