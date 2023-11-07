pragma solidity ^0.8.14;
contract marketplace{
    enum jobStatus{created,bid_made,bid_accepted,completed}
    struct job
    {
        string jobname;
        address owner;
        address freelancher;
        uint amount;
        jobStatus status;
    }
    uint jobid=0;
    mapping(uint=> job) public jobs;
    function craete_job(string memory _name) public{
        jobid+=1;
        jobs[jobid].jobname=_name;
        jobs[jobid].owner=msg.sender;
        jobs[jobid].status=jobStatus.created;
    }
    function make_bid(uint id,uint _amount) public {
        jobs[id].freelancher=msg.sender;
        jobs[id].amount=_amount;
        jobs[id].status=jobStatus.bid_made;
    }
    function accept_bid(uint id) public payable 
    {
        require(jobs[id].owner==msg.sender);
        jobs[id].status=jobStatus.bid_accepted;
    }
    function complete_job(uint id) public 
    {
        require(jobs[id].freelancher==msg.sender);
        payable (jobs[id].freelancher).transfer(jobs[id].amount);
        jobs[id].status=jobStatus.completed;
    }
}
