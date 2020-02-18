import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gta_flutter/bloc/category_bloc/bloc.dart';
import 'package:gta_flutter/model/category.dart';
import 'package:gta_flutter/widget/row_parameters.dart';

class CategoryFormDialog extends StatefulWidget{

  final Category categoryToUpdate;

  CategoryFormDialog({
    this.categoryToUpdate
  });

  _CategoryFormDialogState createState() => _CategoryFormDialogState();

}
class _CategoryFormDialogState extends State<CategoryFormDialog> {

  CategoryBloc _categoryBloc;

  final _formKey = GlobalKey<FormState>();
  final label = TextEditingController();
  List<TextEditingController> _controllers = new List();


  Category category;

  @override
  void initState(){
    super.initState();

    _categoryBloc = BlocProvider.of<CategoryBloc>(context);
    _categoryBloc.add(LoadCategoriesEvent());

    if(this.widget.categoryToUpdate!=null){
      category = this.widget.categoryToUpdate;
    }else{
      category = new Category(label: "", parameters: ["aaa","bbb","ccc"]);
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
          itemCount: category.parameters.length,
          key: UniqueKey(),

          itemBuilder: (context, index) {

            final item = category.parameters[index];
            TextEditingController _textEditController = new TextEditingController();
            _textEditController.text = item;
            _controllers.add(_textEditController);
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: _controllers[index],

                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        hintText: 'Title of the after item',
                        labelText: 'Title',
                      ),
                      validator: (String value) {
                        return value.isEmpty ? 'must not be empty' : null;
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {

                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete_outline),
                    onPressed: () {
                      category.parameters.removeAt(index);
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
                  category.parameters.add("add?");
                  this.setState((){});
                },
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        final categoryValided = Category(
                          label: label.text
                        );

                        //TODO: make this code correct
                        if(widget.categoryToUpdate!=null){
                          categoryValided.id = widget.categoryToUpdate.id;
                          _categoryBloc.add(UpdateCategoryEvent(categoryValided));
                        }else{
                          _categoryBloc.add(CreateCategoryEvent(categoryValided));
                        }

                        //in this form we put the state to load only free qrCode, we want to retrieve the other
                        _categoryBloc.add(LoadCategoriesEvent());
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