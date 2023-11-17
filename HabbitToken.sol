pragma solidity 0.8.14;
contract habit{
    string public Tokenname;
    string public Token_symbol;
    mapping (address=>uint) balance;
    uint public totalSupply;
    address owner;
    uint reward_amount;
    struct habit{
        address user;
        string habitname;
        bool isCompleted;
    }
    mapping (address => habit) userHabit;
    constructor(string memory _tn,string memory _ts,uint _totalsupply)
    {
        owner=msg.sender;
        Tokenname=_tn;
        Token_symbol=_ts;
        totalSupply=_totalsupply;
        balance[address(this)]=_totalsupply;   
    }
    function create_Habit(string memory name) public {
userHabit[msg.sender].user=msg.sender;
userHabit[msg.sender].habitname=name;
userHabit[msg.sender].isCompleted=false;
    }
    function complete_habit() public {
        userHabit[msg.sender].isCompleted=true;
        balance[msg.sender]+=reward_amount;
        balance[address(this)]-=reward_amount;
    }
    function setReward(uint amount) public 
{
    require(msg.sender==owner);
    reward_amount=amount;
}
function withdraw() public {
   uint t= balance[address(this)];
   balance[address(this)]-=t;
   balance[owner]+=t;

}
function balanceOf(address ad) public view returns(uint){
    return balance[ad];
}
}
