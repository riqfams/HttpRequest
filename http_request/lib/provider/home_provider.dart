import 'dart:math';

import 'package:fancy_button_flutter/fancy_button_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/http_provider.dart';

class HomeProvider extends StatefulWidget {

  HomeProvider({
    super.key,
    required this.myTabs,
  });

  final List<Tab> myTabs;

  @override
  State<HomeProvider> createState() => _HomeProviderState();
}

class _HomeProviderState extends State<HomeProvider> {

  @override
  Widget build(BuildContext context) {

    final dataProvider = Provider.of<HttpProvider>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title: const Text("HTTP Request"),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          bottom: TabBar(
            unselectedLabelColor: Colors.white,
            tabs: widget.myTabs,
            indicator: const BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: Colors.red,
                  width: 2.0
                )
              )
            ),
          ),
        ),
        body: TabBarView(
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      width: 150,
                      height: 150,
                      child: Consumer<HttpProvider>(
                        builder: (context, value, child) => Image.network(
                          (value.items["avatar"] == null)
                              ? ""
                              : value.items["avatar"],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  FittedBox(
                    child: Row(
                      children: [
                        const Text(
                          "ID : "
                        ),
                        Consumer<HttpProvider>(
                          builder: (context, value, child) => Text(
                            (value.items["id"] == null) ? "Belum ada data" : value.items["id"].toString()
                          ),
                        )
                      ]
                    )
                  ),
                  const SizedBox(height: 10),
                  FittedBox(
                    child: Row(
                      children: [
                        const Text(
                          "Email : "
                        ),
                        Consumer<HttpProvider>(
                          builder: (context, value, child) => Text(
                            (value.items["email"] == null) ? "Belum ada data" : value.items["email"]
                          ),
                        )
                      ]
                    )
                  ),
                  const SizedBox(height: 10),
                  FittedBox(
                    child: Row(
                      children: [
                        const Text(
                          "First Name : "
                        ),
                        Consumer<HttpProvider>(
                          builder: (context, value, child) => Text(
                            (value.items["first_name"] == null) ? "Belum ada data" : value.items["first_name"]
                          ),
                        )
                      ]
                    )
                  ),
                  const SizedBox(height: 10),
                  FittedBox(
                    child: Row(
                      children: [
                        const Text(
                          "Last Name : "
                        ),
                        Consumer<HttpProvider>(
                          builder: (context, value, child) => Text(
                            (value.items["last_name"] == null) ? "Belum ada data" : value.items["last_name"]
                          ),
                        )
                      ]
                    )
                  ),
                  const SizedBox(height: 10),
                  FancyButton(
                      button_icon: Icons.get_app_rounded,
                      button_text: "  Get Data  ",
                      button_height: 40,
                      button_width: 200,
                      button_radius: 50,
                      button_color: Theme.of(context).colorScheme.primary,
                      button_outline_color: Colors.yellow,
                      button_outline_width: 1,
                      button_text_color: Colors.white,
                      button_icon_color: Colors.white,
                      icon_size: 22,
                      button_text_size: 15,
                      onClick: (){
                        dataProvider.getData((1+Random().nextInt(10)).toString(), context);
                      }
                  ),
                ]
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                        child: Row(
                            children: [
                              const Text(
                                  "ID : "
                              ),
                              Consumer<HttpProvider>(
                                builder: (context, value, child) => Text(
                                    (value.items["id"] == null) ? "Belum ada data" : value.items["id"]
                                ),
                              )
                            ]
                        )
                    ),
                    const SizedBox(height: 10),
                    FittedBox(
                        child: Row(
                            children: [
                              const Text(
                                  "Name : "
                              ),
                              Consumer<HttpProvider>(
                                builder: (context, value, child) => Text(
                                    (value.items["name"] == null) ? "Belum ada data" : value.items["name"]
                                ),
                              )
                            ]
                        )
                    ),
                    const SizedBox(height: 10),
                    FittedBox(
                        child: Row(
                            children: [
                              const Text(
                                  "Job: "
                              ),
                              Consumer<HttpProvider>(
                                builder: (context, value, child) => Text(
                                    (value.items["job"] == null) ? "Belum ada data" : value.items["job"]
                                ),
                              )
                            ]
                        )
                    ),
                    const SizedBox(height: 10),
                    FancyButton(
                        button_icon: Icons.upload_rounded,
                        button_text: "  Post Data  ",
                        button_height: 40,
                        button_width: 200,
                        button_radius: 50,
                        button_color: Theme.of(context).colorScheme.primary,
                        button_outline_color: Colors.yellow,
                        button_outline_width: 1,
                        button_text_color: Colors.white,
                        button_icon_color: Colors.white,
                        icon_size: 22,
                        button_text_size: 15,
                        onClick: (){
                          dataProvider.postData("morpheus", "leader");
                        }
                    ),
                  ]
              ),
            ),
          ]
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          dataProvider.deleteData(context);
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.delete, color: Colors.white,),
      )
      );
  }
}