//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

contract DataTypes{
    bool public isOpen = true;
    bool private _isAdmin = false;

    function toggleOpen() public{
        isOpen = !isOpen;
    }
    function checkadmin(bool _status) public pure returns(string memory){
        if (_status){
            return "User is Admin";
        }
        else{
            return "User is not Admin";
        }
    }


    uint public totalSupply = 1_000_000;
    uint8 public smallNumber = 255;

    int public balanceChange = -500;

    function add(uint _a,uint _b)public pure returns(uint){
        return _a+_b;   
        }   

    address public contractCreator;
    address public currentWinner;


    address payable public charityWallet;//we can send ether to the address we store here

    constructor(){
        contractCreator = msg.sender;//this is always address payable
        charityWallet = payable(0x7873D7a7f96831dC48d081d0A3528ba3F3248a99);
    }

    function sendToCharity(uint _amount) public{
        charityWallet.transfer(_amount);//sends Ether
    }




    bytes32 public myFixedBytes = "hello";
    string public myString = "Hello, World!";

    function  setMyString(string memory _newMessage)public{
        myString = _newMessage;//assigns the new string
    }

    function combineBytes(bytes memory _a,bytes memory _b)public pure returns(bytes memory){
        return abi.encodePacked(_a,_b);//concatenates bytes
    }







    enum Status {Pending, Approved, Rejected}

    Status public currentStatus = Status.Pending;//initial status

    function setStatus(Status _newStatus)public{
        currentStatus = _newStatus;
    }

    function isApproved()public view returns(bool){
        return currentStatus == Status.Approved;
    }
}


contract AddressClarification {
    address public deployerAddress;
    address payable public fundReceiver;

    constructor(){
        deployerAddress = msg.sender;
        fundReceiver = payable(0x7873D7a7f96831dC48d081d0A3528ba3F3248a99); // must explicitly make payable when defined like this
    }

    //this can receive Ether
    function depositFunds() public payable{
        //just demonstrating func that can recieve ether
    }

    //only deployer can call this function
    function sendFundsToReceiver(uint _amount)public{
        require(msg.sender == deployerAddress,"Only Deployer can send funds");
        require(address(this).balance >= _amount,'insufficient contract balance');

        //THIS IS THE KEY PART
        //you must use "fundReceiver.transfer(_amount)"because fundReceiver is 'address payable'
    
        fundReceiver.transfer(_amount); //sends _amount ether form this contract to fundReciever
    }

    //you cant do this is mynonpayabkeaddress is just 'address'
    //function cannotsendtoregularaddress(address mynonpayableaddress, uint _amount)public{
    //    mynonpayableaddress.transfer(_amount);//error type isnt address payable
    
   // }

    //how to send to msg.senderr if you need to (is msg.sender is an EOA);
    function returnFundsToCaller(uint _amount) public payable{
        //here msg.sender is th one who called this payable function
        //convert msg.ssender to address payable to send ether back
        payable(msg.sender).transfer(_amount);   


        }
} 


contract OrderTracker{
    //1. declare enum outside a function
    enum OrderStatus {
        Pending,
        Processing,
        Shipped,
        Delivered,
        Cancelled
    }

    //2. declare a state variable of typr OrderStatus

    //initializze it to the first enum memeber by defoault or explicitly
    OrderStatus public currentOrderStatus;
    uint public orderIdCounter =0 ;
    //mapping to store the sttaus of each order by its id
    mapping(uint =>OrderStatus) public OrderStatuses;
    //constructor to set initial state
    constructor(){
        currentOrderStatus = OrderStatus.Pending;
    }

    //3.function to reate a new order and set its status
    function createNewOrder() public returns (uint){
        orderIdCounter++;
        OrderStatuses[orderIdCounter]=OrderStatus.Pending;
        return orderIdCounter;

    }

    //4. function to update the status of an order
    function updateOrderStatus(uint _orderId,OrderStatus _newStatus) public{
        require (OrderStatuses[_orderId]!= OrderStatus.Delivered,"Order already Delivered");
        require (OrderStatuses[_orderId] !=OrderStatus.Cancelled,"Order was cancelled");

        OrderStatuses[_orderId]=_newStatus;
        //you could also update the currentorderstatus if this contract tracks one order
        //currentOrderStatus=_newStatus;
    }

    //5.function to check if an order is delivered
    function isOrderDelivered(uint _orderId)public view returns(bool){
        return OrderStatuses[_orderId] == OrderStatus.Delivered;
    }

    
}

contract BytesAndStrings{
    string public userName = "Alice";//for persons name
    bytes32 public documentHash;// for cyptographic hash (exactly 32bytes)
    bytes public arbitraryData;//for variable-length raw data

    function setdocumenthash(bytes32 _hash) public{
        documentHash = _hash;
    }

    function setArbitraryData(bytes memory _data) public{
        arbitraryData = _data;
    }

    function sendMessage(string memory _message) public{
        userName = _message; //updating a string state variable
    }

    //you can convert a string to bytes but it incursgass for encoding
    function stringToBytes (string memory _text) public pure returns(bytes memory){
        return abi.encodePacked(_text); //converts the text string's UTF-8 representation to raw bytes 
    }

//you however cantn easily cinvery raw bytes back to a meaningful string in solidity
//unless you know the encoding and handle it manually, which is rare

}
    
