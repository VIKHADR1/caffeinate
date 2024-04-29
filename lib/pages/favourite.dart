import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';
import 'menu_detail.dart'; // Import the MenuDetail page

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  User? _user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: const Text('My Favorite', style: TextStyle(color: Colors.brown)),
        centerTitle: true,
      ),
      body: _buildFavoriteList(),
    );
  }

  Widget _buildFavoriteList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(_user?.uid)
          .collection('fav')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        var favoriteProducts = snapshot.data!.docs;

        return ListView.builder(
          itemCount: favoriteProducts.length,
          itemBuilder: (context, index) {
            var product = favoriteProducts[index].data();
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MenuDetail(product: Product(
                      product['name'],
                      product['image'],
                      product['price'],
                      product['description'],
                      product['category']
                    )),
                  ),
                );
              },
              child: _buildProductItem(product as Map<String, dynamic>),
            );
          },
        );
      },
    );
  }

  Widget _buildProductItem(Map<String, dynamic> product) {
  return Card(
    elevation: 5,
    margin: const EdgeInsets.all(10),
    child: Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Maintain aspect ratio (preferred)
            AspectRatio(
              aspectRatio: 15 / 8, // Adjust for your image's aspect ratio
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  product['image'],
                  fit: BoxFit.cover, // Cover width while maintaining aspect ratio
                ),
              ),
            ),
            const SizedBox(height: 3),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                product['name'],
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                '\$${product['price']}',
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 5,
          right: 5,
          child: GestureDetector(
            onTap: () {
              // Delete the menu from Firestore collection
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(_user?.uid)
                  .collection('fav')
                  .doc(product['name']) // Assuming name is the unique identifier for the product
                  .delete();
            },
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 0, 0, 0),
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.all(4),
              child: Icon(Icons.close, color: Colors.white, size: 15),
            ),
          ),
        ),
      ],
    ),
  );
}
}