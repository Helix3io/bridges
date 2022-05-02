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

    // we emit this event when native tokens are locked in the source chain
    event Sent(
        uint256 amount,
        address receiver
    );     
    constructor(
        address _lockin_token_address
    ) {
        helix_settings = HelixBridgeInfo(address(0));
        helix_settings.tokenAddress = _lockin_token_address;
        helix_token_address_for_lockin_eth = _lockin_token_address;
    }

    function approve(
        uint256 _amount
    ) public payable {
        IERC20(helix_settings.tokenAddress).approve(msg.sender, _amount);
    }

    function send(
        uint256 _amount,
        address _receiver
    ) public payable {
        IERC20(helix_settings.tokenAddress).safeTransferFrom(
            msg.sender,
            address(this),
            _amount
        );

        emit Sent(_amount, _receiver);
    }

    function getTokenAddress(
    ) public view returns(address) {
        return helix_token_address_for_lockin_eth;
    }

    function getTokenBalance() public view returns(uint256) {
        return IERC20(helix_settings.tokenAddress).balanceOf(msg.sender);
    }

    function getContractBalance() public view returns(uint256) {
        return IERC20(helix_settings.tokenAddress).balanceOf(address(this));
    }
}