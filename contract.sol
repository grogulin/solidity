pragma solidity ^0.5.16;

contract Faucet {
    mapping (address => bool) public list;
    address public owner;
    uint public maxGive = 0.1 ether;
    
    event Sent(address to, uint amount);
    
    constructor () public {
        owner = msg.sender;
    }

    function () external payable {
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    function giveMe(uint _count) public {
        require(_count != 0, "Enter amount, please");
        require(address(this).balance != 0, "Not enough");
        if (address(this).balance < _count) {
                _count = address(this).balance;
            }
        if (msg.sender != owner) {
            require(_count <= maxGive, "Sum is more than 0.1, we're sorry");
            require(list[msg.sender] == false, "2nd point, you're banned");
            list[msg.sender] = true;
        }
        msg.sender.transfer(_count);
        emit Sent(msg.sender, _count);
    }
}
