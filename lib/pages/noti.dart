import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Noti extends StatefulWidget {
  const Noti({Key? key, required List<Map<String, dynamic>> items})
      : super(key: key);

  @override
  State<Noti> createState() => _NotiState();
}

class _NotiState extends State<Noti> {
  late final Stream<QuerySnapshot> _historyStream;
  late User _user;
  late Map<String, bool> _orderReceivedMap = {}; // Map to track order received state

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser!;
    // Reference to the user's history collection
    CollectionReference historyCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(_user.uid)
        .collection('history');

    _historyStream = historyCollection.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History', style: TextStyle(color: Colors.brown)),
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
              final documentId = documents[index].id;

              return OrderHistoryItem(
                name: orderData['name'],
                size: orderData['size'],
                price: orderData['price'].toDouble(),
                quantity: orderData['quantity'] ?? 1,
                totalPrice: orderData['price'].toDouble() * (orderData['quantity'] ?? 1),
                documentId: documentId,
                isOrderReceived: _orderReceivedMap[documentId] ?? false,
                onOrderReceived: () {
                  removeItem(documentId);
                  setState(() {
                    _orderReceivedMap[documentId] = true;
                  });
                },
              );
            },
          );
        },
      ),
    );
  }

  void removeItem(String documentId) async {
    final firestore = FirebaseFirestore.instance;
    await firestore.collection('users').doc(_user.uid).collection('history').doc(documentId).delete();
  }
}
class OrderHistoryItem extends StatefulWidget {
  final String name;
  final String size;
  final double price;
  final int quantity;
  final double totalPrice;
  final String documentId;
  final bool isOrderReceived;
  final VoidCallback onOrderReceived;

  const OrderHistoryItem({
    Key? key,
    required this.name,
    required this.size,
    required this.price,
    required this.quantity,
    required this.totalPrice,
    required this.documentId,
    required this.isOrderReceived,
    required this.onOrderReceived,
  }) : super(key: key);

  @override
  _OrderHistoryItemState createState() => _OrderHistoryItemState();
}

class _OrderHistoryItemState extends State<OrderHistoryItem> {
  late bool _isDeleted = false;

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
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () {
                    if (_isDeleted) {
                      // Delete the item
                      widget.onOrderReceived();
                    } else {
                      // Change button text to "Delete"
                      setState(() {
                        _isDeleted = true;
                      });
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      _isDeleted ? Colors.red : Colors.brown,
                    ),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: Text(_isDeleted ? 'Delete' : 'Order Received'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
