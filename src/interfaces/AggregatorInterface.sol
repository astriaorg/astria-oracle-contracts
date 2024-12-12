// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// https://github.com/smartcontractkit/chainlink/blob/dde17518ff7f3dd3fe1d53614f211357944516f0/contracts/src/v0.8/shared/interfaces/AggregatorInterface.sol
// solhint-disable-next-line interface-starts-with-i
interface AggregatorInterface {
  function latestAnswer() external view returns (int256);

  function latestTimestamp() external view returns (uint256);

  function latestRound() external view returns (uint256);

  function getAnswer(uint256 roundId) external view returns (int256);

  function getTimestamp(uint256 roundId) external view returns (uint256);

  event AnswerUpdated(int256 indexed current, uint256 indexed roundId, uint256 updatedAt);

  event NewRound(uint256 indexed roundId, address indexed startedBy, uint256 startedAt);
}