import 'package:flutter/material.dart';

class Order extends StatefulWidget {
  const Order({Key? key}) : super(key: key);

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  String selectedOption = 'Delivery'; // Default selected option
  int _counter = 1; // Starting value

  void _decrementCounter() {
    setState(() {
      if (_counter > 1) {
        _counter--;
      }
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
                horizontal: 36.0), // Left and right margin applied here
            padding: const EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 215, 217, 218),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OptionButton(
                  text: 'Delivery',
                  isSelected: selectedOption == 'Delivery',
                  onTap: () {
                    setState(() {
                      selectedOption = 'Delivery';
                    });
                  },
                ),
                OptionButton(
                  text: 'Pickup',
                  isSelected: selectedOption == 'Pickup',
                  onTap: () {
                    setState(() {
                      selectedOption = 'Pickup';
                    });
                  },
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 36.0),
            padding: const EdgeInsets.only(top: 20, bottom: 20, right: 20),
            decoration: BoxDecoration(
              color: Colors.white30,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Delivery Address',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Jl. Kpg Sutoyo',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Kpg. Sutoyo No. 620, Bilzen, Tanjungbalai.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.grey,
            height: 20, // Adjust the height of the divider
            thickness: 1, // Adjust the thickness of the divider
            indent: 20, // Adjust the indentation of the divider
            endIndent: 20, // Adjust the end indentation of the divider
          ),
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
                    borderRadius: BorderRadius.circular(
                        20), // half of width and height to make it a circle
                    border: Border.all(
                      color: Colors.transparent,
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
                          onPressed: _decrementCounter,
                          icon: const Icon(Icons.remove, size: 15),
                          color: Colors.black,
                        ),
                        Text(
                          '$_counter',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                        ),
                        IconButton(
                          onPressed: _incrementCounter,
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
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 36.0),
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Color.fromARGB(255, 189, 186, 186), // Border color
                width: 1.0, // Border width
              ),
              borderRadius: BorderRadius.circular(10.0), // Border radius
            ),
            child: const Row(
              children: [
                Text(
                  '1 Discount is applied',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 100),
                  child: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.black,
                    size: 20, // Arrow icon color
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 36.0),
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Payment Summary',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10), // Adjust the vertical spacing
                Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Price:',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '\$4.53',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10), // Adjust the vertical spacing
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color:
                            Color.fromARGB(255, 189, 186, 186), // Border color
                        width: 1.0, // Border width
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Delivery Fee:',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '\$1.00',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10), // Adjust the vertical spacing
                Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Payment:',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '\$5.53',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 36.0),
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 36),
                foregroundColor: Colors.black,
                backgroundColor: Colors.brown,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      8.0), // Adjust the border radius here
                ),
              ),
              onPressed: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (BuildContext context) => const ImageList(),
                //   ),
                // );
              },
              child: const Text(
                'Order',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OptionButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final double textSize;
  final VoidCallback onTap;

  const OptionButton({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.onTap,
    this.textSize = 16.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: MediaQuery.of(context).size.width *
            0.4, // Adjust the width as needed
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color:
                isSelected ? Colors.brown : const Color.fromARGB(0, 54, 24, 24),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}