import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopverse/provider/product_data_provider.dart';
import 'package:shopverse/widgets/appbar/custom_appbar.dart';

class SingleProductData extends StatefulWidget {
  const SingleProductData({super.key});

  @override
  State<SingleProductData> createState() => _SingleProductDataState();
}

class _SingleProductDataState extends State<SingleProductData> {
  int setScrollImage = 0;
  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentPage = ValueNotifier<int>(0);

  @override
  void dispose() {
    _currentPage.dispose();
    super.dispose();
  }


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
                      controller: _pageController,
                      physics: const BouncingScrollPhysics(),
                      itemCount: product['images'].length,
                      onPageChanged: (index) => _currentPage.value = index,
                      itemBuilder: (context, index) {
                        return Center(
                          child: Image.network(
                            product['images'][index],
                            height: 150,
                            width: 150,
                            fit: BoxFit.contain,
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) return child;
                              return const Center(
                                child: CircularProgressIndicator.adaptive(),
                              );
                            },
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.broken_image, size: 40),
                          ),
                        );
                      },
                    ),
                  ),
                  
                  SizedBox(
                    height: 20,
                    child: ValueListenableBuilder<int>(
                      valueListenable: _currentPage,
                      builder: (context, current, _) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            product['images'].length,
                            (index) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              height: 8,
                              width: current == index ? 16 : 8,
                              decoration: BoxDecoration(
                                color: current == index
                                    ? Colors.yellowAccent
                                    : Colors.red,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
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
