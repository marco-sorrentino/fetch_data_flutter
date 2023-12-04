import 'dart:convert';

import 'package:fetch_data_flutter/models/product.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

class ProductFetch extends StatefulWidget {
  const ProductFetch({super.key});

  @override
  State<ProductFetch> createState() => _ProductFetchState();
}

class _ProductFetchState extends State<ProductFetch> {
  List<Product> _listProduct = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    try {
      final url = Uri.https("fakestoreapi.com", "/products");
      final res = await http.get(url);
      if (res.statusCode == 200) {
        final List<dynamic> data = json.decode(res.body);
        List<Product> products =
            data.map((el) => Product.fromJson(el)).toList();
        setState(() {
          _listProduct = products;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _listProduct.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: GlobalKey(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Text(_listProduct[index].title),
                subtitle: Text(_listProduct[index].price.toString()),
                leading: Image.network(
                  _listProduct[index].image,
                  width: 50,
                  height: 50,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
