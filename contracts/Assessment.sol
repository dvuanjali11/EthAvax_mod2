// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.16;

//import "hardhat/console.sol";

contract Assessment {

    uint256 public balance;
    event Deposit(uint256 amount);
    event Withdraw(uint256 amount);
    event multiply(uint256 _first, uint256 _second);
    uint256 public result;


    constructor(uint initBalance) payable {
        owner = payable(msg.sender);
        balance = initBalance;
    }

    function getBalance() public view returns(uint256){
        return balance;
    }

    function deposit(uint256 _amount) public payable {
        uint _previousBalance = balance;

        // make sure this is the owner
        require(msg.sender == owner, "You are not the owner of this account");

        // perform transaction
        balance += _amount;

        // assert transaction completed successfully
        assert(balance == _previousBalance + _amount);

        // emit the event
        emit Deposit(_amount);
    }

    // custom error
    error InsufficientBalance(uint256 balance, uint256 withdrawAmount);

    function withdraw(uint256 _withdrawAmount) public {
        require(msg.sender == owner, "You are not the owner of this account");
        uint _previousBalance = balance;
        if (balance < _withdrawAmount) {
            revert InsufficientBalance({
                balance: balance,
                withdrawAmount: _withdrawAmount
            });
        }

        // withdraw the given amount
        balance -= _withdrawAmount;

        // assert the balance is correct
        assert(balance == (_previousBalance - _withdrawAmount));

        // emit the event
        emit Withdraw(_withdrawAmount);
    }

    function getResult() public view returns (uint256)
    {
        return result;
    }

    function multiplication (uint256 _first, uint256 _second) public{
        result= _first * _second;
        emit multiply (_first, _second);
    }
}
