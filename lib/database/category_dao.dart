
import 'package:gta_flutter/model/category.dart';
import 'package:sembast/sembast.dart';

import 'app_database.dart';

class CategoryDao {
  static const String CATEGORY_STORE_NAME = 'categories';
  final _categoryStore = intMapStoreFactory.store(CATEGORY_STORE_NAME);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(Category category) async {
    await _categoryStore.add(await _db, category.toMap());
  }

  Future update(Category category) async {
    final finder = Finder(filter: Filter.byKey(category.id));
    await _categoryStore.update(
      await _db,
      category.toMap(),
      finder: finder,
    );
  }

  Future delete(Category category) async {
    final finder = Finder(filter: Filter.byKey(category.id));
    await _categoryStore.delete(
      await _db,
      finder: finder,
    );
  }

  Future<List<Category>> getAll() async {

    final recordSnapshots = await _categoryStore.find(
      await _db,
    );

    return recordSnapshots.map((snapshot) {
      final category = Category.fromMap(snapshot.value);
      category.id = snapshot.key;
      return category;
    }).toList();
  }
}