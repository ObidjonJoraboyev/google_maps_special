import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/place_model.dart';

class MyAppConstants {
  static const String placeTableName = "places_table";
}

class PlaceModelConstants {
  static const String id = "place_id";
  static const String placeName = "place_name";
  static const String placeCategory = "place_category";
  static const String lat = "place_lat";
  static const String long = "place_long";
  static const String entrance = "place_entrance";
  static const String flatNumber = "place_flatNumber";
  static const String orientAddress = "place_orientAddress";
  static const String stage = "place_stage";
}

class LocalDatabase {
  static final databaseInstance = LocalDatabase._();

  LocalDatabase._();

  factory LocalDatabase() {
    return databaseInstance;
  }

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _init("places.db");
      return _database!;
    }
  }

  Future<Database> _init(String databaseName) async {
    String internalPath = await getDatabasesPath();
    String path = join(internalPath, databaseName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";
    const textType2 = 'TEXT';

    await db.execute('''CREATE TABLE ${MyAppConstants.placeTableName} (
      ${PlaceModelConstants.id} $idType,
       ${PlaceModelConstants.placeCategory} $textType,
      ${PlaceModelConstants.placeName} $textType,
      ${PlaceModelConstants.lat} TEXT,
      ${PlaceModelConstants.long} TEXT,
      ${PlaceModelConstants.entrance} $textType2,
      ${PlaceModelConstants.flatNumber} $textType2,
      ${PlaceModelConstants.orientAddress} $textType2,
      ${PlaceModelConstants.stage} $textType2
    )''');
  }

  static Future<PlaceModel> insertPlace(PlaceModel placeModel) async {
    final db = await databaseInstance.database;
    int savedTaskID =
        await db.insert(MyAppConstants.placeTableName, placeModel.toJson());
    return placeModel.copyWith(id: savedTaskID);
  }

  static Future<List<PlaceModel>> getAllItems() async {
    final db = await databaseInstance.database;
    String orderBy = '${PlaceModelConstants.id} DESC';
    List<Map<String, dynamic>> json =
        await db.query(MyAppConstants.placeTableName, orderBy: orderBy);
    return json.map((e) => PlaceModel.fromJson(e)).toList();
  }

  static Future<int> deleteItem(int id) async {
    final db = await databaseInstance.database;
    int deletedId = await db.delete(MyAppConstants.placeTableName,
        where: "${PlaceModelConstants.id} = ?", whereArgs: [id]);
    return deletedId;
  }

  static Future<void> updatePlace(PlaceModel place) async {
    final db = await databaseInstance.database;
    await db.update(
      MyAppConstants.placeTableName,
      place.toJson(), // Convert the PlaceModel to a map
      where: '${PlaceModelConstants.id} = ?',
      whereArgs: [place.id],
    );
  }
}
