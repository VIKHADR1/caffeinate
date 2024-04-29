import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Order extends StatefulWidget {
  Order({Key? key}) : super(key: key);

  @override
  State<Order> createState() => _OrderState();
  List<Item> items = [];
}

class Item {
  final String name;
  final double price;
  final String image;
  final String size;
  int quantity;

  Item(
      {required this.name,
      required this.price,
      required this.image,
      required this.size,
      required this.quantity});
}

class _OrderState extends State<Order> {
  String selectedOption = 'Delivery'; // Default selected option
  double deliveryFee = 1.00;
  String deliveryAddress = 'John Doe 123 Main Street';

  @override
  Widget build(BuildContext context) {
    List<Item> items = [
      Item(
          name: 'Cappucino',
          price: 4.5,
          image: 'assets/images/Cappucino.jpg',
          size: 'M',
          quantity: 2),
      Item(
          name: 'Latte',
          price: 4.5,
          image: 'assets/images/Latte.jpg',
          size: 'M',
          quantity: 1),
      Item(
          name: 'Americano',
          price: 4.5,
          image: 'assets/images/Americano.jpg',
          size: 'M',
          quantity: 1),
      Item(
          name: 'Espresso',
          price: 4.5,
          image: 'assets/images/Espresso.jpg',
          size: 'M',
          quantity: 1),
    ];

    double calculateProductPrice() {
      double productPrice = 0;
      for (var item in items) {
        productPrice += item.price * item.quantity;
      }
      return productPrice;
    }

    double calculateTotalPrice() {
      double totalPrice =
          calculateProductPrice(); // Start with the product price

      if (selectedOption == 'Delivery') {
        totalPrice += deliveryFee;
      }

      return totalPrice;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
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
                  if (selectedOption == 'Delivery')
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 36.0),
                      padding:
                          const EdgeInsets.only(top: 20, bottom: 20, right: 20),
                      decoration: BoxDecoration(
                        color: Colors.white30,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
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
                          TextFormField(
                            initialValue: deliveryAddress,
                            decoration: InputDecoration(
                              hintText: 'Enter your delivery address',
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                            onChanged: (value) {
                              setState(() {
                                deliveryAddress = value;
                              });
                            },

                            maxLength:
                                100, // Maximum character length for the address
                            keyboardType: TextInputType
                                .multiline, // Allowing multiline input
                            maxLines:
                                null, // Allowing unlimited lines for the address
                          ),
                        ],
                      ),
                    ),
                  if (selectedOption == 'Delivery')
                    const Divider(
                      color: Colors.grey,
                      height: 20, // Adjust the height of the divider
                      thickness: 1, // Adjust the thickness of the divider
                      indent: 20, // Adjust the indentation of the divider
                      endIndent:
                          20, // Adjust the end indentation of the divider
                    ),

                  //Start form here
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 36.0),
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.white30,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: items.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            // mainAxisAlignment: MainAxisAlignment.end,
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
                                  items[index].image, // Path to your image
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit
                                      .cover, // Adjust how the image fits within the container
                                ),
                              ),
                              const SizedBox(width: 5),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${items[index].name}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            ' ${items[index].size}  \$${items[index].price.toStringAsFixed(2)}',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(width: 120),
                                          Text(
                                            'Qty: ${items[index].quantity}',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                  ),

                  //End here

                  // const SizedBox(height: 5),
                  // Container(
                  //   margin: const EdgeInsets.symmetric(horizontal: 36.0),
                  //   padding: const EdgeInsets.all(20.0),
                  //   decoration: BoxDecoration(
                  //     border: Border.all(
                  //       color: Color.fromARGB(255, 189, 186, 186), // Border color
                  //       width: 1.0, // Border width
                  //     ),
                  //     borderRadius: BorderRadius.circular(10.0), // Border radius
                  //   ),
                  //   child: const Row(
                  //     children: [
                  //       Text(
                  //         'Applying Discount...',
                  //         style: TextStyle(
                  //           fontSize: 14,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.only(left: 100),
                  //         child: Icon(
                  //           Icons.arrow_forward_ios_outlined,
                  //           color: Colors.black,
                  //           size: 20, // Arrow icon color
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 36.0),
                    padding: const EdgeInsets.only(top: 5, bottom: 20),
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
                        const SizedBox(
                            height: 10), // Adjust the vertical spacing
                        Container(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Price:',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '\$${calculateProductPrice().toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                            height: 10), // Adjust the vertical spacing
                        if (selectedOption == 'Delivery')
                          Container(
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

                        const Divider(
                          color: Colors.grey,
                          height: 20,
                          thickness: 1,
                          indent: 0,
                          endIndent: 0,
                        ),

                        Container(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Payment:',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '\$${calculateTotalPrice().toStringAsFixed(2)}',
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
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
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