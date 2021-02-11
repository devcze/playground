pragma solidity =0.8.1;

// Trust constract example for 1 child
contract Trust {
    address public kid;
    uint public maturity;
    
    //seconds since 1st of jan 1970
    // see epoch and unix timestamp conversion tool
    
    // function called when smart contract is deployed
    // payable - we can send some ether to smart contract
    constructor(address _kid, uint timeToMaturity) payable {
        // block.timestamp - timestamp of the block
        maturity = block.timestamp + timeToMaturity;
        kid = _kid;
    }
    
    // external - function can be called from outside of the smart contract
    function withdraw() external {
        
        // check the condition, if OK go on, otherwise stop the execution
        require(block.timestamp >= maturity, 'too early');
        require(msg.sender == kid, 'only kid can withdraw');
        
        // convert address to payable address
        // in solidity there is address type
        // and address payable type
        // address(this).balance  = balance of smart this contract 
        payable(msg.sender).transfer((address(this)).balance);
        
    }
    
}




// Trust constract example for multiple children
contract Trust2 {
    
    // similar to JS object (key->value)
    // amounts stores amount for each kid
    mapping(address => uint) public amounts;
    // maturities stores maturities dates for each kid
    mapping(address => uint) public maturities;
    mapping(address => bool) public paid; 
    address public admin;
    
    constructor() {
        admin = msg.sender;
    }
    
    
    function addKid(address kid, uint timeToMaturity) external payable {
        require(msg.sender == admin, 'only admin');
        require(amounts[msg.sender] == 0, 'kid already exists');
        
        amounts[kid] = msg.value;
        maturities[kid] = block.timestamp + timeToMaturity;
    }
    
    
    // external - function can be called from outside of the smart contract
    function withdraw() external {
        
        // check the condition, if OK go on, otherwise stop the execution
        require(maturities[msg.sender] <= block.timestamp, 'too early');
        // in Solidity it's possible even if key doesn't exist, returns default = 0
        require(amounts[msg.sender] > 0, 'only kid can withdraw');
        require(paid[msg.sender] == false, 'paid already');
        
        
        payable(msg.sender).transfer(amounts[msg.sender]);
        
    }
    
}




// Trust constract example for multiple children (improved with struct)
contract Trust3{
    
    struct Kid {
        uint amount;
        uint maturity;
        bool paid;
    }
    
    mapping(address => Kid) public kids;
    
    address public admin;
    
    constructor() {
        admin = msg.sender;
    }
    
    
    function addKid(address kid, uint timeToMaturity) external payable {
        require(msg.sender == admin, 'only admin');
        require(kids[kid].amount == 0, 'kid already exists');
        
        kids[kid] = Kid(msg.value, block.timestamp + timeToMaturity, false);
        
        // msg.value = send eth
        // msg.sender = txn initiator
     
    }
    
    
    // external - function can be called from outside of the smart contract
    function withdraw() external {
        
        Kid storage kid = kids[msg.sender];
        
        // check the condition, if OK go on, otherwise stop the execution
        require(kid.maturity <= block.timestamp, 'too early');
        // in Solidity it's possible even if key doesn't exist, returns default = 0
        require(kid.amount  > 0, 'only kid can withdraw');
        require(kid.paid == false, 'paid already');
        
        payable(msg.sender).transfer(kid.amount);
    }
    
}


// local development blockchain

