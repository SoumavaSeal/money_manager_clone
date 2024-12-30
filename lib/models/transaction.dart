class Transactions{
    final int id;
    final double amount;
    final DateTime date;
    final int type;
    final int categoryId;
    final int accountId; 
    String note = "";
    String description = "";
    
    Transactions(this.id, this.amount, this.date, this.type,  this.categoryId, this.accountId, this.note, this.description);
}
