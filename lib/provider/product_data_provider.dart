import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shopverse/utils/api_url.dart';

class ProductDataProvider extends ChangeNotifier {
  Dio dio = Dio();
  List productdata = <dynamic>[];
  bool isLoad = false;
  bool isShowList = false;

  void getProductList() async {
    print("getProductcalll...");
    isLoad = true;
    notifyListeners();

    try {
      final product = await dio.get(ApiUrl.PRODUCT_LIST);
      productdata = product.data['products'];
      print("productdata>>> $productdata");
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoad = false;
      notifyListeners();
    }
  }

  void onPressShowList(bool isChnaged) {
    isShowList = isChnaged;
    notifyListeners();
  }
}
