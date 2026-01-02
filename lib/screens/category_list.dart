import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopverse/provider/product_data_provider.dart';
import 'package:shopverse/widgets/appbar/custom_appbar.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductDataProvider>().getCategoryList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductDataProvider>(
      builder: (context, categoryListProvider, _) {
        return Scaffold(
          appBar: CustomAppbar(title: "Product Category List"),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsetsGeometry.all(5),
              child: Column(
                children: [
                  Expanded(
                    child: categoryListProvider.isLoad == true
                        ? Center(child: CircularProgressIndicator.adaptive())
                        : ListView.builder(
                          semanticChildCount: 5,
                            itemCount:
                                categoryListProvider.saveCategoryList.length,
                            itemBuilder: (context, index) {
                              String categoryname =
                                  categoryListProvider.saveCategoryList[index];
                              return ElevatedButton(
                                onPressed: () => categoryListProvider
                                    .onPressCategoryProduct(categoryname),
                                child: Text(categoryname),
                              );
                            },
                          ),
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
