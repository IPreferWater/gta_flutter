import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gta_flutter/model/category.dart';
import 'package:gta_flutter/model/item.dart';
import 'package:gta_flutter/model/sub_category.dart';
import 'package:gta_flutter/widget/add_button.dart';
import 'package:gta_flutter/widget/carousel_slider.dart';
import 'package:gta_flutter/widget/item_creation_form.dart';
import 'package:gta_flutter/widget/item_pannel.dart';
import 'package:gta_flutter/bloc/category_bloc/bloc.dart';


class ItemScreen extends StatefulWidget{

  final Category category;
  final int subCategoryIndex;

  ItemScreen({
    @required this.category,
    @required this.subCategoryIndex
  });

  _ItemScreenState createState() => _ItemScreenState();

}
class _ItemScreenState extends State<ItemScreen> {

  CategoryBloc _categoryBloc;
  @override
  void initState(){
    super.initState();
    _categoryBloc = BlocProvider.of<CategoryBloc>(context);
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
    final items = this.widget.category.subCategories[widget.subCategoryIndex].items;

    return     Column(
        children: <Widget>[
          _buildItemScreen(items),
          FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () async {
                Category updatedCategory = await showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      ItemFormDialog(category: widget.category, subCategoryIndex: widget.subCategoryIndex),
                );
                _categoryBloc.add(UpdateCategoryEvent(updatedCategory));
                setState(() {});
              }),
        ]
    );
  }

  Widget _buildItemScreen(List<Item> items){

    if(items.isEmpty){
      return Text("no item yet");
    }

    List<Widget> listItemPanels = new List<Widget>();
    for(var i = 0; i < items.length; i++){
      listItemPanels.add(new ItemPanel( item : items[i], itemIndex: i, showDialogEditItem:showDialogEditItem, deleteItem: deleteItem));
    }

    return CarouselSlider(
      items: listItemPanels,
      autoPlay: false,
      enlargeCenterPage: true,
    );
  }

   showDialogEditItem(int itemIndex) async {

    Category updatedCategory = await showDialog(
      context: context,
      builder: (BuildContext context) =>
          ItemFormDialog(category: widget.category, subCategoryIndex: widget.subCategoryIndex,itemIndex: itemIndex),
    );
    _categoryBloc.add(UpdateCategoryEvent(updatedCategory));
    setState(() {});
  }

  deleteItem(int itemIndex){
    widget.category.subCategories[widget.subCategoryIndex].items.removeAt(itemIndex);
    _categoryBloc.add(UpdateCategoryEvent(widget.category));
    setState(() {});
  }
}

