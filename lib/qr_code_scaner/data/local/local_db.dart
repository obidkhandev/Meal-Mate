// import 'package:flutter/foundation.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
//
// import '../../utils/contants/app_constants.dart';
// import '../model/coffee_model.dart';
//
// class LocalDatabase {
//   static final databaseInstance = LocalDatabase._();
//
//   LocalDatabase._();
//
//   factory LocalDatabase() {
//     return databaseInstance;
//   }
//
//   Database? _database;
//
//   //Step 3
//   Future<Database> get database async {
//     if (_database != null) {
//       return _database!;
//     } else {
//       _database = await _init("coffee.db");
//       return _database!;
//     }
//   }
//
//   //Step 4
//   Future<Database> _init(String databaseName) async {
//     //......Android/data
//     String internalPath = await getDatabasesPath();
//     //......Android/data/todo.db
//     String path = join(internalPath, databaseName);
//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: _onCreate,
//     );
//   }
//
//   Future<void> _onCreate(Database db, int version) async {
//     const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
//     const textType = "TEXT NOT NULL";
//     const intType = "INTEGER DEFAULT 0";
//
//     await db.execute('''CREATE TABLE ${CoffeeModelConstants.tableName} (
//       ${CoffeeModelConstants.id} $idType,
//       ${CoffeeModelConstants.name} $textType,
//       ${CoffeeModelConstants.description} $textType,
//       ${CoffeeModelConstants.subtitle} $textType,
//       ${CoffeeModelConstants.rate} $textType,
//       ${CoffeeModelConstants.price} $intType,
//       ${CoffeeModelConstants.created_at} $textType,
//       ${CoffeeModelConstants.type} $textType
//     )''');
//   }
//
//   static Future<CoffeeModel> insertTask(CoffeeModel coffeeModel) async {
//     debugPrint("INITIAL ID:${coffeeModel.categoryId}");
//     final db = await databaseInstance.database;
//     int savedTaskID =
//     await db.insert(CoffeeModelConstants.tableName, coffeeModel.toJson());
//     debugPrint("SAVED ID:$savedTaskID");
//     return coffeeModel.copyWith(categoryId: savedTaskID);
//   }
//
//   static Future<List<CoffeeModel>> getAllItems() async {
//     final db = await databaseInstance.database;
//     String orderBy = '${CoffeeModelConstants.id} DESC';
//     List json = await db.query(CoffeeModelConstants.tableName, orderBy: orderBy);
//     return json.map((e) => CoffeeModel.fromJson(e)).toList();
//   }
// }