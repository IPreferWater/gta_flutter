import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gta_flutter/model/category.dart';
import 'package:gta_flutter/model/item.dart';
import 'package:gta_flutter/model/sub_category.dart';
import 'package:gta_flutter/widget/add_button.dart';
import 'package:gta_flutter/widget/carousel_slider.dart';
import 'package:gta_flutter/widget/item_creation_form.dart';
import 'package:gta_flutter/widget/item_pannel.dart';

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

  //ItemBloc _itemBloc;

  @override
  void initState(){
    super.initState();
   // _itemBloc = BlocProvider.of<ItemBloc>(context);
   // _itemBloc.subCategory = widget.subCategory;
   // _itemBloc.add(LoadItemsEvent());
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
    return Text("todo");
  /*  return BlocBuilder(
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
                  _buildItemScreen(state.items),
                  AddButton(
                      formDialog: ItemFormDialog(category: widget.category, subCategory: widget.subCategory)
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

  Widget _buildItemScreen(List<Item> items){

    if(items.isEmpty){
      return Text("no item yet");
    }

    return CarouselSlider(
      items: <Widget>[
        for ( var item in items ) ItemPanel(showDialogEditItem:showDialogEditItem, item : item)
      ],
      autoPlay: false,
      enlargeCenterPage: true,
    );
  }

   showDialogEditItem(Item item){
    showDialog(
      context: context,
      builder: (BuildContext context) => ItemFormDialog(category: widget.category, subCategory: widget.subCategory, itemToUpdate: item),
    );
  }
}

