import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gta_flutter/bloc/item_bloc/bloc.dart';
import 'package:gta_flutter/model/item.dart';

class ItemPanel extends StatefulWidget{

  final Item item;

  ItemPanel({
    @required this.item
  });

  _ItemPanelState createState() => _ItemPanelState();

}
class _ItemPanelState extends State<ItemPanel> {

  ItemBloc _itemBloc;

  @override
  void initState(){
    super.initState();
    _itemBloc = BlocProvider.of<ItemBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(widget.item.toString()),
    Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      FloatingActionButton(
        child: Icon(Icons.edit),
        backgroundColor: Colors.green,
        onPressed: () {
        //  _itemBloc.add(event)
        },
      ),
      FloatingActionButton(
        child: Icon(Icons.delete),
        backgroundColor: Colors.red,
        onPressed: () {
          _itemBloc.add(DeleteItem(widget.item));
        },
      )
      ])
      ],
    );
  }
}