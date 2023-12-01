import 'dart:convert';
import 'package:fetch_data_flutter/models/user.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

class DataFetch extends StatefulWidget {
  const DataFetch({super.key});

  @override
  State<DataFetch> createState() => _DataFetchState();
}

class _DataFetchState extends State<DataFetch> {
  List<User> _userInfo = [];
  var _isLoading = true;
  var _isError = false;

  @override
  void initState() {
    super.initState();
    _getData();
    print(_userInfo);
  }

  void _getData() async {
    try {
      final url = Uri.https("jsonplaceholder.typicode.com", "/users");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        List<User> users = data.map((json) => User.fromJson(json)).toList();
        setState(() {
          _userInfo = users;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isError = true;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isError = true;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_isError) {
      return const Center(
        child: Text("I'm sorry an error occured"),
      );
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _userInfo.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(_userInfo[index].name),
                      Text(_userInfo[index].username),
                      Text(_userInfo[index].address.city),
                      Text(_userInfo[index].address.street)
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
