import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Noti extends StatefulWidget {

  const Noti({Key? key, required List<Map<String, dynamic>> items})
      : super(key: key);

  const Noti({Key? key}) : super(key: key);


  @override
  _NotiState createState() => _NotiState();
}


class _NotiState extends State<Noti> {
  late final Stream<QuerySnapshot> _historyStream;
  late User _user;

class _NotiState extends State<Noti> with SingleTickerProviderStateMixin {
  List<bool> showSizedBoxes = [];


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
              bool isOrderReceived = false; // Track button state

              return OrderHistoryItem(
                name: orderData['name'],
                size: orderData['size'],
                price: orderData['price'].toDouble(),
                quantity: orderData['quantity'] ?? 1,
                totalPrice: orderData['price'].toDouble() * (orderData['quantity'] ?? 1),
                documentId: documents[index].id,
                isOrderReceived: isOrderReceived,
                onOrderReceived: () {
                  removeItem(documents[index].id);
                  setState(() {
                    isOrderReceived = true;
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
  late bool _isOrderReceived;

  @override
  void initState() {
    _isOrderReceived = widget.isOrderReceived;
    super.initState();
  }

  void _handleOrderReceiveDelete() {
    if (_isOrderReceived) {
      // Delete order item from orders collection
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('orders')
          .doc(widget.documentId)
          .delete();
    } else {
      // Delete order item from history collection
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('history')
          .doc(widget.documentId)
          .delete();
    }
=======
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3), // Adjust the duration as needed
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();

  }

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
                    widget.onOrderReceived();
                    setState(() {
                      _isOrderReceived = true;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(_isOrderReceived ? Colors.red : Colors.blue),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: Text(_isOrderReceived ? 'Delete' : 'Order Received'),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              for (int i = 0; i < showSizedBoxes.length; i++)
                if (showSizedBoxes[i])
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: SizedBox(
                      height: 85,
                      width: 350,
                      child: Stack(
                        children: [
                          Container(
                            height: double.infinity,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFFC67C4E),
                              borderRadius: BorderRadius.circular(30.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 7,
                                  blurRadius: 7,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Your order will arrive in 5 minutes',
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 50),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              AnimatedBuilder(
                                animation: _controller,
                                builder: (context, child) {
                                  return ClipRect(
                                    child: Align(
                                      alignment: Alignment.center,
                                      widthFactor: _controller.value,
                                      child: Container(
                                        height: 6,
                                        width: 350,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _addSizedBox();
                  _controller.reset();
                  _controller
                      .forward(); // Start the animation from the beginning
                },
                child: Text('Order confirmed'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  

  void _addSizedBox() {
    setState(() {
      showSizedBoxes.add(true);
    });

  }
}
