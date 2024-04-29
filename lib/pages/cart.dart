import 'package:caffeinate/pages/CheckoutPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  late User _user;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Cart',
          style: TextStyle(color: Colors.brown),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(_user.uid)
            .collection('orders')
            .snapshots(),
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
                    final orderData =
                        documents[index].data() as Map<String, dynamic>;
                    if (orderData['name'] != null &&
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
                      width: 300,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Checkout(
                                items: documents.map((document) {
                                  final orderData =
                                      document.data() as Map<String, dynamic>;
                                  return {
                                    'name': orderData['name'],
                                    'size': orderData['size'],
                                    'price': orderData['price'].toDouble(),
                                    'quantity': orderData['quantity'] ?? 1,
                                    'totalPrice': orderData['price']
                                            .toDouble() *
                                        (orderData['quantity'] ?? 1)
                                  };
                                }).toList(),
                                totalPrice: totalPrice,
                              ),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.brown),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        child: const Text('Check Out'),
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

  void updateQuantity(String documentId, int newQuantity) async {
    final firestore = FirebaseFirestore.instance;
    await firestore
        .collection('users')
        .doc(_user.uid)
        .collection('orders')
        .doc(documentId)
        .update({
      'quantity': newQuantity,
    });
  }

   void removeItem(String documentId) async {
    final firestore = FirebaseFirestore.instance;
    await firestore.collection('users').doc(_user.uid).collection('orders').doc(documentId).delete();
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

  double get totalPrice => price * quantity;

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
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  IconButton(
                    onPressed: onRemove,
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              Text('Size: $size'),
              const SizedBox(height: 10),
              Text('Price: \$${price.toStringAsFixed(2)}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Price: \$${totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => onQuantityChange(quantity + 1),
                          icon: const Icon(Icons.add),
                        ),
                        Text('$quantity'),
                        IconButton(
                          onPressed: () => onQuantityChange(
                              quantity > 1 ? quantity - 1 : quantity),
                          icon: const Icon(Icons.remove),
                        ),
                      ],
                    ),
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
