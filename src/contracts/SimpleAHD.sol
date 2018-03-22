pragma solidity ^0.4.18;

contract SimpleAHD {

	struct Patient {
		uint id;
		bytes32 name;
		mapping(bytes32 => bool) responses;
		mapping(bytes32 => bool) circle;
		mapping(bytes32 => uint) accessTimes;
	}

	mapping(address => Patient) private patients;
	address[] private patientIndex;	

	event PatientRegistered(address patientAddress, uint patientID);
	event AddedToCircle(address patientAddress, bytes32 substitute);
	event RemovedFromCircle(address patientAddress, bytes32 substitute);
	event UpdatedResponse(address patientAddress, bytes32 question, bool answer);
	event GrantedDataAccess(address patientAddress, bytes32 name, uint duration);
	event ModifiedDataAccess(address patientAddress, bytes32 name, uint duration);
	event RevokedDataAccess(address patientAddress, bytes32 name);


	/*function SimpleAHD() public {

	}*/

	function register(bytes32 _name, bytes32[] _responses, bytes32[] _circle, bytes32[] _acessTimes) public returns(bool) {
		require(!isRegistered(msg.sender));
	    patients[msg.sender].name = _name;
	    // patients[msg.sender].responses = _responses;
	    // patients[msg.sender].circle = _circle;
	    // patients[msg.sender].accessTimes = _acessTimes;
	    initializeMapping(_responses, 'responses');
	    initializeMapping(_circle, 'circle');
	    initializeMapping(_accessTimes, 'accessTimes');
	    patients[msg.sender].id = patientIndex.push(msg.sender)-1;
	    PatientRegistered(msg.sender, patients[msg.sender].id);
	    return true;
	}

	function isRegistered(address _patientAddress) public returns(bool) {
		require(patientIndex.length > 0);
    	return (patientIndex[patients[_patientAddress].id] == _patientAddress);
	}

	function addToCircle(bytes32 _name) public {
		require(patients[msg.sender].circle[_name] == true);
		patients[msg.sender].circle[_name] = true;
		AddedToCircle(msg.sender, _name);
	}

	function removeFromCircle(bytes32 _name) public {
		require(patients[msg.sender].circle[_name] == false);
		patients[msg.sender].circle[_name] = false;
		RemovedFromCircle(msg.sender, _name);
	}

	function updateResponse(bytes32 _question, bool _answer) public {
		patients[msg.sender].responses[_question] = _answer;
		UpdatedResponse(msg.sender, _question, _answer);
	}

	function grantDataAccess(bytes32 _name, uint _duration) public {
		patients[msg.sender].accessTimes[_name] = _duration;
		GrantedDataAccess(msg.sender, _name, _duration);
	}

	function modifyDataAccess(bytes32 _name, uint _duration) public {
		patients[msg.sender].accessTimes[_name] = _duration;
		ModifiedDataAccess(msg.sender, _name, _duration);
	}

	function revokeDataAccess(bytes32 _name) public {
		require(patients[msg.sender].accessTimes[_name] > 0);
		patients[msg.sender].accessTimes[_name] = 0;
		RevokedDataAccess(msg.sender, _name);
	}

	function initializeMapping(bytes32[] dataArray, string theMapping) private {
		if(theMapping == 'responses') {		
			for(uint i=0; i<dataArray.length; i++) {
				patients[msg.sender].responses[dataArray[i]] = true;
			}
		}
		else if(theMapping == 'circle') {		
			for(uint i=0; i<dataArray.length; i++) {
				patients[msg.sender].circle[dataArray[i]] = true;
			}
		}
		else {		
			for(uint i=0; i<dataArray.length; i++) {
				patients[msg.sender].accessTimes[dataArray[i]] = true;
			}
		}
	}

}


contract UserCrud {

  struct UserStruct {
    bytes32 userEmail;
    uint userAge;
    uint index;
  }
  
  mapping(address => UserStruct) private userStructs;
  address[] private userIndex;

  event LogNewUser   (address indexed userAddress, uint index, bytes32 userEmail, uint userAge);
  event LogUpdateUser(address indexed userAddress, uint index, bytes32 userEmail, uint userAge);
  event LogDeleteUser(address indexed userAddress, uint index);
  
  function isUser(address userAddress)
    public 
    constant
    returns(bool isIndeed) 
  {
    if(userIndex.length == 0) return false;
    return (userIndex[userStructs[userAddress].index] == userAddress);
  }

  function insertUser(
    address userAddress, 
    bytes32 userEmail, 
    uint    userAge) 
    public
    returns(uint index)
  {
    if(isUser(userAddress)) throw; 
    userStructs[userAddress].userEmail = userEmail;
    userStructs[userAddress].userAge   = userAge;
    userStructs[userAddress].index     = userIndex.push(userAddress)-1;
    LogNewUser(
        userAddress, 
        userStructs[userAddress].index, 
        userEmail, 
        userAge);
    return userIndex.length-1;
  }

  function deleteUser(address userAddress) 
    public
    returns(uint index)
  {
    if(!isUser(userAddress)) throw; 
    uint rowToDelete = userStructs[userAddress].index;
    address keyToMove = userIndex[userIndex.length-1];
    userIndex[rowToDelete] = keyToMove;
    userStructs[keyToMove].index = rowToDelete; 
    userIndex.length--;
    LogDeleteUser(
        userAddress, 
        rowToDelete);
    LogUpdateUser(
        keyToMove, 
        rowToDelete, 
        userStructs[keyToMove].userEmail, 
        userStructs[keyToMove].userAge);
    return rowToDelete;
  }
  
  function getUser(address userAddress)
    public 
    constant
    returns(bytes32 userEmail, uint userAge, uint index)
  {
    if(!isUser(userAddress)) throw; 
    return(
      userStructs[userAddress].userEmail, 
      userStructs[userAddress].userAge, 
      userStructs[userAddress].index);
  } 
  
  function updateUserEmail(address userAddress, bytes32 userEmail) 
    public
    returns(bool success) 
  {
    if(!isUser(userAddress)) throw; 
    userStructs[userAddress].userEmail = userEmail;
    LogUpdateUser(
      userAddress, 
      userStructs[userAddress].index,
      userEmail, 
      userStructs[userAddress].userAge);
    return true;
  }
  
  function updateUserAge(address userAddress, uint userAge) 
    public
    returns(bool success) 
  {
    if(!isUser(userAddress)) throw; 
    userStructs[userAddress].userAge = userAge;
    LogUpdateUser(
      userAddress, 
      userStructs[userAddress].index,
      userStructs[userAddress].userEmail, 
      userAge);
    return true;
  }

  function getUserCount() 
    public
    constant
    returns(uint count)
  {
    return userIndex.length;
  }

  function getUserAtIndex(uint index)
    public
    constant
    returns(address userAddress)
  {
    return userIndex[index];
  }

}