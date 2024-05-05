import 'package:caffeinate/pages/menu_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  Set<Product> _favoriteProducts = Set<Product>();
  User? _user = FirebaseAuth.instance.currentUser;

  final List<Product> _products = [
    const Product( 
        'Hot Tea',
        'assets/images/tea.jpg',
        4.50,
        'A delicious latte made with freshly brewed espresso and steamed milk.',
        '#Tea'),
    const Product(
        'Espresso', 
        'assets/images/espresso.jpeg',
        4.50,
        'A bold shot of espresso, perfect for a quick pick-me-up.',
        '#Espresso',
      ),
    const Product(
        'Latte',
        'assets/images/latte.JPG',
        5.50,
        'Smooth espresso combined with creamy steamed milk, topped with a light layer of foam.',
        '#Latte',
      ),
    const Product( 
      'Cappuccino',
      'assets/images/cappuccino.jpg',
      5.00,
      'Equal parts espresso, steamed milk, and milk foam, creating a rich and frothy drink.',
      '#Cappuccino',
    ),
    const Product( 
      'Americano',
      'assets/images/americano.JPG',
      4.75,
      'Espresso shots diluted with hot water, resulting in a bold yet smooth flavor.',
      '#Americano',
    ),
    const Product( 
      'Macchiato',
      'assets/images/macchiato.jpg',
      5.25,
      'Espresso "stained" with a dollop of frothy milk, creating a perfect balance of flavors.',
      '#Macchiato',
    ),
    const Product( 
      'Flat White',
      'assets/images/flat_white.jpg',
      5.75,
      'Creamy microfoam poured over a double shot of espresso, resulting in a velvety smooth texture.',
      '#FlatWhite',
    ),
    const Product( 
      'Turkish',
      'assets/images/turkish_coffee.jpg',
      5.50,
      'A traditional brewing method where finely ground coffee is simmered in water, resulting in a strong and aromatic drink.',
      '#TurkishCoffee',
    ),
    const Product(
      'Iced Coffee',
      'assets/images/iced_coffee.jpg',
      4.75,
      'Chilled coffee served over ice, perfect for hot summer days or as a refreshing pick-me-up.',
      '#IcedCoffee',
    ),

    //cakes
    const Product(
    'Red Velvet',
    'assets/images/red_velvet_cake.jpg',
    4.50,
    'A moist and fluffy cake with a hint of cocoa, topped with cream cheese frosting.',
    '#Cake',
  ),
  const Product(
    'Choco Cake',
    'assets/images/chocolate_fudge_cake.jpg',
    5.50,
    'Decadent layers of rich chocolate cake filled and topped with velvety fudge icing.',
    '#Cake',
  ),
  
  const Product(
    'Lemon Cake',
    'assets/images/lemon_drizzle_cake.jpg',
    4.25,
    'A light and tangy lemon-flavored cake soaked in a zesty lemon syrup and topped with icing.',
    '#Cake',
  ),
  const Product(
    'Cheesecake',
    'assets/images/cheesecake.jpg',
    5.25,
    'A creamy and smooth cheesecake on a graham cracker crust, served plain or with fruit topping.',
    '#Cake',
  ),
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
  bool isFavorite = _favoriteProducts.contains(product);

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
            aspectRatio: 15/ 8, // Adjust for your image's aspect ratio
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                product.image,
                fit: BoxFit.cover, // Cover width while maintaining aspect ratio
              ),
            ),
          ),
          const SizedBox(height: 3),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : null,
                  ),
                  onPressed: () {
                    setState(() {
                      if (isFavorite) {
                        _favoriteProducts.remove(product);
                        // Remove from Firestore
                        FirebaseFirestore.instance.collection('users').doc(_user?.uid).collection('fav').doc(product.name).delete();
                      } else {
                        _favoriteProducts.add(product);
                        // Add to Firestore
                        FirebaseFirestore.instance.collection('users').doc(_user?.uid).collection('fav').doc(product.name).set({
                          'name': product.name,
                          'image': product.image,
                          'price': product.price,
                          'description': product.description,
                          'category': product.category,
                        });
                      }
                    });
                  },
                ),
              ],
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