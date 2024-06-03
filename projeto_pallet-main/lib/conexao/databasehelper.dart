import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sistema_cargas/product.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT NOT NULL,
        password TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE drivers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        vehiclePlate TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE shipments (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        shipmentId TEXT NOT NULL,
        clientName TEXT NOT NULL,
        driverId INTEGER NOT NULL,
        FOREIGN KEY (driverId) REFERENCES drivers (id)
      )
    ''');
    await db.execute('''
      CREATE TABLE products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE selected_products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        shipmentId INTEGER NOT NULL,
        productId INTEGER NOT NULL,
        FOREIGN KEY (shipmentId) REFERENCES shipments (id),
        FOREIGN KEY (productId) REFERENCES products (id)
      )
    ''');
    await db.execute('''
      CREATE TABLE IF NOT EXISTS orders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        driverName TEXT NOT NULL,
        vehiclePlate TEXT NOT NULL,
        shipmentId TEXT NOT NULL,
        clientName TEXT NOT NULL,
        selectedProductIds TEXT NOT NULL
      )
    ''');

    await _insertProducts(db);

    await db.insert('users', {'email': 'diego@gmail.com', 'password': 'diego123'});
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS orders (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          driverName TEXT NOT NULL,
          vehiclePlate TEXT NOT NULL,
          shipmentId TEXT NOT NULL,
          clientName TEXT NOT NULL,
          selectedProductIds TEXT NOT NULL
        )
      ''');
    }
  }

  Future<void> _insertProducts(Database db) async {
    List<Map<String, dynamic>> products = [
      {'name': 'UNIFRIOS LEITE FERM. BAUNILHA GARRAFA 60X80G', 'description': 'Descrição do produto 1'},
      {'name': 'UNIFRIOS LEITE FERM. BAUNILHA GARRAFA 24X170G', 'description': 'Descrição do produto 2'},
      {'name': 'UNIFRIOS LEITE FERM. C/SUCO UVA GARRAFA 24X170G', 'description': 'Descrição do produto 3'},
      {'name': 'UNIFRIOS IOG. MORANGO GARRAFA 24X160G', 'description': 'Descrição do produto 4'},
      {'name': 'UNIFRIOS IOG. COCO GARRAFA 24X160G', 'description': 'Descrição do produto 5'},          
      {'name': 'UNIFRIOS IOG. FRUTAS VERMELHAS GARRAFA 24X160G', 'description': 'Descrição do produto 6'},
    ];

    for (var product in products) {
      await db.insert('products', product);
    }
  }

  Future<bool> authenticateUser(String email, String password) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    return result.isNotEmpty;
  }

  Future<Product> getProduct(int productId) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'products',
      where: 'id = ?',
      whereArgs: [productId],
    );

    if (result.isNotEmpty) {
      return Product.fromMap(result.first);
    } else {
      throw Exception("Product not found");
    }
  }

  Future<List<Product>> getAllProducts() async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query('products');
    return result.map((map) => Product.fromMap(map)).toList();
  }

  Future<void> updateProduct(Product product) async {
    Database db = await database;
    await db.update(
      'products',
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  Future<void> deleteProduct(int productId) async {
    Database db = await database;
    await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [productId],
    );
  }
}
