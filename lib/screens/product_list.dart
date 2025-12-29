import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopverse/provider/counter_provider.dart';
import 'package:shopverse/widgets/productlist_card.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  bool isShowList = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<CounterProvider>(
      builder: (context, productlist, child) {
        return Scaffold(
          appBar: AppBar(title: Text("Product List")),
          body: Column(
            children: [
              Switch.adaptive(
                value: isShowList,
                onChanged: (value) {
                  print("click>>>> $value");
                  setState(() {
                    isShowList = !isShowList;
                  });
                },
              ),
              isShowList
                  ? Expanded(
                      child: productlist.isLoad == true
                          ? Center(child: CircularProgressIndicator.adaptive())
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
                                        errorBuilder: (context, error, stackTrace) {
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
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
              ElevatedButton(
                onPressed: () => productlist.getProductList(),
                child: Text("getProduct"),
              ),
            ],
          ),
        );
      },
    );
  }
}
