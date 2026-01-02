import 'package:flutter/material.dart';

class ProductlistCard extends StatelessWidget {
  final String title;
  final String? discription;
  final String thumbnail;
  final int? index;
  const ProductlistCard({
    required this.title,
    this.discription,
    required this.thumbnail,
    this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(index.toString()),
          Image.network(thumbnail, width: 100, height: 100),
          Text("Title: $title"),
          if (discription != null && discription!.isNotEmpty)
            Text("Discription: $discription"),
        ],
      ),
    );
  }
}
