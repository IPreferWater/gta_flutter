import 'package:flutter/foundation.dart';
import 'package:gta_flutter/model/item.dart';
import 'package:meta/meta.dart';

class SubCategory {

  int id;
  int categoryId;
  String label;
  List<Item> items = <Item>[];

  SubCategory({
    @required this.label,
    @required this.categoryId,
    this.items }) { items ??= <Item>[];}

  Map<String, dynamic> toMap() {
    return {
      'label' : label,
      'categoryId': categoryId,
      'items': items.map((item) => item.toMap())
    };
  }

  static SubCategory fromMap(Map<String, dynamic> map) {

    return SubCategory(
        label: map['label'],
        categoryId: map['categoryId'],
        //items: map['items'].cast<Item>());
        items: map['items'].map((mapping) => Item.fromMap(mapping)).toList().cast<Item>());
  }

  @override
  String toString() {
    return 'SubCategory{ \n'
        'id : $id,\n'
        ' label : $label,\n'
        ' categoryId: $categoryId,\n,'
        ' items: $items}\n';
  }

   addItem(Item item){
    this.items.add(item);
  }

  deleteItem(Item itemToDelete){
    this.items.remove(itemToDelete);
  }
}