import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Noti extends StatefulWidget {
  const Noti ({Key? key, required List<Map<String, dynamic>> items}) : super(key: key);

  @override
  State<Noti> createState() => _NotiState();
}

class _NotiState extends State<Noti> {
  late final Stream<QuerySnapshot> _historyStream;

  @override
  void initState() {
    super.initState();
    // Get the user's UID
    String uid = FirebaseAuth.instance.currentUser!.uid;
    // Reference to the user's history collection
    CollectionReference historyCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('history');
    // Stream of snapshots from the user's history collection
    _historyStream = historyCollection.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History', style: TextStyle(color: Colors.brown),),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _historyStream,
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

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final orderData = documents[index].data() as Map<String, dynamic>;
              return OrderHistoryItem(
                name: orderData['name'],
                size: orderData['size'],
                price: orderData['price'].toDouble(),
                quantity: orderData['quantity'] ?? 1,
                totalPrice: orderData['price'].toDouble() * (orderData['quantity'] ?? 1),
              );
            },
          );
        },
      ),
    );
  }
}
class OrderHistoryItem extends StatefulWidget {
  final String name;
  final String size;
  final double price;
  final int quantity;
  final double totalPrice;

  const OrderHistoryItem({
    Key? key,
    required this.name,
    required this.size,
    required this.price,
    required this.quantity,
    required this.totalPrice,
  }) : super(key: key);

  @override
  _OrderHistoryItemState createState() => _OrderHistoryItemState();
}

class _OrderHistoryItemState extends State<OrderHistoryItem> {
  bool _orderReceived = false;

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
              Text(
                widget.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text('Size:    ${widget.size}'),
              const SizedBox(height: 10),
              Text('Price:  \$${widget.price.toStringAsFixed(2)}'),
              Text('Qty:     ${widget.quantity}'),
              const Divider(),
              Text(
                'Total Price: \$${widget.totalPrice.toStringAsFixed(2)}',
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              // Align the button to the right bottom
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _orderReceived = !_orderReceived;
                    });
                    // Add functionality for Order Received button here
                    // For example, you can update the order status in the database
                    // or perform any other action as needed
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: Text(_orderReceived ? 'Delete Order History' : 'Order Received'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}