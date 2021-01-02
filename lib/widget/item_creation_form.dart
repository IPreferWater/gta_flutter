
import 'package:flutter/material.dart';
import 'package:gta_flutter/model/category.dart';
import 'package:gta_flutter/model/item.dart';

class ItemFormDialog extends StatefulWidget{

  final Category category;
  final int subCategoryIndex;
  final int itemIndex;

  ItemFormDialog({
    @required this.category,
    @required this.subCategoryIndex,
    this.itemIndex
  });

  _ItemFormDialogState createState() => _ItemFormDialogState();

}
class _ItemFormDialogState extends State<ItemFormDialog> {

  final _formKey = GlobalKey<FormState>();
  List<TextFormField> _parameters = new List();
  bool _have;

  @override
  void initState(){
    super.initState();

    List<String> parameters;

    if (widget.itemIndex != null){
      Item item = widget.category.subCategories[widget.subCategoryIndex].items[widget.itemIndex];
    parameters = item.parameters;
    _have = item.have;
    }else{
      // for each avalaible parameters, add an empty string
      parameters = widget.category.parameters.map((e) =>  "").toList(growable: false);
     _have = false;
    }

    widget.category.parameters.asMap().forEach((index, p) => _parameters.add(

      new TextFormField(
      controller: new TextEditingController(text: parameters[index]),
      decoration: InputDecoration(
        icon: Icon(Icons.person),
        hintText: p,
        labelText: p,
      ),
      validator: (String value) {
        return value.isEmpty ? 'must not be empty' : null;
      }
    )
      ));
  }

  @override
  Widget build(BuildContext context) {
    return
      Dialog(
        elevation: 0.0,
        child: dialogContent(context),
      );
  }

  dialogContent(BuildContext context) {

    return Form(
        key: _formKey,
        child: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
        ListView.builder(
          shrinkWrap: true,
          itemCount: _parameters.length,
          key: UniqueKey(),
    itemBuilder: (context, index) {
      return Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: _parameters[index],

            )
            ]
      );
    }
        ),
              SwitchListTile (
                title: Text("Do you have it ?"),
                subtitle: Text(_have ? "yes":"no"),
                value: _have,
                onChanged: (value) {
                  setState(() {
                    _have = value;
                  });
                },
                activeTrackColor: Colors.lightGreenAccent,
                activeColor: Colors.green,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {

                        List<String> listParameters = _parameters.asMap().entries.map((e) =>
                        e.value.controller.text
                        ).toList(growable: false);

                        Item itemValidated = new Item(
                          parameters: listParameters,
                          have: _have
                        );

                        if(widget.itemIndex!=null){
                          widget.category.subCategories[widget.subCategoryIndex].items[widget.itemIndex] = itemValidated ;
                        }else {
                          widget.category.subCategories[widget.subCategoryIndex].items.add(itemValidated);
                        }

                        Navigator.pop(context, widget.category);

                      }
                    },
                    child: Text('Submit'),
                  )),
            ]
        )
    );
  }
}