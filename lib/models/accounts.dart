class Account {
    int id;
    String name;
    int accountGroup;
    double amount = 0.0;
    String description;

    Account(this.id, this.name, this.accountGroup, this.amount, this.description);

    static List<Account> initialAccounts = [
        Account(1, "Cash", 1, 0.0, ""),
        Account(2, "Account", 2, 0.0, ""),
        Account(3, "Credit Card", 3, 0.0, ""),
        Account(4, "Debit Card", 4, 0.0, ""),
    ];
}
