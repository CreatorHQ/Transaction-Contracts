pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Transactions is Ownable {
    
    mapping(address => uint256) private amountToAddress;
    uint256 private num_transactions = 0;
    
    uint256 min_val = 100000; // To be set later with the help of chainlink
    uint8 transactionFeePercentage = 5; // make it such that
    uint256 totalTransactionAmount = 0;
    
    modifier checkBalance() {
        require(address(this).balance > 0);
        _;
    }
    
    
    function setTransactionFee(uint8 _transactionFeePercentage) public onlyOwner() {
        transactionFeePercentage = _transactionFeePercentage;
    }
    
    function sendToAddress(address payable to_address, uint256 send_amount) private {
        to_address.transfer(send_amount);
    }
    
    function cryptoTransaction(address to_address) public payable {
        uint256 send_amount = msg.value - (msg.value * transactionFeePercentage / 100);
        amountToAddress[to_address] += send_amount;
        address payable send_address = payable(to_address);
        sendToAddress(send_address, send_amount);
        totalTransactionAmount += msg.value;
        num_transactions++;
    }
    
    //View Balance in smart contract
    function viewAccountBalance() public view onlyOwner() returns (uint256) {
        return address(this).balance;
    }
    

    // Withdraw ETH from the contract
    function withdrawEther() public payable onlyOwner() checkBalance() {
        address payable owner = payable(owner());
        sendToAddress(owner, address(this).balance);
    }

    // Show Transaction percentage fee
    function displayTransactionFee() public view returns(uint8) {
        return transactionFeePercentage;
    }
    
    function viewTotalTransactions() public view onlyOwner() returns(uint256) {
        return num_transactions;
    }
}