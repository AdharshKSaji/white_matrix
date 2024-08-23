import 'package:flutter/material.dart';

void main() => runApp(const SearchBarApp());

class SearchBarApp extends StatefulWidget {
  const SearchBarApp({super.key});

  @override
  State<SearchBarApp> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
  bool isDark = false;
  final List<String> _products = List.generate(
    10,
    (index) => 'Product $index',
  );
  List<String> _filteredProducts = [];
  final TextEditingController _searchController = TextEditingController();

  void _filterProducts(String query) {
    setState(() {
      _filteredProducts = _products
          .where((product) => product.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
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
        brightness: isDark ? Brightness.dark : Brightness.light);

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
                    icon: Icon(isDark ? Icons.wb_sunny_outlined : Icons.brightness_2_outlined),
                    onPressed: () {
                      setState(() {
                        isDark = !isDark;
                      });
                    },
                  ),
                ),
                onChanged: (query) {
                  _filterProducts(query);
                },
              ),
              Expanded(
                child: _filteredProducts.isNotEmpty
                    ? ListView(
                        children: _filteredProducts.map((product) {
                          return ListTile(
                            title: Text(product),
                            onTap: () {
                              
                            },
                          );
                        }).toList(),
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
