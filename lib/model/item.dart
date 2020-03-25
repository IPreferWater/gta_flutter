import 'package:gta_flutter/model/parameter.dart';
import 'package:meta/meta.dart';

class Item {

  List<Parameter> parameters;

  Item({
    @required this.parameters});

  Map<String, dynamic> toMap() {
    return {
      'parameters': parameters.map((parameter) => parameter.toMap())
    };
  }

  static Item fromMap(Map<String, dynamic> map) {

    return Item(
        parameters: map['parameters'].map((mapping) => Parameter.fromMap(mapping)).toList().cast<Parameter>());

  }

  @override
  String toString() {
    return 'Item{\n'
        'parameters : $parameters\n }';
  }
}