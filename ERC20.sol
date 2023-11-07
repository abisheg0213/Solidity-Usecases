pragma solidity ^0.8.14;
contract ERC20
{
string public token_name;
string public token_symbol;
uint public total_supply;
uint public mint_price=10;
event token_minted(address person,uint nooftokens);
event token_tranfer(address sender,address recv,uint amount);
event token_spent(address sender,address spender,address revc,uint amount);
constructor(string memory a,string memory b,uint tol)
{
token_name=a;
token_symbol=b;
total_supply=tol;
}
mapping(address=>uint)public balances;
mapping (address=>mapping (address=>uint)) public allowance;
function minttoken(uint no_of_tokens) public payable
{

1

require(msg.value>=(no_of_tokens*mint_price),"mint price not provided");
require(no_of_tokens<=total_supply);
balances[msg.sender]+=no_of_tokens;
emit token_minted(msg.sender, no_of_tokens);
}
function transfer(address revc,uint amount) public
{
require(balances[msg.sender]>=amount,"balance not sufficient");
balances[msg.sender]-=amount;
balances[revc]+=amount;
emit token_tranfer(msg.sender,revc,amount);
}
function make_allowance(address spender,uint amount) public
{
require(balances[msg.sender]>=amount,"balance not sufficient");
allowance[msg.sender][spender]=amount;
}
function transfer_from(address sender,address revc,uint amount) public
{
require(allowance[sender][msg.sender]>=amount,"balance not sufficient");
balances[sender]-=amount;
balances[revc]+=amount;
emit token_spent(sender, msg.sender, revc, amount);
}

2

}
