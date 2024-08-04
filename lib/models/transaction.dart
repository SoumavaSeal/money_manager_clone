class Transaction{
    final int id;
    final double amount;
    final DateTime date;
    final int type;
    int categoryId = 0;
    final int accountId; 
    String note = "";
    String description = "";
    
    Transaction(this.id, this.amount, this.date, this.type,  this.categoryId, this.accountId, this.note, this.description);
}
