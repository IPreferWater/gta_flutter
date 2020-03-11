import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:gta_flutter/database/sub_category_dao.dart';
import 'sub_category_event.dart';
import 'sub_category_state.dart';
class SubCategoryBloc extends Bloc<SubCategoryEvent, SubCategoryState> {

  SubCategoryDao _subCategoryDao = SubCategoryDao();

  @override
  SubCategoryState get initialState => SubCategoryLoadingState();

  @override
  Stream<SubCategoryState> mapEventToState(
      SubCategoryEvent event,
      ) async* {
    if (event is LoadSubCategoriesEvent) {
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
    }
  }

  Stream<SubCategoryState> _reloadCategories() async* {
    final categories = await _subCategoryDao.getAll();
    print(categories);
    yield SubCategoriesLoadingSuccessState(categories);
  }
}