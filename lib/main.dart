import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gta_flutter/bloc/category_bloc/bloc.dart';
import 'package:gta_flutter/widget/CategoryCreationForm.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider (
      providers: [
        BlocProvider<CategoryBloc>(
          create: (BuildContext context) => CategoryBloc(),
        ),
      ],
      //child: MyHomePage(title: 'Flutter Demo Home Page'),`
      child: MaterialApp(

    title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body :FloatingActionButton(
        onPressed: (){
          showDialog(
            context: context,
            builder: (BuildContext context) => CategoryFormDialog(),
          );
        },
        child: Icon(Icons.add),
      )
    );
  }
}
