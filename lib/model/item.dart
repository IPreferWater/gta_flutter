import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Item extends Equatable {

  List<String> parameters;
  bool have;

  Item({
    @required this.parameters,
  @required this.have});

  Map<String, dynamic> toMap() {
    return {
      'parameters': parameters,
      'have':have
    };
  }

  static Item fromMap(Map<String, dynamic> map) {

    return Item(
         parameters: map['parameters'].cast<String>(),
    have: map['have']);

  }

  @override
  String toString() {
    return ' Item { parameters : $parameters, have : $have }';
  }

}