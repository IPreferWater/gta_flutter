import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gta_flutter/bloc/sub_category_bloc/bloc.dart';
import 'package:gta_flutter/model/category.dart';
import 'package:gta_flutter/model/sub_category.dart';
import 'package:gta_flutter/screen/item_screen.dart';
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

  final label = TextEditingController();


  @override
  void initState(){
    super.initState();
    _subCategoryBloc = BlocProvider.of<SubCategoryBloc>(context);
    _subCategoryBloc.category = widget.category;
    _subCategoryBloc.add(LoadSubCategoriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          title: Text('Sub Categories'),
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
                        trailing: _buildUpdateDeleteSubCategory(displayedSubCategory),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => ItemScreen(
                                category: widget.category,
                                subCategory: displayedSubCategory,
                                subCategoryBloc: _subCategoryBloc,))
                          );
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

  Row _buildUpdateDeleteSubCategory(SubCategory subCategory){
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => SubCategoryFormDialog(
                subCategoryToUpdate: subCategory,
                category: widget.category,
              ),
            );
          },
        ),
        IconButton(
          icon: Icon(Icons.delete_outline),
          onPressed: () {
            _subCategoryBloc.add(DeleteSubCategoryEvent(subCategory));
          },
        ),
      ],
    );
  }
}