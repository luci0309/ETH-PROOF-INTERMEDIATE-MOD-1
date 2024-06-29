// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract SchoolAdmission {
    address internal schoolAdmin;
    uint internal totalStudents;
    uint public maxStudents;

    struct Student {
        uint id;
        string name;
        uint score;
    }

    mapping (uint => Student) public students;

    constructor(uint _maxStudents) {
        schoolAdmin = msg.sender;
        maxStudents = _maxStudents;

        // Ensure the contract owner (schoolAdmin) is not the zero address
        assert(schoolAdmin != address(0));
    }

    // Function to take admission
    function admitStudent(string memory _name, uint _score) public {
        // Ensure only the schoolAdmin can take admission of students
        require(msg.sender == schoolAdmin, "Only the school admin can admit students");

        if (_score < 60) {
            // Ensure student meets the score requirement
            revert("Student's score must be above 60 to be eligible for admission.");
        }

        // Ensure that the maximum number of students is not exceeded
        require(totalStudents < maxStudents, "Can't take more admissions.");

        totalStudents++;
        students[totalStudents] = Student(totalStudents, _name, _score);
    }

    // Function to update the maximum number of students for admission
    function updateMaxStudents(uint _newMaxStudents) public {
        if (_newMaxStudents < totalStudents) {
            // Ensure that the new maximum is greater than the current number of students
            revert("Maximum number of students must be greater than the total number of students.");
        }
        maxStudents = _newMaxStudents;
    }
}
