import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gta_flutter/bloc/category_bloc/bloc.dart';
import 'package:gta_flutter/model/category.dart';

class CategoryScreen extends StatefulWidget{

  final Category categoryToUpdate;

  CategoryScreen({
    this.categoryToUpdate
  });

  _CategoryScreenState createState() => _CategoryScreenState();

}
class _CategoryScreenState extends State<CategoryScreen> {

  CategoryBloc _categoryBloc;

  final _formKey = GlobalKey<FormState>();
  final label = TextEditingController();
  List<TextEditingController> _parameters = new List();


  Category category;

  @override
  void initState(){
    super.initState();

   /* _categoryBloc = BlocProvider.of<CategoryBloc>(context);

    if(this.widget.categoryToUpdate!=null){
      category = this.widget.categoryToUpdate;
      label.text = category.label;
      category.parameters.forEach((parameter) {
        _parameters.add( new TextEditingController(text: parameter));
      });
    }*/
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
    return Text("bjr");
  }
}