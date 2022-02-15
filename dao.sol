pragma solidity 0.7.5;

contract DAO {

    constructor(address _owner1, address _owner2, address _owner3, uint256 _requiredApprovals) {
        owners[0] = _owner1;
        owners[1] = _owner2;
        owners[2] = _owner3;
        requiredApprovals = _requiredApprovals;
    }

    uint256 requiredApprovals;
    address[3] owners;
    uint vote = 0;
    address[] voted;

    uint proposedTransferAmount;
    address payable proposedTransferAddress; 
    address proposer;

    function deposit() public payable {
    }

    function getContractBalance() public view returns(uint) {
        return address(this).balance;
    }

    function proposedTransfer(address payable _to, uint _amount) public {
        proposedTransferAmount = _amount;
        proposedTransferAddress = _to;
        proposer = msg.sender;
    }

    function seeProposedTransfer() public view returns(address, uint) {
        return(proposedTransferAddress, proposedTransferAmount);
    }

    function transfered(address payable _to, uint _amount) public {
        return _to.transfer(_amount);
    }

    function approved() public {
        for(uint i = 0; i < owners.length; i++) {
            if(msg.sender == owners[i] || proposer == owners[i]) {
                address votes = msg.sender;
                voted.push(votes);
                for(uint j = 0; j < voted.length; j++) {
                    if(msg.sender != voted[i]) {
                        vote += 1;
                    }
                
                }
            } 
        }

        if(vote >= requiredApprovals) {
            transfered(proposedTransferAddress, proposedTransferAmount);
        }
    }
}