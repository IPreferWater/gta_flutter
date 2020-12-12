import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Item extends Equatable {

  List<String> parameters;

  Item({
    @required this.parameters});

  Map<String, dynamic> toMap() {
    return {
      'parameters': parameters
    };
  }

  static Item fromMap(Map<String, dynamic> map) {

    return Item(
         parameters: map['parameters'].cast<String>());
  }

  @override
  String toString() {
    return ' Item { parameters : $parameters }';
  }

}