import 'package:flutter/material.dart';

class Noti extends StatefulWidget {
  const Noti({Key? key}) : super(key: key);

  @override
  _NotiState createState() => _NotiState();
}

class _NotiState extends State<Noti> with SingleTickerProviderStateMixin {
  List<bool> showSizedBoxes = [];
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3), // Adjust the duration as needed
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              for (int i = 0; i < showSizedBoxes.length; i++)
                if (showSizedBoxes[i])
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: SizedBox(
                      height: 85,
                      width: 350,
                      child: Stack(
                        children: [
                          Container(
                            height: double.infinity,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFFC67C4E),
                              borderRadius: BorderRadius.circular(30.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 7,
                                  blurRadius: 7,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Your order will arrive in 5 minutes',
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 50),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              AnimatedBuilder(
                                animation: _controller,
                                builder: (context, child) {
                                  return ClipRect(
                                    child: Align(
                                      alignment: Alignment.center,
                                      widthFactor: _controller.value,
                                      child: Container(
                                        height: 6,
                                        width: 350,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _addSizedBox();
                  _controller.reset();
                  _controller
                      .forward(); // Start the animation from the beginning
                },
                child: Text('Order confirmed'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  

  void _addSizedBox() {
    setState(() {
      showSizedBoxes.add(true);
    });
  }
}
