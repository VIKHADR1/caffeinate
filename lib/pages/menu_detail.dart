import 'package:flutter/material.dart';
import 'package:cafe_project/home.dart';

class MenuDetail extends StatelessWidget {
  final Product product;

  const MenuDetail({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: 350,
              height: 300,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40.0),
                  child: Image.asset(
                    product.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  product.name,
                  style: TextStyle(fontSize: 34),
                ),
              ],
            ),
            Divider(),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Description',
                    style: TextStyle(fontSize: 28),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    product.description,
                    style: TextStyle(
                        fontSize: 16,
                        color: const Color.fromARGB(255, 109, 105, 105)),
                    softWrap: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Divider(),
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
                      primary: Color.fromARGB(255, 198, 124, 78),
                    ),
                    child: Text(
                      'S',
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle button click for 'M'
                      print('M clicked');
                    },
                    child: Text(
                      'M',
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 206, 155, 97)),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle button click for 'L'
                      print('L clicked');
                    },
                    child: Text(
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
            Divider(),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    'Price ${product.price.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle buy now button click
                      print('Buy Now clicked');
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 198, 124, 78),
                    ),
                    child: Text(
                      'Buy Now',
                      style: TextStyle(fontSize: 20, color: Colors.white),
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
