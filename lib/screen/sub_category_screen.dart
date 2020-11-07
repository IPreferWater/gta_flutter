import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gta_flutter/model/category.dart';
import 'package:gta_flutter/model/sub_category.dart';
import 'package:gta_flutter/screen/item_screen.dart';
import 'package:gta_flutter/widget/add_button.dart';
import 'package:gta_flutter/widget/category_creation_form.dart';
import 'package:gta_flutter/widget/sub_category_creation_form.dart';

class SubCategoryScreen extends StatefulWidget{

  final Category category;

  SubCategoryScreen({
    @required this.category
  });

  _SubCategoryScreenState createState() => _SubCategoryScreenState();

}
class _SubCategoryScreenState extends State<SubCategoryScreen> {

  //SubCategoryBloc _subCategoryBloc;

  final label = TextEditingController();

  @override
  void initState(){
    super.initState();
   // _subCategoryBloc = BlocProvider.of<SubCategoryBloc>(context);
   // _subCategoryBloc.category = widget.category;
   // _subCategoryBloc.add(LoadSubCategoriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    print('relooooooad');
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
    return Column(
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.category.subCategories.length,
            itemBuilder: (context, index) {
              final displayedSubCategory = widget.category.subCategories[index];
              return ListTile(
                title: Text(displayedSubCategory.label),
                subtitle: Text(
                    'label : ${displayedSubCategory.label}'),
                trailing: _buildUpdateDeleteSubCategory(index),
                onTap: () {
                  //go to item screen
                /*  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SubCategoryScreen(category: displayedSubCategory,))
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
   /* return BlocBuilder(
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
                                subCategory: displayedSubCategory))
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
    );*/
  }

  Row _buildUpdateDeleteSubCategory(int subCategoryIndex){
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => SubCategoryFormDialog(
                subCategoryIndexToUpdate: subCategoryIndex,
                category: widget.category,
              ),
            );
          },
        ),
        IconButton(
          icon: Icon(Icons.delete_outline),
          onPressed: () {
            //_subCategoryBloc.add(DeleteSubCategoryEvent(subCategory));
            //delete this subcategory from json list
          },
        ),
      ],
    );
  }
}