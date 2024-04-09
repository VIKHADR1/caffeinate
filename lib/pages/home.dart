import 'package:flutter/material.dart';

class Product {
  final String name;
  final String image;
  final double price;
  final String description;

  const Product(this.name, this.image, this.price, this.description);
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  final List<Product> _products = [
    const Product('Latte', 'assets/images/coffee.jpg', 4.50,
        'A delicious latte made with freshly brewed espresso and steamed milk.'),
    const Product('Latte', 'assets/images/profile.jpg', 4.50,
        'A delicious latte made with freshly brewed espresso and steamed milk.'),
    const Product('Latte', 'assets/images/coffee.jpg', 4.50,
        'A delicious latte made with freshly brewed espresso and steamed milk.'),
  ];

  void _onCategoryTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.menu,
              size: 30,
            ),
            SizedBox(
              width: 40,
              height: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/images/profile.jpg'),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: const Padding(
                padding: EdgeInsets.only(left: 20, bottom: 10),
                child: Text(
                  'Find the best \ncoffee for you',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.brown),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search ...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal, // Enable horizontal scrolling
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCategoryButton('#Espresso', 0),
                    _buildCategoryButton('#Tea', 1),
                    _buildCategoryButton('#Smoothie', 2),
                    _buildCategoryButton('#Cake', 3),
                    _buildCategoryButton('#Latte', 4),
                  ],
                ),
              ),
            ),
            GridView.count(
              shrinkWrap: true, // Adjust grid height based on content
              physics:
                  const NeverScrollableScrollPhysics(), // Disable grid scrolling
              crossAxisCount: 2, // Two items per row
              mainAxisSpacing: 10.0, // Spacing between rows
              crossAxisSpacing: 10.0, // Spacing between items
              children: _products
                  .map((product) => _buildProductItem(product))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton(String text, int index) {
    final backgroundColor =
        _selectedIndex == index ? Colors.brown : Colors.white;
    final textColor = _selectedIndex == index ? Colors.white : Colors.black;

    return TextButton(
      onPressed: () => _onCategoryTap(index),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        backgroundColor: backgroundColor,
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: 17),
      ),
    );
  }

  Widget _buildProductItem(Product product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            // Maintain aspect ratio (preferred)
            AspectRatio(
              aspectRatio: 15 / 10, // Adjust for your image's aspect ratio
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  product.image,
                  fit: BoxFit
                      .cover, // Cover width while maintaining aspect ratio
                ),
              ),
            ),

            // Optional: Use BoxFit.contain if aspect ratio isn't critical
            /* Image.asset(
          product.image,
          fit: BoxFit.contain, // Scale to fit, may leave space
        ), */
            Text(
              product.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('\$${product.price}'),
          ],
        ),
      ),
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Column(
        children: [
          Hero(
            tag: product.image,
            child: AspectRatio(
              aspectRatio: 15 / 10,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  product.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Text(
            product.name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            '\$${product.price}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                product.description,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
