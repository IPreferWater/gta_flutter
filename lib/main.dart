import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gta_flutter/bloc/category_bloc/bloc.dart';
import 'package:gta_flutter/bloc/sub_category_bloc/bloc.dart';
import 'package:gta_flutter/screen/category_screen.dart';

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
        BlocProvider<SubCategoryBloc>(
          create: (BuildContext context) => SubCategoryBloc(),
        )
      ],
      child: MaterialApp(

    title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
        home: HomeScreen()
    )
    );
  }
}