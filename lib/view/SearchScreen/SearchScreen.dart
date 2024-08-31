import 'package:flutter/material.dart';
import 'package:white_matrix/model/productmodel.dart';

void main() => runApp(const SearchBarApp());

class SearchBarApp extends StatefulWidget {
  const SearchBarApp({super.key});

  @override
  State<SearchBarApp> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
  bool isDark = false;

  final List<ProductModel> _products = List.generate(
    10,
    (index) => ProductModel(
      price: 0,
      title: 'Product $index',
      description: 'Description of Product $index',
      image: 'https://via.placeholder.com/150?text=Product+$index', 
      review: 'Review for Product $index',
      seller: 'Seller $index',
      originalPrice: 10.0 + index,
      rate: 4.0 + (index % 5) * 0.1,
      quantity: index + 1,
    ),
  );

  List<ProductModel> _filteredProducts = [];
  final TextEditingController _searchController = TextEditingController();

  void _filterProducts(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredProducts = _products;
      } else {
        _filteredProducts = _products
            .where((product) => product.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _filteredProducts = _products;
    _searchController.addListener(() {
      _filterProducts(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
    );

    return MaterialApp(
      theme: themeData,
      home: Scaffold(
        appBar: AppBar(title: const Text('Search Bar Sample')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: Icon(isDark
                        ? Icons.wb_sunny_outlined
                        : Icons.brightness_2_outlined),
                    onPressed: () {
                      setState(() {
                        isDark = !isDark;
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                child: _filteredProducts.isNotEmpty
                    ? ListView.builder(
                        itemCount: _filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = _filteredProducts[index];
                          return ListTile(
                            leading: Image.network(
                              product.image,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.error); 
                              },
                            ),
                            title: Text(product.title),
                          );
                        },
                      )
                    : const Center(child: Text('No suggestions found.')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
