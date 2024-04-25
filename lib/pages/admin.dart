import 'dart:io';
import 'package:caffeinate/pages/home.dart';
import 'package:caffeinate/pages/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();
  XFile? _imageFile;
  bool _isLoading = false;

  Future<void> _pickImage(ImageSource source) async {
    setState(() {
      _isLoading = true;
    });
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _imageFile == null
                  ? ElevatedButton(
                      onPressed: () {
                        _pickImage(ImageSource.gallery);
                      },
                      child: const Text('Pick Image from Gallery'))
                  : _isLoading
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          height: 200, // give a fixed height
                          width: double.infinity, // take up the full width
                          child: Image.file(
                            File(_imageFile!.path),
                            fit: BoxFit.cover,
                          ),
                        ),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: null,
              ),
              TextField(
                controller: _categoryController,
                decoration: const InputDecoration(labelText: 'Category'),
              ),
              ElevatedButton(
                onPressed: _imageFile != null && !_isLoading
                    ? () {
                        final product = Product(
                          _nameController.text,
                          _imageFile!.path,
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
                        }).then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Product added')),
                          );
                          _clearForm();
                        }).catchError((error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Failed to add product')),
                          );
                        });
                      }
                    : null,
                child: const Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _clearForm() {
    _nameController.clear();
    _priceController.clear();
    _descriptionController.clear();
    _categoryController.clear();
    setState(() {
      _imageFile = null;
    });
  }
}
