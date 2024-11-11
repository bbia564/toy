import 'dart:ffi';
import 'dart:math';
import 'package:faker/faker.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:get/get.dart';
import 'package:toy_manager/app/modules/home/controllers/home_controller.dart';
import 'package:toy_manager/app/modules/plan_page/controllers/plan_page_controller.dart';
import 'package:toy_manager/utils/pm_share_per.dart';
import 'package:toy_manager/utils/toy_model.dart';

class TMDatabaseTool extends GetxService {
  late Database db;

  Future<TMDatabaseTool> init() async {
    await initDB();
    return this;
  }

  initDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'toy_manager.db');

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await createTable(db);
    });

    refreshHomeData();
  }

  void refreshHomeData() async {
    final hasData = TMSharedPreferences.getBool("has_initail_dates") ?? false;

    if (hasData) {
      if (Get.isRegistered<HomeController>()) {
        Get.find<HomeController>().loadAllToys();
      }

      if (Get.isRegistered<PlanPageController>()) {
        Get.find<PlanPageController>().loadallPlans();
      }
      return;
    }

    await Future.delayed(const Duration(milliseconds: 100));

    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'toy_manager.db');
    db = await openDatabase(path,
        version: 1, onCreate: (Database db, int version) async {});

    final count = 5 + Random().nextInt(6);
    for (var i = 0; i < count; i++) {
      final dateStr =
          "2024-${1 + Random().nextInt(7)}-${1 + Random().nextInt(31)}";
      final model = ToyModel();
      model.name = faker.animal.name();
      model.localPhoto = "assets/images/toy${1 + Random().nextInt(7)}.png";
      model.status = i % 2 > 0 ? 0 : 1;
      model.price = 0.0;
      model.photo = "";
      model.createTime = dateStr;

      await db.insert('toy_table', {
        'name': model.name,
        "price": model.price,
        'photo': model.photo,
        'status': model.status,
        'localPhoto': model.localPhoto,
        'createTime': model.createTime,
      });

      final plan = PlanModel();
      plan.tID = i + 1;
      plan.name = model.name;
      plan.localPhoto = model.localPhoto;
      plan.status = model.status;
      plan.price = 0.0;
      plan.photo = "";
      plan.createTime = dateStr;
      await db.insert('plan_table', {
        'tID': plan.tID,
        'name': plan.name,
        "price": plan.price,
        'photo': plan.photo,
        'status': plan.status,
        'localPhoto': plan.localPhoto,
        'createTime': plan.createTime,
      });
    }

    await TMSharedPreferences.putBool("has_initail_dates", true);

    if (Get.isRegistered<HomeController>()) {
      Get.find<HomeController>().loadAllToys();
    }

    if (Get.isRegistered<PlanPageController>()) {
      Get.find<PlanPageController>().loadallPlans();
    }
  }

  createTable(Database db) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS  toy_table (id INTEGER PRIMARY KEY AUTOINCREMENT , name TEXT ,price DOUBLE ,status INT, photo TEXT, localPhoto TEXT, createTime TEXT)');
    await db.execute(
        'CREATE TABLE IF NOT EXISTS plan_table (id INTEGER PRIMARY KEY AUTOINCREMENT, tID INT, name TEXT ,price DOUBLE ,status INT, photo TEXT, localPhoto TEXT, createTime TEXT,FOREIGN KEY (tID) REFERENCES plan_table(id))');
  }

  Future<void> insertToyData(ToyModel model) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'toy_manager.db');
    db = await openDatabase(path,
        version: 1, onCreate: (Database db, int version) async {});
    await db.insert('toy_table', {
      'name': model.name,
      "price": model.price,
      'photo': model.photo,
      'status': model.status,
      'localPhoto': model.localPhoto,
      'createTime': model.createTime,
    });
  }

  Future<void> updateToyData(ToyModel model) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'toy_manager.db');
    db = await openDatabase(path,
        version: 1, onCreate: (Database db, int version) async {});
    await db.update(
        'toy_table',
        {
          'name': model.name,
          "price": model.price,
          'photo': model.photo,
          'status': model.status,
          'localPhoto': model.localPhoto,
          'createTime': model.createTime,
        },
        where: "id = ?",
        whereArgs: [model.id]);
  }

  Future<void> insertPlan(PlanModel item) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'toy_manager.db');
    db = await openDatabase(path,
        version: 1, onCreate: (Database db, int version) async {});
    await db.insert('plan_table', {
      'tID': item.tID,
      'name': item.name,
      "price": item.price,
      'photo': item.photo,
      'status': item.status,
      'localPhoto': item.localPhoto,
      'createTime': item.createTime,
    });
  }

  Future<void> deletToyModel(ToyModel item) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'toy_manager.db');
    db = await openDatabase(path,
        version: 1, onCreate: (Database db, int version) async {});
    await db.delete('toy_table', where: "id = ?", whereArgs: [item.id]);
  }

  Future<void> clean() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'toy_manager.db');
    db = await openDatabase(path,
        version: 1, onCreate: (Database db, int version) async {});
    await db.delete('toy_table');
    await db.delete('plan_table');
  }

  Future<List<ToyModel>> allToy() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'toy_manager.db');
    db = await openDatabase(path,
        version: 1, onCreate: (Database db, int version) async {});
    var result = await db.query('toy_table', orderBy: 'id DESC');
    return result.map((e) => ToyModel.fromJson(e)).toList();
  }

  Future<List<PlanModel>> getAllPlanDetail({int? tID}) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'toy_manager.db');

    db = await openDatabase(path,
        version: 1, onCreate: (Database db, int version) async {});

    if (tID != null) {
      var result = await db.query('plan_table',
          where: 'tID = ?', whereArgs: [tID], orderBy: 'id DESC');
      return result.map((e) => PlanModel.fromJson(e)).toList();
    } else {
      var result = await db.query('plan_table', orderBy: 'id DESC');
      return result.map((e) => PlanModel.fromJson(e)).toList();
    }
  }
}
