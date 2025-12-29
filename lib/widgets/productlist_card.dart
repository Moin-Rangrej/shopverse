import 'package:flutter/material.dart';

class ProductlistCard extends StatelessWidget {
  final String title;
  final String? discription;
  final String thumbnail;
  const ProductlistCard({
    required this.title,
    this.discription,
    required this.thumbnail,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: [
        Image.network(thumbnail, width: 100, height: 100),
        Text("Title: $title"), 
        if (discription != null && discription!.isNotEmpty) Text("Discription: $discription"),
      ]),
    );
  }
}
