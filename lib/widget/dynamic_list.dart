import 'package:flutter/material.dart';
import 'package:gta_flutter/model/parameter.dart';

// ignore: must_be_immutable
class DynamicList extends StatefulWidget{

  List<TextFormField> parameters;
  DynamicList({@required this.parameters});

  _DynamicListState createState() => _DynamicListState();

}
class _DynamicListState extends State<DynamicList> {

 // List<TextFormField> _parameters = new List();

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return  ListView.builder(
      shrinkWrap: true,
      itemCount: widget.parameters.length,
      //key: UniqueKey(),

      itemBuilder: (context, index) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
                child: widget.parameters[index]
            ),
            IconButton(
              icon: Icon(Icons.delete_outline),
              onPressed: () {
                widget.parameters.removeAt(index);
                this.setState((){});
              },
            ),
          ],
        );
      },
    );
  }
}