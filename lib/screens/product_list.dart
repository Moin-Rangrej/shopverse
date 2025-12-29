import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopverse/provider/product_data_provider.dart';
import 'package:shopverse/widgets/appbar/custom_appbar.dart';
import 'package:shopverse/widgets/productlist_card.dart';

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
                            : ListView.builder(
                                itemCount: productlist.productdata.length,
                                itemBuilder: (context, index) {
                                  final item = productlist.productdata[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          "${item['reviews']}",
                                          style: TextStyle(
                                            fontSize: 18,
                                            // color: Colors.blue,
                                            fontFamily: "opensans",
                                          ),
                                        ),
                                        Image.network(
                                          item['thumbnail'],
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                          filterQuality: FilterQuality.high,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                                return Container(
                                                  // width: 200,
                                                  height: 200,
                                                  color: Colors.grey,
                                                  child: const Icon(
                                                    Icons
                                                        .image_not_supported_outlined,
                                                  ),
                                                );
                                              },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                      )
                    : Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                // mainAxisExtent: 50,
                                childAspectRatio: 0.75,
                              ),
                          itemCount: productlist.productdata.length,
                          itemBuilder: (context, index) {
                            final item = productlist.productdata[index];
                            return ProductlistCard(
                              thumbnail: item['thumbnail'],
                              title: item['title'],
                            );
                          },
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
