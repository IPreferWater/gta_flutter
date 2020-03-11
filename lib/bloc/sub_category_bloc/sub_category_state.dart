import 'package:gta_flutter/model/sub_category.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SubCategoryState extends Equatable {
  SubCategoryState([List props = const []]) : super(props);
}

class SubCategoryLoadingState extends SubCategoryState {}

class SubCategoriesLoadingSuccessState extends SubCategoryState {
  final List<SubCategory> subCategories;

  SubCategoriesLoadingSuccessState(this.subCategories) : super([subCategories]);
}
class SubCategoryLoadingErrorState extends SubCategoryState {}
