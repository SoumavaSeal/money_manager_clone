class Transactions {
  final int id;
  final double amount;
  final DateTime date;
  final int
      type; // Transaction type --> { 0 : "Income", 1 : "Expense", 2 : "Transfer" }
  final int categoryId;
  final int accountId;
  final int toAccountID;
  String note = "";
  String description = "";

  Transactions(this.id, this.amount, this.date, this.type, this.categoryId,
      this.accountId, this.toAccountID, this.note, this.description);
}
