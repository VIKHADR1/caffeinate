import 'package:caffeinate/pages/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MenuDetail extends StatefulWidget {
  final Product product;

  const MenuDetail({Key? key, required this.product}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MenuDetailState createState() => _MenuDetailState();
}

class _MenuDetailState extends State<MenuDetail> {
  String _selectedSize = 'S';
  late double _basePrice;

  @override
  void initState() {
    super.initState();
    _basePrice = widget.product.price;
  }

  @override
  Widget build(BuildContext context) {
    double price = _basePrice;
    switch (_selectedSize) {
      case 'M':
        price = _basePrice + 2;
        break;
      case 'L':
        price = _basePrice + 3;
        break;
      default:
        price = _basePrice;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: 350,
              height: 300,
              child: Padding(
                padding: const EdgeInsets.only(top: 1),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40.0),
                  child: Image.asset(
                    widget.product.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.product.name,
                  style: const TextStyle(fontSize: 34),
                ),
              ],
            ),
            const Divider(),

            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 30.0, bottom: 10),
                  child: Text(
                    'Description',
                    style: TextStyle(fontSize: 28),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      widget.product.description,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 109, 105, 105)),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),

            const Divider(),

            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedSize = 'S';
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedSize == 'S'
                            ? Colors.brown
                            : Colors.grey[300],
                      ),
                      child: Text(
                        'S',
                        style: TextStyle(
                          fontSize: 16,
                          color: _selectedSize == 'S'
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedSize = 'M';
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedSize == 'M'
                            ? Colors.brown
                            : Colors.grey[300],
                      ),
                      child: Text(
                        'M',
                        style: TextStyle(
                          fontSize: 16,
                          color: _selectedSize == 'M'
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedSize = 'L';
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedSize == 'L'
                            ? Colors.brown
                            : Colors.grey[300],
                      ),
                      child: Text(
                        'L',
                        style: TextStyle(
                          fontSize: 16,
                          color: _selectedSize == 'L'
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Divider
            // Price and Buy Now button
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Price \$$price',
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final String name = widget.product.name;
                        final String size = _selectedSize;
                         double price = _basePrice;
                        switch (_selectedSize) {
                          case 'M':
                            price = _basePrice + 2;
                            break;
                          case 'L':
                            price = _basePrice + 3;
                            break;
                          default:
                            price = _basePrice;
                        }

                        final Map<String, dynamic> order = {
                          'name': name,
                          'size': size,
                          'price': price,
                        };

                        final firestore = FirebaseFirestore.instance;
                        await firestore.collection('orders').add(order);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Added to Cart!'),
                          ),
                        );
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.brown
                      ),
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
