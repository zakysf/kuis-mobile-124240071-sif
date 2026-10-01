import 'package:flutter/material.dart';
import 'package:kuis/views/detail.dart';

import '../models/data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();
  String query = "";
  String selectedtype = "Semua";

  //Filter
  List<String> get categories =>
      ["Semua", "Favorit", ...catalog.map((p) => p.type).toSet()];

  List<Product> get filteredproducts {
    return catalog.where((p) {
      final matchSearch =
          p.productName.toLowerCase().contains(query.toLowerCase());

      final matchtype = selectedtype == "Semua" ||
          (selectedtype == "Favorit" && p.isFavorite) ||
          p.type == selectedtype;

      return matchSearch && matchtype;
    }).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = filteredproducts;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: TextField(
            controller: searchController,
            onChanged: (value) => setState(() => query = value),
            decoration: InputDecoration(
              hintText: "Cari product...",
              prefixIcon: const Icon(Icons.search),
              suffixIcon: query.isEmpty
                  ? null
                  : IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        searchController.clear();
                        setState(() => query = "");
                      },
                    ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),

        SizedBox(
          height: 48,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: categories.length,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, i) {
              final cat = categories[i];
              return ChoiceChip(
                label: Text(cat),
                selected: selectedtype == cat,
                onSelected: (_) => setState(() => selectedtype = cat),
              );
            },
          ),
        ),

        //LIST product
        Expanded(
          child: items.isEmpty
              ? const Center(child: Text("product tidak ditemukan"))
              : ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final product = items[index];

                    return TweenAnimationBuilder<double>(
                      key: ValueKey(product.id),
                      tween: Tween(begin: 0, end: 1),
                      duration: Duration(
                        milliseconds: 300 + (index.clamp(0, 6) * 60),
                      ),
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: Transform.translate(
                            offset: Offset(0, 20 * (1 - value)),
                            child: child,
                          ),
                        );
                      },
                      child: ListTile(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(product: product),
                            ),
                          );

                          setState(() {});
                        },
                        title: Text(product.productName),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(product.price),
                            const SizedBox(height: 4),
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
                          ],
                        ),

                        leading: Hero(
                          tag: "product-${product.id}",
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              product.imageUrl,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),

                        ),

                        // FAVORITE + ANIMASI 3: ikon berubah dengan scale
                        trailing: IconButton(
                          onPressed: () {
                            setState(() => product.isFavorite = !product.isFavorite);
                          },
                          icon: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 250),
                            transitionBuilder: (child, anim) =>
                                ScaleTransition(scale: anim, child: child),
                            child: Icon(
                              product.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              key: ValueKey(product.isFavorite),
                              color: product.isFavorite ? Colors.red : null,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}