import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http_request/model/http_provider.dart';
import 'package:http_request/provider/home_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  List<Tab> myTabs = [
    const Tab(text: 'GET'),
    const Tab(text: 'POST'),
  ];

  int id = 1 + Random().nextInt(10);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HTTP Request',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
        useMaterial3: true,
      ),
      home: DefaultTabController(
        length: myTabs.length,
        child: ChangeNotifierProvider(
          create: (context) => HttpProvider('https://reqres.in/api/users/+$id'),
          child: HomeProvider(myTabs: myTabs),
        ),
      )
    );
  }
}