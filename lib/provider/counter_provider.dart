import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CounterProvider extends ChangeNotifier {
  int count = 0;
  Dio dio = Dio();
  List productdata = <dynamic>[];
  bool isLoad = false;

  void increament() {
    count++;
    print("increament call from counter");
    notifyListeners();
  }

  void getProductList() async {
    isLoad = true;
    try {
      final product = await dio.get("https://dummyjson.com/products");
      print("data>>> ${product.data['products']}");
      productdata = product.data['products'];
      isLoad = false;
      notifyListeners();
    } catch (e) {
      print(e);
    } finally {
      isLoad = false;
    }
  }
}
