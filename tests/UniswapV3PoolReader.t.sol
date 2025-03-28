// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/src/Test.sol";
import "../src/UniswapV3PoolReader.sol";

// Mock Uniswap V3 Pool for testing
contract MockUniswapV3Pool {
    address public token0Address;
    address public token1Address;
    uint24 public feeTier;

    constructor(address _token0, address _token1, uint24 _fee) {
        token0Address = _token0;
        token1Address = _token1;
        feeTier = _fee;
    }

    function token0() external view returns (address) {
        return token0Address;
    }

    function token1() external view returns (address) {
        return token1Address;
    }

    function fee() external view returns (uint24) {
        return feeTier;
    }
}

contract UniswapV3PoolReaderTest is Test {
    UniswapV3PoolReader reader;
    MockUniswapV3Pool mockPool;

    address constant TOKEN0 = address(0x123);
    address constant TOKEN1 = address(0x456);
    uint24 constant FEE = 3000; // 0.3%

    function setUp() public {
        // Deploy mock pool
        mockPool = new MockUniswapV3Pool(TOKEN0, TOKEN1, FEE);
        // Deploy reader with mock pool address
        reader = new UniswapV3PoolReader(address(mockPool));
    }

    function testGetPoolInfo() public {
        (address t0, address t1, uint24 f) = reader.getPoolInfo();
        assertEq(t0, TOKEN0, "Token0 mismatch");
        assertEq(t1, TOKEN1, "Token1 mismatch");
        assertEq(f, FEE, "Fee mismatch");
    }

    function testGetFeeTier() public {
        uint24 f = reader.getFeeTier();
        assertEq(f, FEE, "Fee mismatch");
    }
}
