import 'package:gta_flutter/model/sub_category.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SubCategoryEvent extends Equatable {
  SubCategoryEvent([List props = const []]) : super(props);
}

class LoadSubCategoriesEvent extends SubCategoryEvent {}

class CreateSubCategoryEvent extends SubCategoryEvent{
  final SubCategory subCategory;

  CreateSubCategoryEvent(this.subCategory) : super ([subCategory]);
}

class UpdateSubCategoryEvent extends SubCategoryEvent{
  final SubCategory subCategory;

  UpdateSubCategoryEvent(this.subCategory) : super([subCategory]);
}

class DeleteSubCategoryEvent extends SubCategoryEvent{
  final SubCategory subCategory;

  DeleteSubCategoryEvent(this.subCategory) : super([subCategory]);
}