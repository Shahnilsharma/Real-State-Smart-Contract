// SPDX-License-Identifier: MIT
//@author: shahnil
pragma solidity ^0.8.0; 

import "./structProperty.sol";

contract RealEstate{

 
 //will map each attribute on with uint id
 mapping (uint256 =>Property)public  Properties ;

 //assigning a unique to a property along with its type
uint256[] private residentialPropertyIDs;
uint256[] private commercialPropertyIDs;

//to keep the log of if property is sold or not
event PropertySold(uint256 propertyId);

//function for listing a property 
function listPropertyForSale(
    uint256 _propertyId,  
    uint256 _price,
    string memory _name,
    string memory _description,
    string memory _location,
    bool _isResidential
) public {
    Property memory newProperty = Property({
        price: _price, 
        Onsale: true,
        isResidential: _isResidential,
        name: _name, 
        owner: msg.sender, 
        description: _description,
         location: _location         
         });

// now we will mark the property id as input for mapp and 
//it will mark this id to each attribute in newProperty element 
//so we can just grab any attribute by just using id
Properties[_propertyId] = newProperty;

//check if the id already exist or not 
require(findIndex(residentialPropertyIDs, _propertyId) == type(uint256).max, "ID already exists");
 require(findIndex(commercialPropertyIDs, _propertyId) == type(uint256).max, "ID already exists");

//pushing the property id in the array 
if(_isResidential==true){
residentialPropertyIDs.push(_propertyId);
}
else{
     commercialPropertyIDs.push(_propertyId);
}
}


//function to buy the property
 //its payable because we want to recieve ethers for the price of the property
function buyProperty(uint256 _propertyId)public payable {

    //will create an instance to acces property via mapping
    Property storage property=Properties[_propertyId];

    //need to verify the property availabilty and price
    require(property.Onsale,"this property is not available");
    require(property.price>=msg.value,"Insufficiant funds");
     
   //will transfer the funds to the owner 
     payable(property.owner).transfer(property.price);

    //make the msg.sender the owner now
    property.owner=msg.sender;

    //the property is unavailable now
    property.Onsale=false;

     //now to report the log
     emit PropertySold(_propertyId);
}


//function get a list of property ids
 function getPropertylistIDs()public view returns(
    uint256[] memory _residential, 
    uint256[] memory _commercial
    ){
       _residential=residentialPropertyIDs;
       _commercial=commercialPropertyIDs;
 }


// Helper function to find the index of an element in an array
function findIndex(uint256[] memory arr, uint256 value) private pure returns (uint256) {
    for (uint256 i = 0; i < arr.length; i++) {   //traversing
        if (arr[i] == value) {
            return i;
        }
    }
    return type(uint256).max;
}

}

//Documentation:

// overview 
// this smart contracts allows to run a  real state businesss on a blockchain network 
// when deployed anyone can interact with it they can either view deatails of 
// a specific property sell and buy one.

// contract detail
// structs
// Property
// this struct describes some basic elements of any property which are:
// price: the value in wei (price of the property)(uint)
// Onsale: it will ensure that if the property is available or not(bool)
// name: name of the property (i.e mega mall, niaz stadium) (string)
// owner: the address of the account who ever owns the property(address)
// description: describe about the property size,story color (string)
// location: where the property is located (string)

// Mappings
// Properties(mapping of uint Id to struct property)
// this mapping stores the property information for each id . the key is property ID  

// Events
// PropertySold(uint256 propertyId);
// it will take the id and validate that the property has bee sold
// to log it iin the contract

// Arrays 
// residentialPropertyIDs(stores ids of property which are residential)
// comercialPropertyIDs(stores ids of property which are comercial)
// so you directly access the type of property with available id


// Functions
// listPropertyForSale(
// uint256 _propertyId,  
// uint256 _price,
// string memory _name,
// string memory _description,
// string memory _location
// )
// this function allows user to add their property in the list.
// it takes property id number,price,name,description and location as argumnets.
// then intializs them with property instance for each value in struct 
// then mapping the id to push into the arrray

// buyProperty(uint _propertyId)
// this takes property id as an argument and then checks if 
// property related to that is avaibale and price is sufficient then it assigns 
// the id to the new owner and tranfers the funds and emits the
// event for property to be soldout

// getPropertylistIDs()
//this function will simply give you the list of ids of properties enrolled 
//it returns ths uint256[]  _residential and uint256[]  _commercial

//findIndex(uint256[] memory arr, uint256 value) 
//it takes array and id as an argument and traverse through the array to find if
//the id already exist or not so it can remove any colliions 




