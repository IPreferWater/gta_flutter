import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gta_flutter/model/category.dart';
import 'package:gta_flutter/model/item.dart';
import 'package:gta_flutter/model/sub_category.dart';
import 'package:gta_flutter/screen/item_screen.dart';
import 'package:gta_flutter/widget/sub_category_creation_form.dart';
import 'package:gta_flutter/bloc/category_bloc/bloc.dart';

class SubCategoryScreen extends StatefulWidget {
  final Category category;

  SubCategoryScreen({@required this.category});

  _SubCategoryScreenState createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  CategoryBloc _categoryBloc;

  final label = TextEditingController();

  @override
  void initState() {
    super.initState();
    _categoryBloc = BlocProvider.of<CategoryBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Groups'),
        actions: <Widget>[],
      ),
      body: _creationMenu(),
    );
  }

  String getItemHaveOnItemSize(SubCategory s){
        var itemHave = s.items.where((item) => item.have == true);
        int itemHaveSize = itemHave.length;
        int itemSize =  s.items.length;
      return '$itemHaveSize/$itemSize';
  }
  Widget _creationMenu() {
    return Column(children: <Widget>[
      ListView.builder(
        shrinkWrap: true,
        itemCount: widget.category.subCategories.length,
        itemBuilder: (context, index) {
          final displayedSubCategory = widget.category.subCategories[index];
          return ListTile(
            title: Text(displayedSubCategory.label),
            subtitle: Text(getItemHaveOnItemSize(displayedSubCategory)),
            trailing: _buildUpdateDeleteSubCategory(index),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ItemScreen(
                          category: widget.category, subCategoryIndex: index)));
            },
          );
        },
      ),
      FloatingActionButton.extended(

          icon: Icon(Icons.add),
          label: Text('create group of items'),
          onPressed: () async {
            Category updatedCategory = await showDialog(
              context: context,
              builder: (BuildContext context) =>
                  SubCategoryFormDialog(category: widget.category),
            );
            _categoryBloc.add(UpdateCategoryEvent(updatedCategory));
            setState(() {});
          }),
    ]);
  }

  Row _buildUpdateDeleteSubCategory(int subCategoryIndex) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              Category updatedCategory = await showDialog(
                context: context,
                builder: (BuildContext context) => SubCategoryFormDialog(
                    subCategoryIndexToUpdate: subCategoryIndex,
                    category: widget.category),
              );
              _categoryBloc.add(UpdateCategoryEvent(updatedCategory));
              setState(() {});
            }),
        IconButton(
          icon: Icon(Icons.delete_outline),
          onPressed: () {
            widget.category.subCategories.removeAt(subCategoryIndex);
            _categoryBloc.add(UpdateCategoryEvent(widget.category));
            setState(() {});
          },
        ),
      ],
    );
  }
}
