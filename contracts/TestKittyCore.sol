pragma solidity 0.4.25;

import "./KittyCore.sol";

contract TestKittyCore is KittyCore {
    
    // look at KittyCore:Line124 for the contracts that are needed to make the system start (unpause())
    
    function testCreatePromoKitty() public {
        address _address = msg.sender;
        uint256 _totalSupply = super.totalSupply();
        uint256 _ownersTokens = super.balanceOf(_address);
        super.createPromoKitty(123456, _address);
        require (_totalSupply+1 == super.totalSupply(), "Supply does not match");
        require (_ownersTokens+1 == super.balanceOf(_address), "Owner's token(s) do not match");
    }
    
    // @Dev: requires sire kitty to be owned by msg.sender
    function testMakeKittyPregnant() public {
        
        if (promoCreatedCount < pregnantKitties+2) {
            testCreatePromoKitty();
            testCreatePromoKitty();
        }
        
        uint256 _sireId = pregnantKitties+1;
        uint256 _matronId = pregnantKitties+2;
        
        require (isReadyToBreed(_sireId), "Sire is not yet ready to breed");
        require (isReadyToBreed(_matronId), "Matron is not yet ready to breed");
        
        address _matronAddress = super.ownerOf(_matronId);
        if (super.ownerOf(_sireId) != _matronAddress){
            // #### requires msg.sender to be patron's Address
            approveSiring(_matronAddress, _sireId);
        }
            
        // Test that these cats are a valid mating pair.
        require (canBreedWith(_matronId, _sireId), "Siring is not permitted for this Kitty");
        
        // all the checking have passed, let's make her pregnant
        uint256 _totalSupply = super.totalSupply();
        uint256 _ownersTokens = super.balanceOf(_matronAddress);

        // All checks passed, kitty gets pregnant!
        _breedWith(_matronId, _sireId);
        
        require (super.isPregnant(_matronId), "Matron is not pregnant");
        
        // KittyBreeding.giveBirth(_matronId) is what actually creates a new Kitty 
        // But to do so, the geneScience is required which is not open source
    }
    
    function testTransfer() public {
        
        if (super.tokensOfOwner(msg.sender).length == 0){
            testCreatePromoKitty();
        }
        
        address testAddress = 0x583031d1113ad414f02576bd6afabfb302140225;
        uint256 token = super.tokensOfOwner(msg.sender)[0];
        
        uint256 _totalSupply = super.totalSupply();
        uint256 _ownersTokens = super.balanceOf(msg.sender);
        uint256 _newOwnerTokens = super.balanceOf(testAddress);
        
        transfer(testAddress, token);
        
        require (_totalSupply == super.totalSupply(), "Supply does not match");
        require (_ownersTokens-1 == super.balanceOf(msg.sender), "Token NOT gone from owner's address");
        require (_newOwnerTokens+1 == super.balanceOf(testAddress), "Token NOT added to new owner's address");
    }
    
    /*function testCreateGen0Kitty() public {
        // KittyMinting.createGen0Auction() but it calls saleAuction.createAuction()
        // action is the only way ownership for a minted gen0 kitty is decided
    }*/
}