import 'package:gta_flutter/model/category.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CategoryEvent extends Equatable {
  CategoryEvent([List props = const []]) : super(props);
}

class LoadCategories extends CategoryEvent {}

class CreateCategory extends CategoryEvent{
  final Category category;

  CreateCategory(this.category) : super ([category]);
}

class UpdateCategory extends CategoryEvent{
  final Category updatedCategory;

  UpdateCategory(this.updatedCategory) : super([updatedCategory]);
}

class DeleteCategory extends CategoryEvent{
  final Category category;

  DeleteCategory(this.category) : super([category]);
}