import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gta_flutter/model/category.dart';
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
        title: Text('Sub Categories'),
        actions: <Widget>[],
      ),
      body: _creationMenu(),
    );
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
            subtitle: Text('2/2'),
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
      FloatingActionButton(
          child: Icon(Icons.add),
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
