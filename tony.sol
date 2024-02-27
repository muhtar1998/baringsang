// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC20, Ownable {
    using EnumerableSet for EnumerableSet.AddressSet;

    EnumerableSet.AddressSet private _allowedRecipients;

    constructor() ERC20("Tony", "Tony") Ownable(msg.sender) {
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }

    function addAllowedRecipient(address recipient) external onlyOwner {
        _allowedRecipients.add(recipient);
    }

    function removeAllowedRecipient(address recipient) external onlyOwner {
        _allowedRecipients.remove(recipient);
    }

    function multiTransfer(address[10] memory recipients, uint256[10] memory amounts) external {
        require(recipients.length == amounts.length, "Arrays length mismatch");


        for (uint256 i = 0; i < recipients.length; i++) {
            require(_allowedRecipients.contains(recipients[i]), "Recipient not allowed");
            _transfer(msg.sender, recipients[i], amounts[i]);
        }
    }
}