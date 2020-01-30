import 'package:gta_flutter/model/category.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CategoryEvent extends Equatable {
  CategoryEvent([List props = const []]) : super(props);
}

class LoadCategoriesEvent extends CategoryEvent {}

class CreateCategoryEvent extends CategoryEvent{
  final Category category;

  CreateCategoryEvent(this.category) : super ([category]);
}

class UpdateCategoryEvent extends CategoryEvent{
  final Category category;

  UpdateCategoryEvent(this.category) : super([category]);
}

class DeleteCategoryEvent extends CategoryEvent{
  final Category category;

  DeleteCategoryEvent(this.category) : super([category]);
}