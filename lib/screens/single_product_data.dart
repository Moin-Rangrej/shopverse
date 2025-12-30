import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopverse/provider/product_data_provider.dart';
import 'package:shopverse/widgets/appbar/custom_appbar.dart';

class SingleProductData extends StatelessWidget {
  const SingleProductData({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductDataProvider>(
      builder: (context, provider, _) {
        final product = provider.singleProductData;

        if (provider.isLoad) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (product == null) {
          return const Scaffold(
            body: Center(child: Text("No product data found")),
          );
        }

        return Scaffold(
          appBar: CustomAppbar(title: product['title']),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 200,
                    child: PageView.builder(
                      itemCount: product['images'].length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Image.network(
                              height: 150,
                              width: 150,
                              product['images'][index],
                              fit: BoxFit
                                  .contain, // Ensures the image fills the entire viewport
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value:
                                            loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                            ),
                            Text("${index + 1}"),
                          ],
                        );
                      },
                    ),
                  ),
                  Row(
                    children: product['images']
                        .map<Widget>(
                          (value) => Padding(
                            padding: EdgeInsetsGeometry.all(5),
                            child: Container(
                              height: 10,
                              width: 10,
                              color: Colors.red,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  Text(
                    product['title'],
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    product['description'],
                    style: const TextStyle(fontSize: 14),
                  ),

                  const SizedBox(height: 12),

                  Text("Category: ${product['category']}"),
                  Text("Brand: ${product['brand']}"),
                  Text("Price: ₹${product['price']}"),
                  Text("Rating: ⭐ ${product['rating']}"),

                  const SizedBox(height: 16),

                  Text(
                    "Stock: ${product['stock']} | ${product['availabilityStatus']}",
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        provider.onPressUpdateProductInfo(product['id']),
                    child: Text("Update Product"),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        provider.onPressDeleteProduct(product['id']),
                    child: Text("Delete Product"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
