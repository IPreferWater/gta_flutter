import 'dart:collection';

import 'package:meta/meta.dart';

class Parameter {

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
}