import 'package:meta/meta.dart';

class SubCategory {

  int id;
  int categoryId;
  String label;

  SubCategory({
    @required this.label,
    @required this.categoryId});

  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'label' : label,
      'categoryId': categoryId
    };
  }

  static SubCategory fromMap(Map<String, dynamic> map) {

    return SubCategory(label: map['label'], categoryId: map['categoryId']);
  }

  @override
  String toString() {
    return 'Category{ label : $label, categoryId: $categoryId}';
  }
}