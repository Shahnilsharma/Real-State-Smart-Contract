# Real-State-Smart-Contract
 A smart contract written in solidity to handle a  Real Estate Business with multple and secure functionalities 




# Documentation:

# overview 
this smart contracts allows to run a  real state businesss on a blockchain network 
when deployed anyone can interact with it they can either view deatails of 
a specific property sell and buy one.

# contract detail
structs
Property
this struct describes some basic elements of any property which are:
price: the value in wei (price of the property)(uint)
Onsale: it will ensure that if the property is available or not(bool)
name: name of the property (i.e mega mall, niaz stadium) (string)
owner: the address of the account who ever owns the property(address)
description: describe about the property size,story color (string)
location: where the property is located (string)

# Mappings
Properties(mapping of uint Id to struct property)
this mapping stores the property information for each id . the key is property ID  

# Events
PropertySold(uint256 propertyId);
it will take the id and validate that the property has bee sold
to log it iin the contract

# Arrays 
residentialPropertyIDs(stores ids of property which are residential)
comercialPropertyIDs(stores ids of property which are comercial)
so you directly access the type of property with available id


# Functions
listPropertyForSale(
uint256 _propertyId,  
uint256 _price,
string memory _name,
string memory _description,
string memory _location
)
this function allows user to add their property in the list.
it takes property id number,price,name,description and location as argumnets.
then intializs them with property instance for each value in struct 
then mapping the id to push into the arrray

buyProperty(uint _propertyId)
this takes property id as an argument and then checks if 
property related to that is avaibale and price is sufficient then it assigns 
the id to the new owner and tranfers the funds and emits the
event for property to be soldout

getPropertylistIDs()
this function will simply give you the list of ids of properties enrolled 
it returns ths uint256[]  _residential and uint256[]  _commercial

findIndex(uint256[] memory arr, uint256 value) 
it takes array and id as an argument and traverse through the array to find if
the id already exist or not so it can remove any colliions 


