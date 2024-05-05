import 'package:caffeinate/pages/home.dart';
import 'package:caffeinate/pages/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final _nameController = TextEditingController();
  final _imageController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _imageController,
              decoration: InputDecoration(labelText: 'Image'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: null,
            ),
            TextField(
              controller: _categoryController,
              decoration: InputDecoration(labelText: 'Category'),
            ),
            ElevatedButton(
              onPressed: () {
                final product = Product(
                  _nameController.text,
                  _imageController.text,
                  double.parse(_priceController.text),
                  _descriptionController.text,
                  _categoryController.text,
                );
                FirebaseFirestore.instance.collection('products').add({
                  'name': product.name,
                  'image': product.image,
                  'price': product.price,
                  'description': product.description,
                  'category': product.category,
                });
              },
              child: Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}
