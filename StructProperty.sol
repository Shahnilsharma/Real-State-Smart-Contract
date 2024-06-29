// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//structure for attributes to be assigned to each Property
struct Property{
    uint256 price;
    bool Onsale;
    bool isResidential;
    string name;
    address owner;
    string description;
    string location;

}