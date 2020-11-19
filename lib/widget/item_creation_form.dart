
import 'package:flutter/material.dart';
import 'package:gta_flutter/model/category.dart';
import 'package:gta_flutter/model/item.dart';
import 'package:gta_flutter/model/parameter.dart';

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

  @override
  void initState(){
    super.initState();

    List<Parameter> parameters;
    if (this.widget.itemIndex != null){
      Item item = this.widget.category.subCategories[widget.subCategoryIndex].items[widget.itemIndex];
    parameters = item.parameters;
    }else{
      parameters = widget.category.parameters.map((e) => Parameter(key: e, value : "")).toList(growable: false);
    }
    parameters.forEach((p) => _parameters.add(

      new TextFormField(
      controller: new TextEditingController(text: p.value),
      decoration: InputDecoration(
        icon: Icon(Icons.person),
        hintText: 'Title of the after item',
        labelText: p.key,
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
              child: _parameters[index]
            )
            ]
      );
    }
        ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        
                        List<Parameter> listParameters =  _parameters.asMap().entries.map((e) =>
                            Parameter(
                                key: widget.category.parameters[e.key],
                                value : e.value.controller.text))
                            .toList(growable: false);

                        Item itemValidated = new Item(
                          parameters: listParameters
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