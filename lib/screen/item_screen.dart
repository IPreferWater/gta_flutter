import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gta_flutter/bloc/sub_category_bloc/bloc.dart';
import 'package:gta_flutter/model/category.dart';
import 'package:gta_flutter/model/sub_category.dart';
import 'package:gta_flutter/widget/add_button.dart';
import 'package:gta_flutter/widget/carousel_slider.dart';
import 'package:gta_flutter/widget/sub_category_creation_form.dart';

class ItemScreen extends StatefulWidget{

  final Category category;
  final SubCategory subCategory;
  final SubCategoryBloc subCategoryBloc;

  ItemScreen({
    @required this.category,
    @required this.subCategory,
    @required this.subCategoryBloc
  });

  _ItemScreenState createState() => _ItemScreenState();

}
class _ItemScreenState extends State<ItemScreen> {





  @override
  void initState(){
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          title: Text('Items'),
          actions: <Widget>[
          ],
        ),
        body: _creationMenu(),
      );
  }

  Widget _creationMenu() {
    return BlocBuilder(
      bloc: widget.subCategoryBloc,
      builder: (BuildContext context, SubCategoryState state){
        if (state is SubCategoryLoadingState){
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SubCategoriesLoadingSuccessState){
          print(widget.subCategory);
          return
            Column(
                children: <Widget>[
                  CarouselSlider(
                    items: <Widget>[
                      Text("aaaaaa"),
                      Text("bbbbbb"),
                      Text("cccccc"),
                    ],
                    autoPlay: false,
                    enlargeCenterPage: true,
                    viewportFraction: 0.9,
                    aspectRatio: 2.0,
                  ),
                  /*ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.subCategory.items.length,
                    itemBuilder: (context, index) {
                      final displayedItem = widget.subCategory.items[index];
                      return ListTile(
                        title: Text(displayedItem.label),
                        subtitle: Text(
                            'label : ${displayedItem.label} parameters : ${displayedItem.parameters}'),
                        //trailing: _buildUpdateDeleteSubCategory(displayedSubCategory),
                        onTap: () {
                         /* Navigator.push(context,
                              MaterialPageRoute(builder: (context) => SubCategoryScreen())
                          );*/
                        },
                      );
                    },
                  ),*/
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

  /*Row _buildUpdateDeleteSubCategory(SubCategory subCategory){
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
  }*/
}