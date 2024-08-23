import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:white_matrix/controller/favcontroller.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteController>(context);
    final favorites = favoriteProvider.favorites;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: favorites.isEmpty
          ? Center(child: Text('No favorites added yet.'))
          : Container(
            child: ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final product = favorites[index];
                  return ListTile(
                    leading: Image.network(product.image, width: 50, height: 50, fit: BoxFit.cover),
                    title: Text(product.title),
                    subtitle: Text('₹${product.price}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        
                        favoriteProvider.toggleFavorite(product);
                      },
                    ),
                    onTap: () {
                    
                    },
                  );
                },
              ),
          ),
    );
  }
}
