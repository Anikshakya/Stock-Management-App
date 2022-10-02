class StockManageModel{
  String? stockName;
  String? transactionType;
  String? quantity;
  String? buyingPrice;
  String? sellingPrice;
  String? transactionDate;

  StockManageModel(
    this.stockName, 
    this.transactionType, 
    this.quantity, 
    this.buyingPrice,
    this.sellingPrice,
    this.transactionDate,
  );
}