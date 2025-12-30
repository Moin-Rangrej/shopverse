import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shopverse/provider/product_data_provider.dart';
import 'package:shopverse/utils/api_url.dart';
import 'package:shopverse/widgets/productlist_card.dart';

class ProductGridview extends StatelessWidget {
  final ProductDataProvider productDataProvider;
  const ProductGridview({required this.productDataProvider, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
          crossAxisSpacing: 10,
          // mainAxisExtent: 50,
          childAspectRatio: 0.9,
        ),
        itemCount: productDataProvider.productdata.length,
        itemBuilder: (context, index) {
          final item = productDataProvider.productdata[index];
          return GestureDetector(
            onTap: () =>
                productDataProvider.onPressSingleProduct(context, item['id']),
            child: ProductlistCard(
              thumbnail: item['thumbnail'],
              title: item['title'],
              // discription: item['description'],
            ),
          );
        },
      ),
    );
  }
}
