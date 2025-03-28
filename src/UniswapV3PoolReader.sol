// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Uniswap V3 Pool interface with only the methods we need
interface IUniswapV3Pool {
    function token0() external view returns (address);
    function token1() external view returns (address);
    function fee() external view returns (uint24);
}

// Contract to interact with Uniswap V3 pool
contract UniswapV3PoolReader {
    // Store the pool address
    address public poolAddress;

    // Event to log pool information
    event PoolInfo(address token0, address token1, uint24 fee);

    // Constructor to set the pool address
    constructor(address _poolAddress) {
        require(_poolAddress != address(0), "Invalid pool address");
        poolAddress = _poolAddress;
    }

    // Function to get pool details
    function getPoolInfo() external view returns (address token0, address token1, uint24 feeTier) {
        // Create instance of the pool
        IUniswapV3Pool pool = IUniswapV3Pool(poolAddress);

        // Get pool information
        token0 = pool.token0();
        token1 = pool.token1();
        feeTier = pool.fee();

        return (token0, token1, feeTier);
    }

    // Function to just get the fee tier
    function getFeeTier() external view returns (uint24) {
        IUniswapV3Pool pool = IUniswapV3Pool(poolAddress);
        return pool.fee();
    }

    // Function to update pool address (optional)
    function updatePoolAddress(address _newPoolAddress) external {
        require(_newPoolAddress != address(0), "Invalid pool address");
        poolAddress = _newPoolAddress;
    }
}
