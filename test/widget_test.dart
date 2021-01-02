// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gta_flutter/main.dart';
import 'package:gta_flutter/model/category.dart';
import 'package:gta_flutter/model/item.dart';
import 'package:gta_flutter/model/parameter.dart';
import 'package:gta_flutter/model/sub_category.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

 /* testWidgets('SubCategory item should have a default value', (WidgetTester tester) async {
    var subCategoryNullItems = SubCategory(label: "label", categoryId: 1);
    expect(subCategoryNullItems.items, <Item>[] );

    Item item = Item( parameters: null);
    List<Item> listItem = [item];

    subCategoryNullItems.addItem(item);
    expect(subCategoryNullItems.items, <Item>[item] );



    var subCategoryWithItems = SubCategory(label: "label", categoryId: 1, items: listItem);
    expect(subCategoryWithItems.items, listItem );
  });*/

  testWidgets('xxxxx', (WidgetTester tester) async {
    /*final paramA1 = Parameter(key: "name", value: "A");
    final paramA2 = Parameter(key: "state", value: "good");
    List<Parameter> parametersA = [ paramA1, paramA2];
    final itemA1 = Item(parameters: parametersA);

    final paramB1 = Parameter(key: "name", value: "B");
    final paramB2 = Parameter(key: "state", value: "bad");
    List<Parameter> parametersB = [ paramB1, paramB2];
    final itemB1 = Item(parameters: parametersB);

    List<Item> items = [itemA1, itemB1];
    final subCategory = SubCategory(label: "1", categoryId: 1, items: items);
    List <String> parametersCategory = ["name","state"];
    var category = Category(label: "test", parameters: parametersCategory, subCategories: [subCategory]);

    final actualParameters1 = category.subCategories[0].items[0].parameters;
    expect(actualParameters1[0].key,"name");
    expect(actualParameters1[0].value,"A");
    expect(actualParameters1[1].key,"newState");
    expect(actualParameters1[1].value,"good");

    final actualParameters2 = category.subCategories[0].items[0].parameters;
    expect(actualParameters2[0].key,"name");
    expect(actualParameters2[0].value,"B");
    expect(actualParameters2[1].value,"newState");
    expect(actualParameters2[1].value,"bad");*/

  });

 /* testWidgets('equatable package test', (WidgetTester tester) async {
    Parameter parameter1 = Parameter(key: "key1", value: "value1");
    Parameter parameter2 = Parameter(key: "key2", value: "value2");
    Item item1 = Item(parameters: [parameter1, parameter2]);

    Parameter parameterA = Parameter(key: "key1", value: "valueA");
    Parameter parameterB = Parameter(key: "key2", value: "valueB");
    Item itemAB = Item(parameters: [parameterA, parameterB]);

    var subCategory = SubCategory(label: "label", categoryId: 1, items: [item1, itemAB] );

    // create a new item with different with same value but different hashcode
    Parameter parameter1NewAshCode = Parameter(key: "key1", value: "value1");
    Parameter parameter2NewAshCode = Parameter(key: "key2", value: "value2");
    Item item1NewAshCode = Item(parameters: [parameter1NewAshCode, parameter2NewAshCode]);

    expect(parameter1 == parameter1NewAshCode, true);
    expect(parameter1 == parameter2NewAshCode, false);
    expect(item1 == item1NewAshCode, true );
    expect(itemAB == item1NewAshCode, false);

    // we can now retrieve
    int index = subCategory.items.indexOf(item1NewAshCode);
    expect(index, 0);

    Parameter parameterANewAshCode = Parameter(key: "key1", value: "valueA");
    Parameter parameterBNewAshCode = Parameter(key: "key2", value: "valueB");
    Item itemABNewAshCode = Item(parameters: [parameterANewAshCode, parameterBNewAshCode]);
    int indexAB = subCategory.items.indexOf(itemABNewAshCode);
    expect(indexAB, 1);
  });*/
}
