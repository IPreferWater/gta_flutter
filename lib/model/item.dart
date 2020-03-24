import 'package:gta_flutter/model/parameter.dart';
import 'package:meta/meta.dart';

class Item {

  String label;
  List<Parameter> parameters;

  Item({
    @required this.label,
    @required this.parameters});

  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'label' : label,
      'parameters': parameters.map((parameter) => parameter.toMap())
    };
  }

  static Item fromMap(Map<String, dynamic> map) {

    return Item(
        label: map['label'],
        //parameters: map['parameters'].cast<Parameter>());
        parameters: map['parameters'].map((mapping) => Parameter.fromMap(mapping)).toList().cast<Parameter>());

  }

  @override
  String toString() {
    return 'Item{ label : $label,\n'
        'parameters : $parameters\n }';
  }
}