// SPDX-License-Identifier: MIT
pragma solidity 0.8.14;
contract Escrow{
    uint deposit_count;
    mapping (bytes32=> uint) public depoit_hash;
    function create_hash(uint amount)public view returns (bytes32)
    {
        return keccak256(abi.encode(msg.sender,amount,deposit_count));
    }
    function deposit(bytes32 hash) public payable 
    {
        require(hash!=0);
        require(depoit_hash[hash]==0);
        require(msg.value>0);
        depoit_hash[hash]=msg.value;
        deposit_count+=1;
    }
    function withdraw(bytes32 hash,address rec) public {
        require(hash!=0);
        require(depoit_hash[hash]>0);
        payable (rec).transfer(depoit_hash[hash]);
        depoit_hash[hash]=0;
    }

}
