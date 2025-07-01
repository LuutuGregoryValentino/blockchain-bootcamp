//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

contract BaseContract{
    //BaseContract:Demonstrates internal visibilty for inheritance
    uint internal _sharedData = 100; //internal state variable


    function _increaseSharedData(uint _amount) internal {
        //accesible within BaseContract and contracts inheriting from it
        _sharedData +=_amount;
    }

    function getSharedData() public view returns(uint){
        //public getter for _sharedData
        return _sharedData;
    }
}

contract FunctionVisibilityExamples is BaseContract{
    //public state function auto get a public getter func.
    uint public publicCounter=0;

    //only available within this contract
    uint private _privateCounter=0;

    //public---can be called by everyone
    function incrementPublicCounter(uint _amount) public{
        publicCounter +=_amount;
        _incrementPrivateCounter(_amount);
        _increaseSharedData(_amount);
    }

    //private--- only within this contract
    function _incrementPrivateCounter(uint _amount) private{
        _privateCounter+=_amount;
    }

    //public getter for the private counter
    function getPrivateCounter() public view returns (uint){
        return _privateCounter;
    }

    //internal---within this contact and all that inherit from it
    function _logActivity(string memory _message) internal pure{
        //in a real ocntract we can emit an event or update an internal log
    }
    function doSomethingAndLog(string memory _action) public pure {
        //call the internla func.
        _logActivity(_action);
        //rest of the logic
    }

    //external functions-- anyone else not connected to this contract unless this.funcname() is used
    function externalOnlyFunc(uint _value) external {
                //designed to be an entry point for external calls
        publicCounter +=_value;
        //usually private and internal func arent called from an external func unless it spart of the external inetractions ineternal logic
        _logActivity("External fucntion called");
    }
    function getInheritedSharedData() public view returns (uint){
        return _sharedData; //accessible because sharedData is internal in baseContract
    }

}
