import 'dart:async';

import 'package:easy_contacts/models/base.dart';
import 'package:easy_contacts/utils/constant.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stacked/stacked.dart';

abstract class BaseService<T extends BaseModel> with ListenableServiceMixin {
  BaseService() {
    _box = Hive.box<T>(boxName);
    _migrateLegacyItems();
    _items.value = _box.values.toList();
    listenToReactiveValues([_items]);
  }

  final _items = ReactiveValue<List<T>>(<T>[]);
  late final Box<T> _box;

  List<T> get items => _items.value;

  String get boxName;

  String get legacyKey;

  T? getById(String id) => _box.get(id);

  void addItem(T item) {
    unawaited(_box.put(item.id, item));
    _refresh();
  }

  bool updateItem(T item) {
    if (!_box.containsKey(item.id)) {
      return false;
    }
    unawaited(_box.put(item.id, item));
    _refresh();
    return true;
  }

  bool removeItem(String id) {
    if (!_box.containsKey(id)) {
      return false;
    }
    unawaited(_box.delete(id));
    _refresh();
    return true;
  }

  void _refresh() {
    _items.value = _box.values.toList();
  }

  void _migrateLegacyItems() {
    final Box<dynamic> legacyBox = Hive.box(Constant.legacyBoxName);
    final dynamic legacyItems = legacyBox.get(legacyKey);
    if (legacyItems == null) {
      return;
    }
    final List<T> items = (legacyItems as List<dynamic>).cast<T>();
    unawaited(_box.putAll({for (final T item in items) item.id: item}));
    unawaited(legacyBox.delete(legacyKey));
  }
}
