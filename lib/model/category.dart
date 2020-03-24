import 'package:meta/meta.dart';

class Category {

  int id;
  String label;
  List <String> parameters;

  Category({
    @required this.label,
    @required this.parameters});

  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'label' : label,
      'parameters': parameters
    };
  }

  static Category fromMap(Map<String, dynamic> map) {
    return Category(label: map['label'], parameters: map['parameters'].cast<String>());
  }

  @override
  String toString() {
    return 'Category{ id : $id, label : $label, parameters: $parameters}';
  }
}