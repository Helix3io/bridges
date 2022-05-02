// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract TransferEntry {
    using SafeERC20 for IERC20;

    struct HelixBridgeInfo {
        address tokenAddress;
    }

    // for different assets we will have different id
    HelixBridgeInfo public helix_settings;
    address public helix_token_address_for_lockin_eth;  

    constructor(
        address _lockin_token_address
    ) {
        helix_settings = HelixBridgeInfo(address(0));
        helix_settings.tokenAddress = _lockin_token_address;
    }

    function send(
        uint256 _amount
    ) public {
        IERC20(helix_settings.tokenAddress).safeTransferFrom(
            msg.sender,
            address(this),
            _amount
        );
    }
}