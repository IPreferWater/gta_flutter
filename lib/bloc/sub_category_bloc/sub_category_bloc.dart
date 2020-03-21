import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:gta_flutter/database/sub_category_dao.dart';
import 'package:gta_flutter/model/category.dart';
import 'sub_category_event.dart';
import 'sub_category_state.dart';

class SubCategoryBloc extends Bloc<SubCategoryEvent, SubCategoryState> {

  SubCategoryDao _subCategoryDao = SubCategoryDao();
  Category category;

  @override
  SubCategoryState get initialState => SubCategoryLoadingState();

  @override
  Stream<SubCategoryState> mapEventToState(
      SubCategoryEvent event,
      ) async* {
    if (event is LoadSubCategoriesEvent) {
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
    }
  }

  Stream<SubCategoryState> _reloadCategories() async* {
    final subCategories = await _subCategoryDao.getAllFromCategory(category.id);
    print(subCategories);
    yield SubCategoriesLoadingSuccessState(subCategories);
  }
}