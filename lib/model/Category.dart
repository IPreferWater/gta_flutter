import 'package:meta/meta.dart';

class Creation {

  int id;
  String label;
  List <String> parameters;

  Creation({
    @required this.label,
    @required this.parameters});

  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'label' : label,
      'parameters': parameters
    };
  }

  static Creation fromMap(Map<String, dynamic> map) {

    return Creation(
        label : map['label'],
        parameters: map['parameters']
    );
  }

  @override
  String toString() {
    return 'Category{ label : $label, parameters: $parameters}';
  }
}