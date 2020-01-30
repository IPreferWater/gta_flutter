import 'package:gta_flutter/model/category.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CategoryState extends Equatable {
  CategoryState([List props = const []]) : super(props);
}

class CategoryLoadingState extends CategoryState {}

class CategoriesLoadingSuccessState extends CategoryState {
  final List<Category> categories;

  CategoriesLoadingSuccessState(this.categories) : super([categories]);
}
class CategoryLoadingErrorState extends CategoryState {}
