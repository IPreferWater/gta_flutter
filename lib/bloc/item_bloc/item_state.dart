import 'package:gta_flutter/model/item.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ItemState extends Equatable {
  ItemState([List props = const []]) : super(props);
}

class ItemLoadingState extends ItemState {}

class ItemsLoadingSuccessState extends ItemState {
  final List<Item> items;

  ItemsLoadingSuccessState(this.items) : super([items]);
}
class ItemLoadingErrorState extends ItemState {}
