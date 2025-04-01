class Account {
  int id;
  String name;
  int accountGroup;
  double initialAmt = 0.0;
  double amount = 0.0;
  String description;

  Account(
      {required this.id,
      required this.name,
      required this.accountGroup,
      required this.initialAmt,
      required this.amount,
      required this.description});

  static Account blankAcc = Account(
      id: 0,
      name: "",
      accountGroup: 0,
      initialAmt: 0.0,
      amount: 0.0,
      description: "");

  static List<Account> initialAccounts = [
    Account(
        id: 1,
        name: "Wallet",
        accountGroup: 1,
        initialAmt: 0.0,
        amount: 0.0,
        description: ""),
    Account(
        id: 2,
        name: "S/B Account - 1",
        accountGroup: 2,
        initialAmt: 0.0,
        amount: 0.0,
        description: ""),
    Account(
        id: 3,
        name: "Credit Card - 1",
        accountGroup: 3,
        initialAmt: 0.0,
        amount: 0.0,
        description: "")
  ];
}
