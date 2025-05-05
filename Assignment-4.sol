// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract MarksManagementSys {
    struct Student {
        int ID;
        string fName;
        string lName;
        int marks;
    }

    address public owner;
    uint256 public stdCount = 0;

    mapping(uint256 => Student) public stdRecords;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can call this function");
        _;
    }

    function addNewRecord(int _ID, string memory _fName, string memory _lName, int _marks)
        public
        onlyOwner
    {
        stdCount++;

        Student storage newStudent = stdRecords[stdCount];
        newStudent.ID = _ID;
        newStudent.fName = _fName; 
        newStudent.lName = _lName;
        newStudent.marks = _marks;
    }

    function bonusMarks(int _bonus, uint256 studentIndex)
        public
        onlyOwner
    {
        require(studentIndex <= stdCount && studentIndex > 0, "Invalid student index"); 
        Student storage existingStudent = stdRecords[studentIndex];

        if (existingStudent.marks + _bonus < -100000) {
            revert("Marks overflow!");
        }

        existingStudent.marks += _bonus;
    }
}
