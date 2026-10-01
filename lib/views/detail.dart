import 'package:flutter/material.dart';
import 'package:kuis/models/data.dart';

class DetailPage extends StatefulWidget {
  final Product product;

  DetailPage({super.key, required this.product});

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
          IconButton(
            onPressed: () =>
                setState(() => product.isFavorite = !product.isFavorite),
            icon: AnimatedSwitcher(
              duration: Duration(milliseconds: 250),
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
            padding: EdgeInsets.all(15.0),
            child: Center(
              child: Hero(
                tag: "product-${product.id}",
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(product.imageUrl),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            product.productName,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Text(
            product.type,
            style: TextStyle(fontSize: 15, color: Colors.grey),
          ),
          SizedBox(height: 20),
          Text(
            product.price,
            style: TextStyle(
              color: Colors.green,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Jumlah Produk: ",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Icon(Icons.inventory_2_outlined, size: 14),
              SizedBox(width: 4),
              Text('${product.stock} stok'),
              SizedBox(width: 12),
              Icon(Icons.favorite, size: 14, color: Colors.red),
              SizedBox(width: 4),
              Text(product.likeCount.toString()),
            ],
          ),

          // Text("Disukai: ${product.likeCount}",
          //     style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          // SizedBox(height: 10),
          // Text("Stok: ${product.stock}",
          //     style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          Text(
            product.sizes.isNotEmpty
                ? "Ukuran: ${product.sizes}"
                : "Ukuran: Tidak tersedia",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            "Deskripsi: ",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(product.details),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
