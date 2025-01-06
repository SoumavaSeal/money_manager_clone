class Account {
  int id;
  String name;
  int accountGroup;
  double amount = 0.0;
  String description;

  Account(this.id, this.name, this.accountGroup, this.amount, this.description);

  static Account blankAcc = Account(0, "", 0, 0.0, "");

  static List<Account> initialAccounts = [
    Account(1, "Wallet", 1, 0.0, ""),
    Account(2, "S/B Account - 1", 2, 0.0, ""),
    Account(3, "Credit Card - 1", 3, 0.0, ""),
  ];
}
