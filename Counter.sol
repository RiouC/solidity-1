// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Counter {
  mapping(address => bool) _owners;
  uint256 private _counter;
  uint256 private _step;
  uint256 private constant _MAX_BOUND_UINT256 = 2**256 - 1;

  constructor(uint256 step_, address firstOwner_) {
    _owners[firstOwner_] = true;
    _step = step_;
  }

  function addOwner(address account) public {
      require(_owners[msg.sender] == true, "Counter: Only an owner can add owner");
      _owners[account] = true;
  }

  function increment() public {
      require(_owners[msg.sender] == true, "Counter: Only owners can increment counter");
      // require(_counter + _step <= _MAX_BOUND_UINT256, "Counter: counter can't be superior to 2^256-1, reduce your step or decrement first");
      unchecked {
          _counter += _step;
        if (_counter > _MAX_BOUND_UINT256) {
            _counter %= (_MAX_BOUND_UINT256 + 1);
        }
      }
  }

  function decrement() public {
      require(_owners[msg.sender] == true, "Counter: Only owners can decrement counter");
      // require(_step <= _counter, "Counter: counter can't be negative, reduce your step or increment first");
      unchecked {
          _counter -= _step;
          if (_counter < 0 ) {
              _counter += _MAX_BOUND_UINT256 + 1;
          }
      }
  }

  function reset() public {
      require(_owners[msg.sender] == true, "Counter: Only owners can reset counter");
      _counter = 0;
  }

  function isOwner(address account) public view returns (bool) {
      return _owners[account];
  }

  function counter() public view returns (uint256) {
      return _counter;
  }

  function step() public view returns (uint256) {
      return _step;
  }

  function setStep(uint256 step_) public {
      require(_owners[msg.sender] == true, "Counter: Only owners can set step");
      _step = step_;
  }
}
