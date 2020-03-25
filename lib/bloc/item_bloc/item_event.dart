import 'package:gta_flutter/model/category.dart';
import 'package:gta_flutter/model/item.dart';
import 'package:gta_flutter/model/sub_category.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ItemEvent extends Equatable {
  ItemEvent([List props = const []]) : super(props);
}

class LoadItemsEvent extends ItemEvent {}

class InsertItem extends ItemEvent{
  final Item item;
  InsertItem(this.item) : super ([item]);
}

class DeleteItem extends ItemEvent{
  final Item item;
  DeleteItem(this.item) : super ([item]);
}

/*
class LoadSubCategoriesFromCategoryEvent extends ItemEvent {
  final Category category;
  LoadSubCategoriesFromCategoryEvent(this.category) : super ([category]);
}

class CreateSubCategoryEvent extends ItemEvent{
  final SubCategory subCategory;

  CreateSubCategoryEvent(this.subCategory) : super ([subCategory]);
}

class UpdateSubCategoryEvent extends ItemEvent{
  final SubCategory subCategory;

  UpdateSubCategoryEvent(this.subCategory) : super([subCategory]);
}

class DeleteSubCategoryEvent extends ItemEvent{
  final SubCategory subCategory;

  DeleteSubCategoryEvent(this.subCategory) : super([subCategory]);
}*/