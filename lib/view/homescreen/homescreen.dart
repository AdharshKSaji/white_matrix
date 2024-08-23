import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:white_matrix/model/productmodel.dart';
import 'package:white_matrix/view/favouritescreen/favoritescreen.dart';
import 'package:white_matrix/view/homescreen/widgets/productcard.dart';
import 'package:white_matrix/view/profilescreen/profilescreen.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> carouselImages = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKgpBrfaI1fBGhXmg3GiFP46-thNGtMKaike47E5OjEidvLsoGAP4tYXVXtmONsuHpzHY&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkbAC4rZPETvV0hkBJQ0v2ygj1HphI3xv0GLXQ-BcPnOMxv8mRP3MYayjWbWs4sLK2Hok&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQvVfsF70vpPjcX4ZfEb8iQUqtuxxoRYvUkW1h2oc-A4MJ9BFzx2Cn0zxc3Sb19YlL8npw&usqp=CAU',
  ];

  var collectionRef = FirebaseFirestore.instance.collection("products");



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.lightBlueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
              icon: Icon(
                size: 38,
                Icons.account_circle,
                color: Colors.white,
              ),
            ),
            title: Text(
              "Online Shoppy",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchBar()));
                },
                icon: Icon(
                  size: 38,
                  Icons.search,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: collectionRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: const Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 200,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      viewportFraction: 1.0,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: true,
                      autoPlayInterval: Duration(seconds: 5),
                    ),
                    items: carouselImages.map((imageUrl) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Stack(
                                children: [
                                  Image.network(
                                    imageUrl,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress.expectedTotalBytes != null
                                                ? loadingProgress.cumulativeBytesLoaded /
                                                    (loadingProgress.expectedTotalBytes ?? 1)
                                                : null,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [Colors.black54, Colors.transparent],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Products",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        "See all",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  GridView.builder(
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: snapshot.data?.docs.length ?? 0,
                    itemBuilder: (context, index) {
                      var map = snapshot.data!.docs[index];
                      return ProductCard(
                        product: ProductModel.fromMap(map.data()),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar:BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: IconButton(onPressed: () {
          
        }, icon: Icon(Icons.home,color: Colors.black)),label: ""),
         BottomNavigationBarItem(icon: IconButton(onPressed: () {
          
        }, icon: Icon(Icons.search,color: Colors.black,)),label: ""),
         BottomNavigationBarItem(icon: IconButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => FavoriteScreen(),));
          
        }, icon: Icon(Icons.favorite,color: Colors.black)),label: ""),
         BottomNavigationBarItem(icon: IconButton(onPressed: () {
          
        }, icon: Icon(Icons.shopping_cart,color: Colors.black)),label: ""),
        
        
      ])
    );
  }
}
