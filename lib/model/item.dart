import 'dart:collection';

import 'package:meta/meta.dart';

class Item {

  String label;
  HashMap<String, String> parameters ;

  Item({
    @required this.label,
    @required this.parameters});

  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'label' : label,
      'parameter': parameters
    };
  }

  static Item fromMap(Map<String, dynamic> map) {
    return Item(label: map['label'], parameters: map['parameters'].cast<String>());
  }

  @override
  String toString() {
    return 'Item{ label : $label}';
  }
}