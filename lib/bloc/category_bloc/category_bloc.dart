import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:gta_flutter/database/category_dao.dart';
import 'category_event.dart';
import 'category_state.dart';
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {

  CategoryDao _categoryDao = CategoryDao();

  @override
  CategoryState get initialState => CategoryLoadingState();

  @override
  Stream<CategoryState> mapEventToState(
      CategoryEvent event,
      ) async* {
    if (event is LoadCategoriesEvent) {
      yield CategoryLoadingState();
      yield* _reloadCategories();
    }

    else if (event is CreateCategoryEvent){
      await _categoryDao.insert(event.category);
      //yield* _reloadCategories();
    }

    else if (event is UpdateCategoryEvent){
      await _categoryDao.update(event.category);
      //yield* _reloadCategories();
    }

    else if (event is DeleteCategoryEvent){
      await _categoryDao.delete(event.category);
     // yield* _reloadCategories();
    }
  }

  Stream<CategoryState> _reloadCategories() async* {
    final categories = await _categoryDao.getAll();

    yield CategoriesLoadingSuccessState(categories);
  }
}