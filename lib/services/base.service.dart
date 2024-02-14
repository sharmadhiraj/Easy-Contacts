import 'package:collection/collection.dart';
import 'package:easy_contacts/models/base.dart';
import 'package:easy_contacts/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stacked/stacked.dart';

abstract class BaseService<T extends BaseModel> with ListenableServiceMixin {
  final _items = ReactiveValue<List<T>>(<T>[]);

  List<T> get items => _items.value;

  BaseService() {
    _items.value = Hive.box(Constant.hiveBoxName).get(
      getHiveKeyName(),
      defaultValue: <T>[],
    ).cast<T>();
    listenToReactiveValues([_items]);
  }

  void _saveToHive() {
    try {
      Hive.box(Constant.hiveBoxName).put(
        getHiveKeyName(),
        _items.value,
      );
    } catch (e) {
      debugPrint("Error saving items to Hive: $e");
    }
  }

  void addItem(
    T item,
  ) {
    try {
      _items.value.add(item);
      _refresh();
    } catch (e) {
      debugPrint("Error adding new item: $e");
    }
  }

  bool removeItem(String id) {
    try {
      final int index = _items.value.indexWhere((element) => element.id == id);
      if (index != -1) {
        _items.value.removeAt(index);
        _refresh();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint("Error removing item: $e");
      return false;
    }
  }

  bool updateItem(T item) {
    try {
      final int index =
          _items.value.indexWhere((element) => element.id == item.id);
      if (index != -1) {
        _items.value[index] = item;
        _refresh();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint("Error updating item: $e");
      return false;
    }
  }

  T? getById(String id) {
    return items.firstWhereOrNull((element) => element.id == id);
  }

  void _refresh() {
    _saveToHive();
    notifyListeners();
  }

  String getHiveKeyName();
}
