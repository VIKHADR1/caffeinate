import 'package:caffeinate/pages/menu_detail.dart';
import 'package:flutter/material.dart';

class Product {
  final String name;
  final String image;
  final double price;
  final String description;
  final String category;

  const Product(
      this.name, this.image, this.price, this.description, this.category);
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _selectedCategory = '#All';
  double _gridViewHeight = 800;
  String _searchQuery = '';

  final List<Product> _products = [
    const Product(
        'espresso',
        'assets/images/coffee.jpg',
        4.50,
        'A delicious latte made with freshly brewed espresso and steamed milk.',
        '#Espresso'),
    const Product(
        'tea',
        'assets/images/profile.jpg',
        4.50,
        'A delicious latte made with freshly brewed espresso and steamed milk.',
        '#Tea'),
    const Product(
        'latte',
        'assets/images/coffee.jpg',
        4.50,
        'A delicious latte made with freshly brewed espresso and steamed milk.',
        '#Latte'),
    // Add more products here...
  ];

  List<Product> _filteredProducts = [];

  @override
  void initState() {
    super.initState();

    _selectedCategory = '#All';
    _filteredProducts = List.from(_products);
  }

  void _search(String query) {
    setState(() {
      _searchQuery = query;
      _filteredProducts = _products
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()) ||
              product.category.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _filterProducts() {
    if (_selectedCategory == '#All') {
      _filteredProducts = _products
          .where((product) =>
              product.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              product.category
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()))
          .toList();
    } else {
      _filteredProducts = _products
          .where((product) =>
              product.category == _selectedCategory &&
              (product.name
                      .toLowerCase()
                      .contains(_searchQuery.toLowerCase()) ||
                  product.category
                      .toLowerCase()
                      .contains(_searchQuery.toLowerCase())))
          .toList();
    }
  }

  void _onCategoryTap(String category) {
    setState(() {
      _selectedCategory = category;
      _filterProducts();
    });
  }

  void _onSearchTextChanged(String text) {
    _search(text);
  }

  @override
  Widget build(BuildContext context) {
    _gridViewHeight = _filteredProducts.length * 200 + 30;
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
                onChanged: (text) {
                  _onSearchTextChanged(text);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal, // Enable horizontal scrolling
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCategoryButton('#All', 0),
                    _buildCategoryButton('#Tea', 1),
                    _buildCategoryButton('#Espresso', 2),
                    _buildCategoryButton('#Cake', 3),
                    _buildCategoryButton('#Latte', 4),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: _gridViewHeight,
              child: SingleChildScrollView(
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  children: _filteredProducts
                      .map((product) => _buildProductItem(product))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton(String category, int index) {
    final backgroundColor =
        _selectedCategory == category ? Colors.brown : Colors.white;
    final textColor =
        _selectedCategory == category ? Colors.white : Colors.black;

    return TextButton(
      onPressed: () => _onCategoryTap(category),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        backgroundColor: backgroundColor,
      ),
      child: Text(
        category,
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
            builder: (_) => MenuDetail(product: product),
          ),
        );
      },
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            const SizedBox(height: 3),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                product.name,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                '\$${product.price}',
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}