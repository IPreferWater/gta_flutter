import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gta_flutter/bloc/sub_category_bloc/bloc.dart';
import 'package:gta_flutter/model/category.dart';
import 'package:gta_flutter/widget/add_button.dart';
import 'package:gta_flutter/widget/sub_category_creation_form.dart';

class SubCategoryScreen extends StatefulWidget{

  final Category category;

  SubCategoryScreen({
    @required this.category
  });

  _SubCategoryScreenState createState() => _SubCategoryScreenState();

}
class _SubCategoryScreenState extends State<SubCategoryScreen> {

  SubCategoryBloc _subCategoryBloc;

  final _formKey = GlobalKey<FormState>();
  final label = TextEditingController();


  @override
  void initState(){
    super.initState();
    _subCategoryBloc = BlocProvider.of<SubCategoryBloc>(context);
    _subCategoryBloc.add(LoadSubCategoriesFromCategoryEvent(widget.category));

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
          return
            Column(
                children: <Widget>[
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.subCategories.length,
                    itemBuilder: (context, index) {
                      final displayedSubCategory = state.subCategories[index];
                      return ListTile(
                        title: Text(displayedSubCategory.id.toString()),
                        subtitle: Text(
                            'id : ${displayedSubCategory.id} label : ${displayedSubCategory.label}'),
                       // trailing: _buildUpdateDeleteQrCode(displayedSubCategory),
                        onTap: () {
                         /* Navigator.push(context,
                              MaterialPageRoute(builder: (context) => SubCategoryScreen())
                          );*/
                        },
                      );
                    },
                  ),
                  AddButton(
                      formDialog: SubCategoryFormDialog(category: widget.category)
                  ),
                ]
            );
        }

        return Center(
            child: Text(
              "error ?",
              textAlign: TextAlign.center,
            ));
      },
    );
  }

  /*Row _buildUpdateDeleteQrCode(SubCategory categoryDisplayed){
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => CategoryFormDialog(
                categoryToUpdate: categoryDisplayed,
              ),
            );
          },
        ),
        IconButton(
          icon: Icon(Icons.delete_outline),
          onPressed: () {
            _categoryBloc.add(DeleteCategoryEvent(categoryDisplayed));
          },
        ),
      ],
    );
  }*/


}