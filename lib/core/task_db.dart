import 'dart:io';

import 'package:flutter/services.dart';
import 'package:objectbox/objectbox.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../objectbox.g.dart';

class TaskDB{

  static TaskDB? _instance;

  TaskDB._();

  static late Store _store;

  static Future<Store> create() async {

    if(_instance == null){
      _instance = TaskDB._();

      final documentsDirectory = await getApplicationDocumentsDirectory();
      final objectBoxDirectory = Directory('${documentsDirectory.path}/task_db/');

      try {
        _store = await openStore(
            directory: p.join(documentsDirectory.path, 'task_db'),
            maxDBSizeInKB: 10485760
        );
      } catch (e) {
        _store = Store.attach(getObjectBoxModel(), documentsDirectory.path);
      }
    }

    return _store;
  }

  static Future<void> copyDatabaseFileFromAssets(Directory objectBoxDirectory, ) async {


    if (!objectBoxDirectory.existsSync()) {
      await objectBoxDirectory.create(recursive: true);
    }

    final dbFile = File('${objectBoxDirectory.path}/data.mdb');
    if (!dbFile.existsSync()) {
      // Get pre-populated db file.
      ByteData data = await rootBundle.load("task_db/data.mdb");

      // Copying source data into destination file.
      await dbFile.writeAsBytes(data.buffer.asUint8List());
    }
  }


}