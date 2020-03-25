import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gta_flutter/bloc/item_bloc/bloc.dart';
import 'package:gta_flutter/model/category.dart';
import 'package:gta_flutter/model/sub_category.dart';
import 'package:gta_flutter/widget/add_button.dart';
import 'package:gta_flutter/widget/carousel_slider.dart';
import 'package:gta_flutter/widget/item_creation_form.dart';

class ItemScreen extends StatefulWidget{

  final Category category;
  final SubCategory subCategory;

  ItemScreen({
    @required this.category,
    @required this.subCategory
  });

  _ItemScreenState createState() => _ItemScreenState();

}
class _ItemScreenState extends State<ItemScreen> {

  ItemBloc _itemBloc;
  
  @override
  void initState(){
    super.initState();
    _itemBloc = BlocProvider.of<ItemBloc>(context);
    _itemBloc.subCategory = widget.subCategory;
    _itemBloc.add(LoadItemsEvent());
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
      bloc: _itemBloc,
      builder: (BuildContext context, ItemState state){
        if (state is ItemLoadingState){
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ItemsLoadingSuccessState){
          return
            Column(
                children: <Widget>[
                  CarouselSlider(
                    items: <Widget>[
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.subCategory.items.length,
                          key: UniqueKey(),
                          itemBuilder: (context, index) {
                            return Text(widget.subCategory.items[index].toString());
                          }
                      )
                    ],
                    autoPlay: false,
                    enlargeCenterPage: true,
                    viewportFraction: 0.9,
                    aspectRatio: 2.0,
                  ),
                  AddButton(
                      formDialog: ItemFormDialog(category: widget.category, subCategory: widget.subCategory,)
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
}