// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BaseContract{
    uint internal _sharedData = 100;

    function _increaseSharedData(uint _amount) internal{
        _sharedData+=_amount;
    }
    
    function getSharedData()public view returns(uint){
        return _sharedData;
    }
}

contract AllSolidityFeautures is BaseContract{
    uint public publicCounter=0;
    uint private _privateCounter=0;
    address public contractOwner;//new state variable to store deployer

    //constructor: A special function that only runs once when the contract is deplyed
    //its often used to initialize state variables
    constructor(){
        contractOwner = msg.sender;//the address of he who deployed the contract
    }

    function incrementPublicCounter(uint _amount) public{
        publicCounter += _amount;
        _incrementPrivateCounter(_amount);
        _increaseSharedData(_amount);//calls internal form basecontract
    }
    function _incrementPrivateCounter(uint _amount) private{
        _privateCounter += _amount;
    }
    function getPrivateCounter() public view returns(uint){
        return _privateCounter;
    }

    function _logActivity(string memory _message)internal pure{
        //where we shall emit an event in later contracts just showing internal logic for now
    }
    function doSomethingAndLog(string memory _action)public pure{
        //calls the internal pure function
        _logActivity(_action);
        ///...rest of the logic...
    }

    function externalOnlyFunc(uint _value) external{
        publicCounter += _value;
        _logActivity("External function called");
    }
    

    function getInheritedSharedData()public view returns(uint){
        return _sharedData;
    }



    //viewfunction
    function getOwner() public view returns(address){
        return contractOwner;
    }
    
    //purefucntion
    function multiply(uint _a, uint _b) public pure returns (uint){
        return _a*_b;
    }

    //payablefunction
    function receiveFunds()public payable{
        //allows anyone to send ethher to this contract
        //msg.value is the amount of ether send in wei
        //we could lof if or update a balacne mapping here, e.g.:
        //balances[msg,sender]+=msg.value;
    }
    
    //function to check the contracts current ether balance(uselful after receiving funds)
    function getContractBalance()public view  returns(uint){
        return address(this).balance; //"address(this)"...the contracts own address

    }
    
    //example of a function that is not payable but modifies state(costs gas)
    function resetCounter() public{
        publicCounter = 0; //modifies state
    }
}
