import 'package:caffeinate/pages/bottomnav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Total Price: \$${totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 300,
                height: 45,
                child: ElevatedButton(
                  onPressed: () async {
                    print('Place Order button pressed');
                    try {
                      // Move data to history and delete from orders
                      await moveDataToHistoryAndDeleteFromOrders(items);
                      print('Data moved to history and deleted from orders');
                      
                      // Navigate to notification page
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const BottomNav(),
                        
                        ),
                      );
                    } catch (error) {
                      print('Error placing order: $error');
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.brown),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: const Text('Place Order'),
                ),

              ),
              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
Future<void> moveDataToHistoryAndDeleteFromOrders(List<Map<String, dynamic>> orderItems) async {
  final firestore = FirebaseFirestore.instance;
  final batch = firestore.batch();
 final _user = FirebaseAuth.instance.currentUser;
  // Reference to history collection
  final historyCollection =
       
        firestore.collection('users').doc(_user?.uid).collection('history');
    final ordersCollection =
        firestore.collection('users').doc(_user?.uid).collection('orders');


  for (final item in orderItems) {
      // Create a new document in history with the same data
      final historyDocRef = historyCollection.doc();
      batch.set(historyDocRef, item);

      // Get reference to the order document (assuming document ID is available in the item)
      final orderDocRef = ordersCollection.doc(item['documentId']);
      batch.delete(orderDocRef);
    }
  // Commit the batch operation
  await batch.commit();

  // Now, delete the 'orders' collection
  await deleteCollection(ordersCollection);
}

// Function to delete a collection
Future<void> deleteCollection(CollectionReference collectionReference) async {
  const batchSize = 50;
  var query = collectionReference.orderBy(FieldPath.documentId).limit(batchSize);

  return await query.get().then((querySnapshot) async {
    if (querySnapshot.size == 0) return; // No documents, collection is empty

    final batch = collectionReference.firestore.batch();
    querySnapshot.docs.forEach((doc) {
      batch.delete(doc.reference);
    });

    await batch.commit();

    // Recursively call deleteCollection on the next batch
    await deleteCollection(collectionReference);
  });
}
}
