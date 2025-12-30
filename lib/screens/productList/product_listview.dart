import 'package:flutter/material.dart';
import 'package:shopverse/provider/product_data_provider.dart';

class ProductListview extends StatelessWidget {
  final ProductDataProvider productDataProvider;
  const ProductListview({required this.productDataProvider, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: productDataProvider.productdata.length,
      itemBuilder: (context, index) {
        final item = productDataProvider.productdata[index];
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
                    child: const Icon(Icons.image_not_supported_outlined),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
