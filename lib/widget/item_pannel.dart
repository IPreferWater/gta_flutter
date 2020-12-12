import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gta_flutter/model/item.dart';

class ItemPanel extends StatefulWidget{

  final Item item;
  final int itemIndex;
  final void Function(int itemIndex) showDialogEditItem;
  final void Function(int itemIndex) deleteItem;

  ItemPanel({
    @required this.item,
    @required this.itemIndex,
    @required this.showDialogEditItem,
    @required this.deleteItem
  });

  _ItemPanelState createState() => _ItemPanelState();

}
class _ItemPanelState extends State<ItemPanel> {

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildListParameterWidget(widget.item.parameters),
    Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      FloatingActionButton(
        child: Icon(Icons.edit),
        backgroundColor: Colors.green,
        onPressed: () {
        widget.showDialogEditItem(widget.itemIndex);
        },
      ),
      FloatingActionButton(
        child: Icon(Icons.delete),
        backgroundColor: Colors.red,
        onPressed: () {
          widget.deleteItem(widget.itemIndex);
        },
      )
      ])
      ],
    );
  }

  Widget _buildListParameterWidget (List<String> itemParameters){

    List<Text> dd =  itemParameters.map((e) => Text(e)).toList(growable: false);
        return Column(children: dd);
  }
}