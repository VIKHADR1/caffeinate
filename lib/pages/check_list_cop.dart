import 'package:caffeinate/order_page.dart';
import 'package:flutter/material.dart';

class CheckListCop extends StatefulWidget {
  const CheckListCop({super.key});

  @override
  State<CheckListCop> createState() => _CheckListCopState();
}

class _CheckListCopState extends State<CheckListCop> {
  String deliveryOption = 'Deliver';
  String paymentOption = 'COD';

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(  
      appBar: AppBar(
        
        title: const Text('Checkout'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Delivery ',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Text(deliveryOption),
                  const Spacer(),
                  Radio(
                    value: 'Deliver',
                    groupValue: deliveryOption,
                    onChanged: (String? value) {
                      setState(() => deliveryOption = value!);
                    },
                  ),
                  const Text('Deliver'),
                  Radio(
                    value: 'Pick Up',
                    groupValue: deliveryOption,
                    onChanged: (String? value) {
                      setState(() => deliveryOption = value!);
                    },
                  ),
                  const Text('Pick Up'),
                ],
              ),
            ),*/
            
             Container(
               margin: const EdgeInsets.symmetric(horizontal: 36.0),
            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
            decoration: BoxDecoration(
              color: Colors.white30,
              borderRadius: BorderRadius.circular(10.0),
            ),
               child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20), // half of width and height to make it a circle
                      border: Border.all(
                        color: Color.fromARGB(0, 0, 0, 0),
                        width: 1, // Adjust border width as needed
                      ),
                    ),
                    child: Image.asset(
                      'images/Cappucino.jpg', // Path to your image
                      width: 60,
                      height: 60,
                      fit: BoxFit
                          .cover, // Adjust how the image fits within the container
                    ),
                  ),
                  const SizedBox(
                      width: 5), // Add some space between the image and text
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: const Text(
                      'Cappucino',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  // Add some space between the name and quantity
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Container(
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              // Handle decrement logic
                            },
                            icon: const Icon(Icons.remove, size: 15),
                            color: Colors.black,
                          ),
                          const Text(
                            '1',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              // Handle increment logic
                            },
                            icon: const Icon(Icons.add, size: 15),
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                           ),
             ),
            const Divider(),
            Container(
               margin: const EdgeInsets.symmetric(horizontal: 36.0),
           
            decoration: BoxDecoration(
              color: Colors.white30,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Padding(
              padding:  EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  Text('Price'),
                  Text('\$4.53'),
                ],
              ),
            ),
            ),
            Container(
               margin: const EdgeInsets.symmetric(horizontal: 36.0),
           
            decoration: BoxDecoration(
              color: Colors.white30,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Delivery Fee'),
                  Text('\$2.00'),
                ],
              ),
            ),
            ),
            const Divider(),
            Container(
               margin: const EdgeInsets.symmetric(horizontal: 36.0),
           
            decoration: BoxDecoration(
              color: Colors.white30,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Payment',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$6.53', // Update total price based on delivery option
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            ),
            const Divider(),
            Container(
               margin: const EdgeInsets.symmetric(horizontal: 36.0),
    
            decoration: BoxDecoration(
              color: Colors.white30,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Pick Up By',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ),
            ),
            Container(
               margin: const EdgeInsets.symmetric(horizontal: 36.0),
               padding: const EdgeInsets.only( bottom: 20.0),
        
            decoration: BoxDecoration(
              color: Colors.white30,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Padding(
              padding:  EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Jl. Kpg Sutoyo\n12:00 PM\nToday', style: TextStyle(fontSize: 16.0)),
            ),
            ),
            const Divider(),
            Container(
               margin: const EdgeInsets.symmetric(horizontal: 36.0),
          
            decoration: BoxDecoration(
              color: Colors.white30,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Payment',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ),
            ),
            Padding(
  padding: const EdgeInsets.symmetric(horizontal: 1.0),
  child: Container(
    margin: const EdgeInsets.symmetric(horizontal: 26.0),
    padding: const EdgeInsets.all(2.0),
    decoration: BoxDecoration(
      color: Color.fromARGB(0, 215, 217, 218),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Row(
      children: [
        OptionButton(
          text: 'COP',
          isSelected: paymentOption == 'COP',
          onTap: () {
            setState(() {
              paymentOption = 'COP';
            });
          },
        ),
        const SizedBox(width: 20), // Add space between buttons
        OptionButton(
          text: 'PromptPay',
          isSelected: paymentOption == 'PromptPay',
          onTap: () {
            setState(() {
              paymentOption = 'PromptPay';
            });
          },
        ),
      ],
    ),
  ),
),

            const Divider(),
           
            Container(
  margin: const EdgeInsets.symmetric(horizontal: 36.0),
  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
  width: double.infinity,
  child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 36),
        foregroundColor: Colors.black,
        backgroundColor: Colors.brown,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Order placed successfully!'),
            duration: Duration(seconds: 2),
          ),
        );
      },
      child: const Text(
        'Place Order',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
  ),
),

          ],
        ),
      ),
    );
  }
}