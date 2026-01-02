import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopverse/provider/product_data_provider.dart';
import 'package:shopverse/screens/category_list.dart';
import 'package:shopverse/screens/productList/product_gridview.dart';
import 'package:shopverse/screens/productList/product_listview.dart';
import 'package:shopverse/widgets/appbar/custom_appbar.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ProductDataProvider>().getProductList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductDataProvider>(
      builder: (context, productlist, child) {
        return Scaffold(
          appBar: CustomAppbar(
            title: "ProductList",
            backgroundColor: Colors.white,
          ),
          body: SafeArea(
            child: Column(
              children: [
                productlist.isShowList
                    ? Expanded(
                        child: productlist.isLoad == true
                            ? Center(
                                child: CircularProgressIndicator.adaptive(),
                              )
                            : ProductListview(productDataProvider: productlist),
                      )
                    : ProductGridview(productDataProvider: productlist),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => CategoryList(),
                      ),
                    );
                  },
                  child: Text("Category list"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
