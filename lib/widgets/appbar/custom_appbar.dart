import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopverse/provider/product_data_provider.dart';
import 'package:shopverse/utils/app_text_style.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool? isCenter;
  final Color? backgroundColor;
  const CustomAppbar({
    required this.title,
    this.isCenter,
    this.backgroundColor,
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Consumer<ProductDataProvider>(
      builder: (context, productdata, _) {
        return AppBar(
          title: Text(title),
          centerTitle: isCenter,
          backgroundColor: backgroundColor ?? Colors.white,
          elevation: 0,
          titleTextStyle: appbarTitle(),
          actions: <Widget>[
            Switch.adaptive(
              value: productdata.isShowList,
              onChanged: (value) => productdata.onPressShowList(value),
            ),
          ],
        );
      },
    );
  }
}
