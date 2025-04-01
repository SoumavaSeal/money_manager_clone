import 'package:money_manager_clone/models/account_group.dart';
import 'package:money_manager_clone/models/accounts.dart';
import 'package:money_manager_clone/models/categories.dart';
import 'package:money_manager_clone/models/transaction.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseServices {
  static Database? _db;
  static final DatabaseServices dbInstance = DatabaseServices._constructor();

  // Tables names
  final String trxnTable = "TRANSACTIONS";
  final String accountsTable = "ACCOUNTS";
  final String accountsGroupTable = "ACCOUNT_GROUP";
  final String categoryTable = "CATEGORIES";

  DatabaseServices._constructor();

  // getter
  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    } else {
      _db = await getDatabase();
      return _db!;
    }
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();

    final String databasePath = join(databaseDirPath, "money_manager.db");

    final database =
        await openDatabase(databasePath, version: 1, onCreate: (db, version) {
      // Create table for transactions.
      db.execute('''
          CREATE TABLE $trxnTable (
              id INTEGER PRIMARY KEY,
              amount REAL NOT NULL,
              date TEXT NOT NULL,
              type INTEGER NOT NULL,
              categoryId INTEGER NOT NULL,
              accountId INTEGER NOT NULL,
              toAccountId INTEGER,
              note TEXT,
              description TEXT
          )
      ''');

      // Create table for accountGroups.
      db.execute('''
                        CREATE TABLE $accountsGroupTable (
                             id INTEGER PRIMARY KEY,
                             name TEXT NOT NULL,
                             type INTEGER NOT NULL

                        )
                    ''');

      // Create table for Accounts
      db.execute('''
                    CREATE TABLE $accountsTable (
                        id INTEGER PRIMARY KEY,
                        name TEXT NOT NULL,
                        acc_grp INTEGER NOT NULL,
                        initial_amt REAL NOT NULL,
                        amount REAL NOT NULL,
                        description TEXT
                    )
                ''');

      // Create table for Categories
      db.execute('''
                    CREATE TABLE $categoryTable (
                        id INTEGER PRIMARY KEY,
                        parent_id INTEGER NOT NULL,
                        type INTEGER NOT NULL,
                        description TEXT
                    )
                ''');

      // Insert initial Account Groups
      for (final accGrp in AccountGroup.initialAccGrpList) {
        db.insert(
            accountsGroupTable, {"name": accGrp.name, "type": accGrp.type});
      }

      // Insert initial Accounts
      for (final acc in Account.initialAccounts) {
        db.insert(accountsTable, {
          "name": acc.name,
          "acc_grp": acc.accountGroup,
          "initial_amt": acc.initialAmt,
          "amount": acc.amount,
          "description": acc.description
        });
      }

      // Insert initial Categories
      for (final cat in Categories.initialCategories) {
        db.insert(categoryTable, {
          "parent_id": cat.parentId,
          "type": cat.type,
          "description": cat.description
        });
      }
    });

    return database;
  }

  void addAccount(Account acc) async {
    final db = await database;
    await db.insert(accountsTable, {
      "name": acc.name,
      "acc_grp": acc.accountGroup,
      "initial_amt": acc.initialAmt,
      "amount": acc.amount,
      "description": acc.description
    });
  }

  void addAccountGroup(AccountGroup accGrp) async {
    final db = await database;
    await db
        .insert(accountsGroupTable, {"name": accGrp.name, "type": accGrp.type});
  }

  void addTransaction(Transactions trxn) async {
    final db = await database;
    await db.insert(trxnTable, {
      "amount": trxn.amount,
      "date": trxn.date.toIso8601String(),
      "type": trxn.type,
      "categoryId": trxn.categoryId,
      "accountID": trxn.accountId,
      "toAccountID": trxn.toAccountID,
      "note": trxn.note,
      "description": trxn.description
    });
  }

  Future<List<Account>> getAccount() async {
    final db = await database;
    final data = await db.query(accountsTable);

    List<Account> acc = data
        .map((e) => Account(
            id: e["id"] as int,
            name: e["name"] as String,
            accountGroup: e["acc_grp"] as int,
            initialAmt: e["initial_amt"] as double,
            amount: e["amount"] as double,
            description: e["description"] as String))
        .toList();

    return acc;
  }

  Future<List<AccountGroup>> getAccountGrp() async {
    final db = await database;
    final data = await db.query(accountsGroupTable);

    List<AccountGroup> accGrp = data
        .map((e) =>
            AccountGroup(e["id"] as int, e["name"] as String, e["type"] as int))
        .toList();

    return accGrp;
  }

  Future<List<Transactions>> getTransactions() async {
    final db = await database;
    final data = await db.query(trxnTable);

    List<Transactions> trxn = data.map((e) {
      String date = e["date"] as String;
      return Transactions(
          e["id"] as int,
          e["amount"] as double,
          DateTime.parse(date),
          e["type"] as int,
          e["categoryId"] as int,
          e["accountId"] as int,
          e["toAccountId"] as int,
          e["note"] as String,
          e["description"] as String);
    }).toList();

    return trxn;
  }

  Future<List<Categories>> getCategories() async {
    final db = await database;
    final data = await db.query(categoryTable);

    List<Categories> cat = data.map((e) {
      return Categories(e["id"] as int, e["parent_id"] as int, e["type"] as int,
          e["description"] as String);
    }).toList();

    return cat;
  }

  void updateAccountData(String columnName, String value, String id) async {
    final db = await database;
    db.update(accountsTable, {'$columnName': value},
        where: 'id = ?', whereArgs: [id]);
  }

  void updateData(
      String tableName, String id, Map<String, Object?> value) async {
    final db = await database;
    print(id);
    db.update(tableName, value, where: 'id = ?', whereArgs: [id]);
  }
}
