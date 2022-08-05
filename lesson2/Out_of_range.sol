// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// @author Andrey Shalygin
// @title  Going out of range example
contract Demo {
    uint8 public rsl = 1;

    function dec() public {
        unchecked {
            rsl--; 
        }     
    }
}

