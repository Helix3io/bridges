// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract HLXToken is ERC20 {
    constructor() ERC20("HLXToken", "HLX"){
        _mint(msg.sender,1000*10**18);
    }
}