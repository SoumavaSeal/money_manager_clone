class Categories {
  final int id;
  final int parentId;
  final int type; // 0 for Income and 1 for expense
  final String description;

  Categories(this.id, this.parentId, this.type, this.description);

  static Categories blankCat = Categories(0, 0, -1, "");

  static List<Categories> initialCategories = [
    Categories(1, 0, 0, "Salary"),
    Categories(2, 0, 0, "Allowance"),
    Categories(3, 0, 0, "Bonus"),
    Categories(4, 0, 0, "Gifts"),
    Categories(5, 0, 1, "Needs"),
    Categories(6, 0, 1, "Wants"),
    Categories(7, 5, 1, "Food"),
    Categories(8, 5, 1, "Rent"),
    Categories(9, 5, 1, "Transportation"),
    Categories(10, 5, 1, "Bills"),
    Categories(11, 6, 1, "Personal"),
    Categories(12, 6, 1, "Vacation"),
    Categories(13, 6, 1, "Going Out"),
  ];
}
