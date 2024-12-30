class AccountGroup {
    int id;
    String name;
    int type; // 0 --> Default; 1 --> Credit Cards; 2 --> Debit Cards

    AccountGroup(this.id, this.name, this.type);

    static List<AccountGroup> initialAccGrpList = [
        AccountGroup(1, "Cash", 0),
        AccountGroup(2, "Accounts", 0),
        AccountGroup(3, "Credit Card", 1),
        AccountGroup(4, "Debit Card", 2),
        AccountGroup(5, "Investments", 0),
        AccountGroup(6, "Loan", 0),
        AccountGroup(7, "Insurance", 0),
    ];
}
