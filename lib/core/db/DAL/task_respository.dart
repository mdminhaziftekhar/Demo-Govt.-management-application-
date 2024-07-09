
import 'dart:typed_data';

import 'package:flutter_task/core/task_db.dart';
import 'package:objectbox/objectbox.dart';

import '../../../objectbox.g.dart';


class TaskRepository<T> {
  late Box<T> _tBox;
  late Store _store;

  TaskRepository._();

  static Future<TaskRepository<T>> init<T>() async {
    TaskRepository<T> instance = TaskRepository._();
    instance._store = await TaskDB.create();
    instance._tBox = Box<T>(instance._store);

    return instance;
  }

  static TaskRepository<T> initByRef<T>(ByteData ref) {
    TaskRepository<T> instance = TaskRepository._();
    instance._store = Store.fromReference(getObjectBoxModel(), ref);
    instance._tBox = Box<T>(instance._store);

    return instance;
  }

  Future<bool> insert({required T data, PutMode mode = PutMode.insert}) async {
    int result = await _tBox.putAsync(data, mode: mode);
    return result > 0;
  }

  Future<bool> put({required T data, PutMode mode = PutMode.put}) async {
    int result = await _tBox.putAsync(data, mode: mode);
    return result > 0;
  }
  Future<int> update({required T data, PutMode mode = PutMode.update}) async {
    return await _tBox.putAsync(data, mode: mode);
  }

  Future<List<int>> insertBulk({required List data, PutMode mode = PutMode.put}) async {
    List<T> typedData = List<T>.from(data);
    List<int> result = await _tBox.putManyAsync(typedData, mode: mode);
    return result;
  }

  Future<List<T>> getAll() => _tBox.getAllAsync();

  ByteData getRef() {
    return _store.reference;
  }
  

  Future<List<T>> getPagingData({required int page, required int itemCount}) async {
    Query<T> query = _tBox.query().build();
    query.offset = page;
    query.limit = itemCount;
    return await query.findAsync();
  }

  Future<int> deleteAllRows() async {
    return await _tBox.removeAllAsync();
  }

  Future<bool> deleteSingleRow(int id) async {
    return _tBox.remove(id);
  }

  QueryBuilder<T> Function([Condition<T>? qc]) get query => _tBox.query;

  int count() => _tBox.count();

}
