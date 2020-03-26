import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Parameter extends Equatable {

  String key;
  String value;

  Parameter({
    @required this.key,
    @required this.value});

  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'key' : key,
      'value': value
    };
  }

  static Parameter fromMap(Map<String, dynamic> map) {
    return Parameter(key: map['key'], value: map['value']);
  }

  @override
  String toString() {
    return 'Parameter{ key : $key, value : $value }';
  }

  /*@override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Parameter &&
              runtimeType == other.runtimeType &&
              key == other.key &&
              value == other.value;

  @override
  int get hashCode => key.hashCode ^ value.hashCode;*/

  @override
  List<Object> get props => [key,value];
}