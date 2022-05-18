String readProducts = """ 
query Inventory{
  getInventoriesAtRandom{
    inventoryName
    inventoryDescription
    isLowProductAlertEnabled
    Images {
      mediumImageOnlineURL
    }
  }

}

""";
