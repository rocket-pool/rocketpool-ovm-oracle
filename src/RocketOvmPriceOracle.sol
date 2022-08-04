// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.13;

import "@eth-optimism/contracts/libraries/bridge/ICrossDomainMessenger.sol";

interface IRateProvider {
    /**
     * @dev Returns an 18 decimal fixed point number that is the exchange rate of the token to some other underlying
     * token. The meaning of this rate depends on the context.
     */
    function getRate() external view returns (uint256);
}

/// @author Kane Wallmann (Rocket Pool)
/// @notice Receives updates from L1 on the canonical rETH exchange rate
contract RocketOvmPriceOracle is IRateProvider {
    // Events
    event RateUpdated(uint256 rate);

    // Immutables
    ICrossDomainMessenger immutable ovmL2CrossDomainMessenger;

    uint256 rate;
    uint256 lastUpdated;
    address owner;

    constructor(address _l2CrossDomainMessenger) {
        ovmL2CrossDomainMessenger = ICrossDomainMessenger(_l2CrossDomainMessenger);
        owner = msg.sender;
    }

    /// @notice Set to the contract on L1 that has permission to update the rate
    function getOwner() external view returns (address) {
        return owner;
    }

    /// @notice Hands ownership to the L1 price messenger contract
    function setOwner(address _newOwner) external {
        require(msg.sender == owner, "Only owner");
        owner = _newOwner;
    }

    /// @notice The timestamp of the block in which the rate was last updated
    function getLastUpdated() external view returns (uint256) {
        return lastUpdated;
    }

    /// @notice The rETH exchange rate in the form of how much ETH 1 rETH is worth
    function getRate() external view returns (uint256) {
        return rate;
    }

    /// @notice Called by the messenger contract on L1 to update the exchange rate
    function updateRate(uint256 _newRate) external {
        // Only calls originating from L1 owner can update the rate
        require(
            msg.sender == address(ovmL2CrossDomainMessenger)
            && ovmL2CrossDomainMessenger.xDomainMessageSender() == owner,
            "Only owner"
        );
        // Set rate and last updated timestamp
        rate = _newRate;
        lastUpdated = block.timestamp;
        // Emit event
        emit RateUpdated(_newRate);
    }
}
