import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shopverse/screens/single_product_data.dart';
import 'package:shopverse/utils/api_url.dart';

class ProductDataProvider extends ChangeNotifier {
  Dio dio = Dio();
  List productdata = <dynamic>[];
  Map<String, dynamic>? _singleProductData;
  Map<String, dynamic>? get singleProductData => _singleProductData;

  List<dynamic> _saveCategoryList = [];
  List<dynamic> get saveCategoryList => _saveCategoryList;

  bool isLoad = false;
  bool isShowList = false;

  void getProductList() async {
    isLoad = true;
    notifyListeners();

    try {
      final product = await dio.get("${ApiUrl.PRODUCT_LIST}?limit=10&skip=10");
      productdata = product.data['products'];
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoad = false;
      notifyListeners();
    }
  }

  void onPressSingleProduct(BuildContext context, int id) async {
    try {
      isLoad = true;
      notifyListeners();
      final url = "${ApiUrl.PRODUCT_LIST}/$id";
      final response = await Dio().get(url);
      if (response.statusCode == 200) {
        _singleProductData = response.data;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SingleProductData()),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoad = false;
      notifyListeners();
    }
  }

  onPressAddProduct() async {
    print("onPress run...");
    try {
      final response = await dio.post(
        "${ApiUrl.PRODUCT_LIST}/add",
        data: {
          "title": "Hello world",
          "description": "THis is Hello world",
          "category": "hello",
        },
        options: Options(headers: {"Content-Type": "application/json"}),
      );
      print("Add Hello worldd>> $response");
      print("Add Hello worldd>> ${response.statusMessage}");
      print("Add Hello worldd>> ${response.statusCode}");
    } catch (e) {
      print(e);
    }
  }

  onPressUpdateProductInfo(int id) async {
    print("update run....");
    try {
      Response response = await dio.put(
        "${ApiUrl.PRODUCT_LIST}/$id",
        data: {
          "title": "New Product",
          "description": "This is New Product",
          "category": "New",
          "brand": "This is New brand",
        },
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      print("Update New Product>> $response");
      print("Update New Product>> ${response.statusMessage}");
      print("Update New Product>> ${response.statusCode}");
    } catch (e) {
      print("Upadte>>> ${e.toString()}");
    }
  }

  Future<void> onPressDeleteProduct(int id) async {
    try {
      Response response = await dio.delete("${ApiUrl.PRODUCT_LIST}/$id");
      print("delete product>> $response");
      print("delete product>> ${response.statusCode}");
      print("delete product>> ${response.statusMessage}");
    } catch (e) {
      print("Delete product>>> ${e.toString()}");
    }
  }

  Future<void> getCategoryList() async {
    isLoad = true;
    notifyListeners();
    try {
      Response response = await dio.get(
        "${ApiUrl.PRODUCT_LIST}/${EndPoint.CATEGORYLIST}",
      );
      print("CategoryList statuscode>>>> ${response.statusCode}");
      if (response.statusCode == 200) {
        _saveCategoryList = response.data;
      }
      print("save Category>>> $saveCategoryList");
      print("save Category length>>> ${saveCategoryList.length}");
    } catch (e) {
      print("CategoryLis>>> ${e.toString()}");
    } finally {
      isLoad = false;
      notifyListeners();
    }
  }

  Future<void> onPressCategoryProduct(String categoryname) async {
    try {
      Response response = await dio.get(
        "${ApiUrl.PRODUCT_LIST}/${EndPoint.CATEGORY}/$categoryname",
      );
      print("response data>> ${response.data['products']}");
      print("response data statuscode>> ${response.statusCode}");
      print("response data message>> ${response.statusMessage}");
    } catch (e) {
      print(e);
    }
  }

  void onPressShowList(bool isChnaged) {
    isShowList = isChnaged;
    notifyListeners();
  }
}
