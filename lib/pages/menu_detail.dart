import 'package:flutter/material.dart';

class MenuDetail extends StatefulWidget {
  MenuDetail({Key? key}) : super(key: key);

  @override
  State<MenuDetail> createState() => _MenuDetailState();
}

class _MenuDetailState extends State<MenuDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 350, // Set the desired width
              height: 300,
              child: Padding(
                padding: EdgeInsets.only(top: 20), // Add padding to the top
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      40.0), // Set border radius for rounded corners
                  child: Image.asset(
                    'images/09fe52a3e822993728eb7f9bb3883994.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20), // Add spacing between the image and the text
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Cappuccino',
                  style: TextStyle(fontSize: 34),
                ),
              ],
            ),
            Divider(), // Add a line between the rows
            SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.0), // Add left padding
                  child: Text(
                    'Description',
                    style: TextStyle(fontSize: 28),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,

                  // Adjust the width as needed
                  child: Text(
                    'A cappuccino is an approximately 150 ml (5 oz) beverage, with 25 ml of espresso coffee and 85ml of fresh milk the fo.. Read More',
                    style: TextStyle(
                        fontSize: 16,
                        color: const Color.fromARGB(255, 109, 105, 105)),
                    softWrap: true, // Allow text to wrap to a new line
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Divider(), // Add a line between the rows
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle button click for 'S'
                      print('S clicked');
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(
                          255, 198, 124, 78), // Change the button color here
                    ),
                    child: Text(
                      'S',
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle button click for 'M'
                      print('M clicked');
                    },
                    child: const Text(
                      'M',
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 206, 155, 97)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle button click for 'L'
                      print('L clicked');
                    },
                    child: const Text(
                      'L',
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 206, 155, 97)),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Divider(), // Add a line between the rows
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    'Price 4.58 ',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle button click for 'M'
                      print('Price Set');
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(
                          255, 198, 124, 78), // Change the button color here
                    ),
                    child: Text(
                      'Buy Now',
                      style: TextStyle(fontSize: 20, color: Color(0xFFFFFFFF)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
