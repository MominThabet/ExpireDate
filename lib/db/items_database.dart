import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/item.dart';

class ItemsDatabase {
  static final ItemsDatabase instance = ItemsDatabase._init();

  static Database? _database;

  ItemsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('itemss.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute(
        '''
CREATE TABLE $tableItems ( 
  ${ItemFields.id} $idType, 
  ${ItemFields.title} $textType,
  ${ItemFields.description} TEXT,
  ${ItemFields.expaireDate} $textType
  )
''');
  }

  Future<Item> create(Item Item) async {
    final db = await instance.database;
    final id = await db.insert(tableItems, Item.toJson());
    return Item.copy(id: id);
  }

  Future<Item> readItem(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableItems,
      columns: ItemFields.values,
      where: '${ItemFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Item.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Item>> readAllItems() async {
    final db = await instance.database;
    const orderBy = '${ItemFields.expaireDate} ASC';
    final result = await db.query(tableItems, orderBy: orderBy);
    return result.map((json) => Item.fromJson(json)).toList();
  }

  Future<int> update(Item Item) async {
    final db = await instance.database;

    return db.update(
      tableItems,
      Item.toJson(),
      where: '${ItemFields.id} = ?',
      whereArgs: [Item.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableItems,
      where: '${ItemFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
