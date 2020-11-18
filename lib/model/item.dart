import 'package:equatable/equatable.dart';
import 'package:gta_flutter/model/parameter.dart';
import 'package:meta/meta.dart';

class Item extends Equatable {

  List<Parameter> parameters;

  Item({
    @required this.parameters});

  Map<String, dynamic> toMap() {
    return {
      'parameters': parameters.map((parameter) => parameter.toMap()).toList(growable: false)
    };
  }

  static Item fromMap(Map<String, dynamic> map) {

    return Item(
        parameters: map['parameters'].map((mapping) => Parameter.fromMap(mapping)).toList().cast<Parameter>());

  }

  @override
  String toString() {
    return ' Item { parameters : $parameters }';
  }

  /*@override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Item &&
              runtimeType == other.runtimeType &&
              parameters == other.parameters;

  @override
  int get hashCode => runtimeType.hashCode;*/
 /* @override
  List<Object> get props => [parameters];*/
}