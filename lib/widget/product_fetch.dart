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
    return const Text("ciao");
  }
}
