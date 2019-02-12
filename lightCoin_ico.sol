// LightCoin ICO 

pragma solidity ^0.5.0;

contract LightCoin_ico {
    
    // Introducing the maximum number of LightCoin available for sale 
    uint public max_lightcoins = 1000000;
    
    // introducing the USD to lightcoin conversion rate
        uint public usd_to_lightcoins = 1000;

    // introducing the total number od lightcoins that have been bought by the investors 
    uint public total_lightcoins_bought = 0;
    
    //mapping from the investors address to its equety in lightcoin and usd 
    mapping(address => uint) equity_lightcoin;
     mapping(address => uint) equity_usd;
     
    // Checking if an investor can buy lightcoin
    modifier can_by_lightcoin(uint usd_invested){
        require(usd_invested * usd_to_lightcoins + total_lightcoins_bought <= max_lightcoins);
        _;
    }
    
    // Getting the equity in lightcoin of an investor
    function equity_in_lightcoin (address investor) external view returns (uint) {
        return equity_lightcoin[investor];
    }
    
     function equity_in_usd(address investor) external view returns (uint) {
        return equity_usd[investor];
    }
    
    //Buying lightcoin
    function buy_lightcoins(address investor,uint usd_invested) external can_by_lightcoin(usd_invested) {
        uint lightcoin_bought = usd_invested * usd_to_lightcoins;
        equity_lightcoin[investor] += lightcoin_bought;
        equity_usd[investor] = equity_lightcoin[investor] / 1000;
        total_lightcoins_bought += lightcoin_bought;
    }
    
    // Selling lightcoin
    
      function sell_lightcoins(address investor,uint lightcoins_sold) external  {
        equity_lightcoin[investor] -= lightcoins_sold;
        equity_usd[investor] = equity_lightcoin[investor] / 1000;
        total_lightcoins_bought -= lightcoins_sold;
    }
}