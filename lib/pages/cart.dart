import 'package:caffeinate/pages/CheckoutPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({required Key key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  void updateQuantity(String documentId, int newQuantity) async {
    final firestore = FirebaseFirestore.instance;
    await firestore.collection('orders').doc(documentId).update({
      'quantity': newQuantity,
    });
  }

  void removeItem(String documentId) async {
    final firestore = FirebaseFirestore.instance;
    await firestore.collection('orders').doc(documentId).delete();
  }

  double calculateTotalPrice(List<QueryDocumentSnapshot> documents) {
    double totalPrice = 0.0;
    for (var document in documents) {
      final orderData = document.data() as Map<String, dynamic>;
      final price = orderData['price'].toDouble();
      final quantity = orderData['quantity'] ?? 1;
      totalPrice += price * quantity;
    }
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('orders').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final documents = snapshot.data!.docs;

          double totalPrice = calculateTotalPrice(documents);

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    final orderData = documents[index].data() as Map<String, dynamic>;
                    if (orderData != null &&
                        orderData['name'] != null &&
                        orderData['size'] != null &&
                        orderData['price'] != null) {
                      final name = orderData['name'];
                      final size = orderData['size'];
                      final price = orderData['price'].toDouble();
                      final documentId = documents[index].id;

                      return CartItem(
                        name: name,
                        size: size,
                        price: price,
                        quantity: orderData['quantity'] ?? 1,
                        onQuantityChange: (newQuantity) {
                          setState(() {
                            updateQuantity(documentId, newQuantity);
                          });
                        },
                        onRemove: () {
                          setState(() {
                            removeItem(documentId);
                          });
                        },
                        key: Key(documentId),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'Total Price: \$${totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Checkout(
                              items: documents.map((document) {
                                final orderData = document.data() as Map<String, dynamic>;
                                return {
                                  'name': orderData['name'],
                                  'size': orderData['size'],
                                  'price': orderData['price'].toDouble(),
                                  'quantity': orderData['quantity'] ?? 1,
                                  'totalPrice': orderData['price'].toDouble() * (orderData['quantity'] ?? 1)
                                };
                              }).toList(),
                              totalPrice: totalPrice,
                            ),
                          ),
                        );
                      },
                      child: Text('Check Out'),
                    ),
                    ),
                    
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  final String name;
  final String size;
  final double price;
  final int quantity;
  final Function(int) onQuantityChange;
  final VoidCallback onRemove;

  const CartItem({
    required Key key,
    required this.name,
    required this.size,
    required this.price,
    required this.quantity,
    required this.onQuantityChange,
    required this.onRemove,
  }) : super(key: key);

  double get qtotalPrice => price * quantity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Product: $name',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: onRemove,
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
              Text('Size: $size'),
              Text('Quantity: $quantity'),
              Text(
                'Total Price: \$${qtotalPrice.toStringAsFixed(2)}',
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => onQuantityChange(quantity + 1),
                    icon: const Icon(Icons.add),
                  ),
                  IconButton(
                    onPressed: () => onQuantityChange(quantity > 1 ? quantity - 1 : quantity),
                    icon: const Icon(Icons.remove),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
