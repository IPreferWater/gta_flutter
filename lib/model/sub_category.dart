import 'package:flutter/foundation.dart';
import 'package:gta_flutter/model/item.dart';
import 'package:meta/meta.dart';

class SubCategory {

  String label;
  List<Item> items = <Item>[];

  SubCategory({
    @required this.label,
    this.items }) { items ??= <Item>[];}

  Map<String, dynamic> toMap() {
    return {
      'label' : label,
      'items': items.map((item) => item.toMap()).toList(growable : false)
    };
  }

  static SubCategory fromMap(Map<String, dynamic> map) {

    return SubCategory(
        label: map['label'],
        items: map['items'].map((mapping) => Item.fromMap(mapping)).toList().cast<Item>());
  }

  @override
  String toString() {
    return 'SubCategory{ \n'
        ' label : $label,\n'
        ' items: $items}\n';
  }

   addItem(Item item){
  //  this.items.add(item);
  }

  deleteItem(Item itemToDelete){
  //  this.items.remove(itemToDelete);
  }
}