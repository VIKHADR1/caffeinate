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
        title: Text('Checking Out', style: TextStyle(color: Colors.brown),),
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
                  onPressed: () {
                    // logic to confirm payment
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.brown),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: Text('Confirm Payment'),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),

        ],
      ),
    );
  }
}
