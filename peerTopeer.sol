// SPDX-License-Identifier: MIT
pragma solidity 0.8.14;
contract peerLeanding
{
    mapping (address=>uint) public loan_made;
    mapping (address=> mapping (address=>uint)) public barrow_made;
    function make_loan(uint amount) public {
        loan_made[msg.sender]=amount;
    }
    function pay(address ad,uint am) private   
    {
        payable (ad).transfer(am);
    }
    function lend(address rec) public payable {
        require(msg.value==loan_made[rec]);
        barrow_made[msg.sender][rec]=msg.value;
    pay(rec,msg.value);
    }
    function repay(address lender) public payable {
        pay(lender,msg.value);
        barrow_made[lender][msg.sender]=0;
    }
}
