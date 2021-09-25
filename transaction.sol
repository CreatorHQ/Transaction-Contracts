pragma solidity ^0.8.0;

contract Transactions {
    
    mapping(address => uint256) private amountToAddress;
    
    uint256 min_val = 100000; // To be set later with the help of chainlink
    uint8 transaction_percentage = 5; // make it such that 
    
    function cryptoTransaction(address payable to_address) public payable {
        if(msg.value < min_val) {
            revert();
        uint256 send_amount = msg.value - (msg.value * transaction_percentage / 100);
        amountToAddress[to_address] += send_amount;
        to_address.transfer(send_amount);
        
        }
    }
    
    // // Withdraw ETH from the contract
    // function withdrawEther() public payable onlyOwner() {
    //     if (ethToWithdraw > 0) {
    //         address payable owner = payable(owner());
    //         sendCrypto(owner, ethToWithdraw);
    //         ethToWithdraw = 0;
    //     }
    // }
    
    // // Check the balance in the contract
    // function checkBalance() public view onlyOwner() returns(uint) {
    //     return address(this).balance;
    // }
    // // Check how much ETH can be withdrawn by the owner
    // function checkEthToWithdraw() public view onlyOwner() returns(uint256) {
    //     return ethToWithdraw;
    // }

    // // Show Transaction percentage fee
    // function displayTransactionFee() public view returns(uint8) {
    //     return transactionFeePercentage;
    // }
}