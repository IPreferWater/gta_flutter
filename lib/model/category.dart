import 'package:meta/meta.dart';
import 'package:gta_flutter/model/sub_category.dart';


class Category {

  int id;
  String label;
  List <String> parameters;
  List<SubCategory> subCategories = <SubCategory>[];

  Category({
    @required this.label,
    @required this.parameters,
  this.subCategories}) { subCategories??= <SubCategory>[];}

  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'label' : label,
      'parameters': parameters,
      'subCategories' : subCategories.map((subCategory) => subCategory.toMap()).toList(growable: false)
    };
  }

  static Category fromMap(Map<String, dynamic> map) {
    return Category(
        label: map['label'],
        parameters: map['parameters'].cast<String>(),
        subCategories: map['subCategories'].map((mapping) => SubCategory.fromMap(mapping)).toList().cast<SubCategory>());
  }

  @override
  String toString() {
    return 'Category{ id : $id, label : $label, parameters: $parameters, subCategories : [ $subCategories ]}';
  }
}