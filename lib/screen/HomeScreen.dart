import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gta_flutter/bloc/category_bloc/bloc.dart';
import 'package:gta_flutter/model/category.dart';
import 'package:gta_flutter/widget/CategoryCreationForm.dart';
import 'package:gta_flutter/widget/add_button.dart';

import 'sub_category_screen.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CategoryBloc _categoryBloc;

  @override
  void initState() {
    super.initState();
    _categoryBloc = BlocProvider.of<CategoryBloc>(context);
    _categoryBloc.add(LoadCategoriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      bloc: _categoryBloc,
      builder: (BuildContext context, CategoryState state) {
        if (state is CategoryLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is CategoriesLoadingSuccessState) {
          return
            Column(
                children: <Widget>[
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.categories.length,
                    itemBuilder: (context, index) {
                      final displayedCategory = state.categories[index];
                      return ListTile(
                        title: Text(displayedCategory.id.toString()),
                        subtitle: Text(
                            'id : ${displayedCategory.id} label : ${displayedCategory.label}'),
                        trailing: _buildUpdateDeleteQrCode(displayedCategory),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => SubCategoryScreen(category: displayedCategory,))
                          );
                        },
                      );
                    },
                  ),
                  AddButton(
                    formDialog: CategoryFormDialog()
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

  Row _buildUpdateDeleteQrCode(Category categoryDisplayed){
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
  }
}