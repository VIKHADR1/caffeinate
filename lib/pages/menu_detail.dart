import 'package:caffeinate/pages/home.dart';
import 'package:flutter/material.dart';

class MenuDetail extends StatefulWidget {
  final Product product;

  const MenuDetail({Key? key, required this.product}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MenuDetailState createState() => _MenuDetailState();
}

class _MenuDetailState extends State<MenuDetail> {
  String _selectedSize = 'S';
  late double _basePrice;

  @override
  void initState() {
    super.initState();
    _basePrice = widget.product.price;
  }

  @override
  Widget build(BuildContext context) {
    double price = _basePrice;
    switch (_selectedSize) {
      case 'M':
        price = _basePrice + 2;
        break;
      case 'L':
        price = _basePrice + 3;
        break;
      default:
        price = _basePrice;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: 350,
              height: 300,
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40.0),
                  child: Image.asset(
                    widget.product.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.product.name,
                  style: const TextStyle(fontSize: 34),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 30.0),
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
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    widget.product.description,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 109, 105, 105)),
                    softWrap: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedSize = 'S';
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedSize == 'S'
                            ? const Color.fromARGB(255, 198, 124, 78)
                            : Colors.grey[300],
                      ),
                      child: Text(
                        'S',
                        style: TextStyle(
                          fontSize: 16,
                          color: _selectedSize == 'S'
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedSize = 'M';
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedSize == 'M'
                            ? const Color.fromARGB(255, 198, 124, 78)
                            : Colors.grey[300],
                      ),
                      child: Text(
                        'M',
                        style: TextStyle(
                          fontSize: 16,
                          color: _selectedSize == 'M'
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedSize = 'L';
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedSize == 'L'
                            ? const Color.fromARGB(255, 198, 124, 78)
                            : Colors.grey[300],
                      ),
                      child: Text(
                        'L',
                        style: TextStyle(
                          fontSize: 16,
                          color: _selectedSize == 'L'
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Divider
            // Price and Buy Now button
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Price \$$price',
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle buy now button click
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 198, 124, 78),
                      ),
                      child: const Text(
                        'Buy Now',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
