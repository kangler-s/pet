/*
 * @Author: kangler liukang0120@163.com
 * @Date: 2024-02-17 12:23:07
 * @LastEditors: kangler liukang0120@163.com
 * @LastEditTime: 2024-02-17 20:26:25
 * @FilePath: /pet/lib/common/kDataManager.dart
 */
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

// 数据库管理类
class DatabaseManager {
  static Database? _database;

  // 获取数据库实例
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDB();
    return _database!;
  }

  // 初始化数据库
  Future<Database> initDB() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'my_database.db');

    return await openDatabase(path,
        version: 1, onCreate: (Database db, int version) async {});
  }

  Future<String> getDatabasePath() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDocDir.path, 'my_database.db');
    print('数据库-dbPath = ${dbPath}');
    return dbPath;
  }

  // 创建表
  Future<void> createTables(
      Database db, String tableName, Map<String, dynamic> data) async {
    // 假设未知字典数据为Map<String, dynamic>
    final columns = data.keys.map((key) {
      if (data[key] is int) {
        return '$key INTEGER';
      } else if (data[key] is double) {
        return '$key REAL'; // REAL用于存储浮点数
      } else if (data[key] is bool) {
        return '$key INTEGER'; // 用INTEGER表示布尔值
      } else if (data[key] is DateTime) {
        return '$key TEXT'; // 用TEXT表示日期时间
      } else {
        return '$key TEXT'; // 默认使用TEXT类型
      }
    }).join(', ');
    await db.execute('CREATE TABLE $tableName ($columns)');
  }

  // 判断表是否存在
  Future<bool> isTableExists(String tableName) async {
    final db = await database;
    final result = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='$tableName'");
    return result.isNotEmpty;
  }

// 更新数据库表结构
  Future<void> updateTableStructure(
      String tableName, Map<String, dynamic> data) async {
    final db = await database;
    // 检查表是否存在
    final result = await db.rawQuery("PRAGMA table_info(${tableName})");
    data.keys.map((key) async {
      bool columnExists = result.any((column) => column['name'] == key);
      if (!columnExists) {
        // 如果表中不存在cat_friendly列，则添加该列
        await db.execute(
            'ALTER TABLE ${tableName} ADD COLUMN ${key} INTEGER DEFAULT ${data[key]}');
      }
    });
  }

  // 插入数据
  Future<void> insertData(String tableName, Map<String, dynamic> data) async {
    final db = await database;
    if (!(await isTableExists(tableName))) {
      await createTables(db, tableName, data);
    }
    await updateTableStructure(tableName, data);
    await db.insert(tableName, data);
  }

  // 查询数据
  Future<List<Map<String, dynamic>>?> getData(String tableName) async {
    final db = await database;
    if (!(await isTableExists(tableName))) {
      return null;
    }
    return db.query(tableName);
  }

  // 关闭数据库
  Future<void> close() async {
    final db = await database;
    db.close();
  }
}
