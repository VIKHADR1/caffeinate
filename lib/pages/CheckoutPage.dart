
import 'package:caffeinate/pages/noti.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Checkout extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final double totalPrice;

  const Checkout({Key? key, required this.items, required this.totalPrice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checking Out', style: TextStyle(color: Colors.brown),),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Order Summary',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  title: Text(item['name']),
                  subtitle: Text('Size: ${item['size']} - Quantity: ${item['quantity']}'),
                  trailing: Text('\$${(item['price'] * item['quantity']).toStringAsFixed(2)}'),
                );
              },
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Divider(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Total Price: \$${totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 300,
                height: 45,
                child: ElevatedButton(
                  onPressed: () async {
                    // Move data to history and delete from orders
                    await moveDataToHistoryAndDeleteFromOrders(items);

                    // Navigate to notification page (assuming no further actions needed)
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Noti(items: items),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.brown),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: const Text('Place Order'),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> moveDataToHistoryAndDeleteFromOrders(List<Map<String, dynamic>> orderItems) async {
    final firestore = FirebaseFirestore.instance;
    final batch = firestore.batch();

    // Reference to history collection
    final historyCollection = firestore.collection('history');

    for (final item in orderItems) {
      // Create a new document in history with the same data
      final historyDocRef = historyCollection.doc();
      batch.set(historyDocRef, item);

      // Get reference to the order document (assuming document ID is available in the item)
      final orderDocRef = firestore.collection('orders').doc(item['documentId']); // Modify based on your data structure
      batch.delete(orderDocRef);
    }

    // Commit the batch operation
    await batch.commit();
  }
}