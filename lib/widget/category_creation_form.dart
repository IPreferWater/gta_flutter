import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gta_flutter/bloc/category_bloc/bloc.dart';
import 'package:gta_flutter/model/category.dart';

class CategoryFormDialog extends StatefulWidget{

  final Category categoryToUpdate;

  CategoryFormDialog({
    this.categoryToUpdate
  });

  _CategoryFormDialogState createState() => _CategoryFormDialogState();

}
class _CategoryFormDialogState extends State<CategoryFormDialog> {

  FocusNode myFocusNode;
  CategoryBloc _categoryBloc;

  final _formKey = GlobalKey<FormState>();
  final label = TextEditingController();
  List<TextFormField> _parameters = new List();


  Category category;

  @override
  void initState(){
    super.initState();
    myFocusNode = FocusNode();

    _categoryBloc = BlocProvider.of<CategoryBloc>(context);

    if(this.widget.categoryToUpdate!=null){
      category = this.widget.categoryToUpdate;
      label.text = category.label;
      category.parameters.forEach((parameter) {
        _parameters.add(
            new TextFormField(
              controller: new TextEditingController(text: parameter),
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Title of the after item',
                labelText: 'Title',
              ),
              validator: (String value) {
                return value.isEmpty ? 'must not be empty' : null;
              },
            )
        );
      });
    }
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
              TextFormField(
                controller: label,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Title of the before item',
                  labelText: 'Title',
                ),
                validator: (String value) {
                  return value.isEmpty ? 'must not be empty' : null;
                },
              ),

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
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {

                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete_outline),
                    onPressed: () {
                      _parameters.removeAt(index);
                      this.setState((){});
                    },
                  ),
                ],
              );
          },
        ),
              FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  //_parameters.add(new TextEditingController());
                  _parameters.add(
                      new TextFormField(
                    controller: new TextEditingController(),
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      hintText: 'Title of the after item',
                      labelText: 'Title',
                    ),
                    validator: (String value) {
                      return value.isEmpty ? 'must not be empty' : null;
                    },
                  ));
                  this.setState((){});
                },
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    onPressed: _parameters.isEmpty ? null : () {
                      if (_formKey.currentState.validate()) {
                        List<String> listParameters = _parameters.map((parameter) => parameter.controller.text).toList();
                        final categoryValidated = Category(
                          label: label.text,
                          parameters : listParameters
                        );

                        if(widget.categoryToUpdate!=null){
                          categoryValidated.id = widget.categoryToUpdate.id;
                          _categoryBloc.add(UpdateCategoryEvent(categoryValidated));
                        }else{
                          _categoryBloc.add(CreateCategoryEvent(categoryValidated));
                        }
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Submit'),
                  )),
            ]
        )
    );
  }
}