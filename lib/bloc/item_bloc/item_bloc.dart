import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:gta_flutter/database/sub_category_dao.dart';
import 'package:gta_flutter/model/sub_category.dart';
import 'item_event.dart';
import 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {

  SubCategoryDao _subCategoryDao = SubCategoryDao();
  SubCategory subCategory;

  @override
  ItemState get initialState => ItemLoadingState();

  @override
  Stream<ItemState> mapEventToState(
      ItemEvent event,
      ) async* {
    if ( event is LoadItemsEvent){
      yield* _reloadItems();

    } else if ( event is InsertItem) {
      subCategory.addItem(event.item);
      await _subCategoryDao.update(subCategory);
      yield* _reloadItems();
    }
    else if ( event is DeleteItem) {
      subCategory.deleteItem(event.item);
      await _subCategoryDao.update(subCategory);
      yield* _reloadItems();
      }
   /* if (event is LoadSubCategoriesEvent) {
      yield* _reloadCategories();
    }

    else if (event is LoadSubCategoriesFromCategoryEvent){
      yield SubCategoryLoadingState();
      yield* _reloadCategories();
    }

    else if (event is CreateSubCategoryEvent){
      await _subCategoryDao.insert(event.subCategory);
      yield* _reloadCategories();
    }

    else if (event is UpdateSubCategoryEvent){
      await _subCategoryDao.update(event.subCategory);
      yield* _reloadCategories();
    }

    else if (event is DeleteSubCategoryEvent){
      await _subCategoryDao.delete(event.subCategory);
      yield* _reloadCategories();
    }*/
  }

  Stream<ItemState> _reloadItems() async* {
    final subCategoryFound = await _subCategoryDao.getSubCategoryById(subCategory.id);
    yield ItemsLoadingSuccessState(subCategoryFound.items);
  }
}