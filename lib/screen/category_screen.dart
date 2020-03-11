import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gta_flutter/bloc/sub_category_bloc/bloc.dart';
import 'package:gta_flutter/model/category.dart';

class CategoryScreen extends StatefulWidget{

  final Category categoryToUpdate;

  CategoryScreen({
    this.categoryToUpdate
  });

  _CategoryScreenState createState() => _CategoryScreenState();

}
class _CategoryScreenState extends State<CategoryScreen> {

  SubCategoryBloc _subCategoryBloc;

  final _formKey = GlobalKey<FormState>();
  final label = TextEditingController();


  @override
  void initState(){
    super.initState();
    _subCategoryBloc = BlocProvider.of<SubCategoryBloc>(context);
    _subCategoryBloc.add(LoadSubCategoriesEvent());

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
      Scaffold(
        appBar: AppBar(
          title: Text('Creation app'),
          actions: <Widget>[
          ],
        ),
        body: _creationMenu(),
      );
  }

  Widget _creationMenu() {
    return BlocBuilder(
      bloc: _subCategoryBloc,
      builder: (BuildContext context, SubCategoryState state){
        if (state is SubCategoryLoadingState){
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SubCategoriesLoadingSuccessState){
          Text("okkk");
        }

        return Center(
            child: Text(
              "error ?",
              textAlign: TextAlign.center,
            ));
      },
    );
  }


}