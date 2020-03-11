
import 'package:gta_flutter/model/sub_category.dart';
import 'package:sembast/sembast.dart';

import 'app_database.dart';

class SubCategoryDao {
  static const String SUB_CATEGORY_STORE_NAME = 'sub_categories';
  final _subCategoryStore = intMapStoreFactory.store(SUB_CATEGORY_STORE_NAME);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(SubCategory subCategory) async {
    await _subCategoryStore.add(await _db, subCategory.toMap());
  }

  Future update(SubCategory subCategory) async {
    final finder = Finder(filter: Filter.byKey(subCategory.id));
    await _subCategoryStore.update(
      await _db,
      subCategory.toMap(),
      finder: finder,
    );
  }

  Future delete(SubCategory subCategory) async {
    final finder = Finder(filter: Filter.byKey(subCategory.id));
    await _subCategoryStore.delete(
      await _db,
      finder: finder,
    );
  }

  Future<List<SubCategory>> getAll() async {

    final recordSnapshots = await _subCategoryStore.find(
      await _db,
    );

    print(recordSnapshots);
    return recordSnapshots.map((snapshot) {
      final subCategory = SubCategory.fromMap(snapshot.value);
      subCategory.id = snapshot.key;
      return subCategory;
    }).toList();
  }
}