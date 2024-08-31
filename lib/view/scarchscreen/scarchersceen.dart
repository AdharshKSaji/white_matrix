
import 'package:flutter/material.dart';
import 'package:scratcher/scratcher.dart';
import 'package:provider/provider.dart';
import 'package:white_matrix/controller/ScarchController.dart';
import 'package:white_matrix/view/cartscreen/CartScreen.dart';
import 'package:white_matrix/view/homescreen/homescreen.dart';

class ScratchScreen extends StatefulWidget {
  const ScratchScreen({super.key});

  @override
  State<ScratchScreen> createState() => _ScratchScreenState();
}

class _ScratchScreenState extends State<ScratchScreen> {
  late ScratchController scratchController;

  @override
  void initState() {
    super.initState();
    scratchController = ScratchController();
    scratchController.fetchRandomProduct();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ScratchController>(
      create: (_) => scratchController,
      child: Consumer<ScratchController>(
        builder: (context, controller, child) {
          if (controller.selectedProduct == null) {
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 350.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Scratcher(
                          brushSize: 50,
                          threshold: 50,
                          color: Colors.blueGrey,
                          onChange: (value) {
                            print("Scratch progress: $value%");
                          },
                          onThreshold: () {
                            controller.addProductToCart(context);
                          },
                          child: Material(
                            elevation: 5,
                            child: Container(
                              alignment: Alignment.center,
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    controller.selectedProduct!.title,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 10),
                                  Image.network(
                                    controller.selectedProduct!.image,
                                    height: 150,
                                    width: 300,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "Offer Price Rs 0 Only",
                                    style: TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                             context.read<ScratchController>().addProductToCart(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>  CartScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                            ),
                            child: const Text(
                              'Add to Cart',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                            ),
                            child: const Text(
                              'Skip',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
