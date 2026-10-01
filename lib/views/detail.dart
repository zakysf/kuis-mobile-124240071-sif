import 'package:flutter/material.dart';
import 'package:kuis/models/data.dart';

class DetailPage extends StatefulWidget {
  final Product product;

  const DetailPage({super.key, required this.product});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.productName),
        actions: [
          // FAVORITE di halaman detail
          IconButton(
            onPressed: () => setState(() => product.isFavorite = !product.isFavorite),
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, anim) =>
                  ScaleTransition(scale: anim, child: child),
              child: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
                key: ValueKey(product.isFavorite),
                color: product.isFavorite ? Colors.red : null,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              // HERO: tag HARUS sama persis dengan yang di home.dart
              child: Hero(
                tag: "product-${product.id}",
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(product.imageUrl),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(product.productName,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          Text(product.type,
              style: const TextStyle(fontSize: 15, color: Colors.grey)),
          const SizedBox(height: 20),
          Text(product.price,
              style: const TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          const Text("Deskripsi: ",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text(product.details),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}