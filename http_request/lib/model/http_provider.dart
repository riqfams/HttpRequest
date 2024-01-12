import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpProvider extends ChangeNotifier {

  Map<String, dynamic> _items = {};

  Map<String, dynamic> get items => _items;

  int get itemCount{
    return _items.length;
  }

  Uri uri;

  HttpProvider(String uriString) : uri = Uri.parse(uriString);

  getData(String id, BuildContext context) async {
    var resultResponse = await http.get(
      Uri.parse('https://reqres.in/api/users/$id'),
    );

    if(resultResponse.statusCode == 200) {
      _items = (json.decode(resultResponse.body))["data"];
      notifyListeners();
      handlingStatusCode(context, "Data berhasil diambil");
    } else {
      _items = {};
      handlingStatusCode(context, "Data gagal diambil - {$resultResponse.statusCode}");
    }

  }

  postData(String name, String job) async {
    var resultResponse = await http.post(
      Uri.parse('https://reqres.in/api/users'),
      body: {
        'name': name,
        'job': job
      }
    );

    _items = json.decode(resultResponse.body);
    notifyListeners();
  }

  void deleteData(BuildContext context) async {
    var resultResponse = await http.delete(uri);

    if(resultResponse.statusCode == 204) {
      _items = {};
      notifyListeners();
      handlingStatusCode(context, "No Content");
    } else {
      handlingStatusCode(context, "Data gagal dihapus");
    }
  }

  handlingStatusCode(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      )
    );
  }

}