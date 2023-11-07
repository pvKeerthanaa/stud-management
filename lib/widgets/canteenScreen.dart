import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'dart:convert';
import 'package:toastification/toastification.dart';

class CanteenManagementScreen extends StatefulWidget {
  @override
  _CanteenManagementScreenState createState() =>
      _CanteenManagementScreenState();
}

class _CanteenManagementScreenState extends State<CanteenManagementScreen> {
  List<Map<String, dynamic>> menu = [];
  List<Map<String, dynamic>> selectedItems = [];

  double calculateTotalBill() {
    double total = 0;
    for (Map<String, dynamic> item in selectedItems) {
      total += 5.0; // Replace with actual item prices or logic for each item
    }
    return total;
  }

  void _processPayment(BuildContext context) {
    if (selectedItems.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              BillGeneratorScreen(selectedItems: selectedItems),
        ),
      );
    } else {
      Toast.show(
        "Please select items to generate a bill.",
        duration: Toast.lengthShort,
        gravity: Toast.center,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMenu();
  }

  Future<void> fetchMenu() async {
    final response = await http.get(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?s=Chicken'),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        menu = List<Map<String, dynamic>>.from(data['meals']);
      });
    } else {
      throw Exception('Failed to load menu');
    }
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Canteen Management',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 12, 12, 12),
      ),
      body: Container(
        color: Colors.black, // Dark background color
        child: ListView.builder(
          itemCount: menu.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: Colors.grey[900], // Card background color
              child: ListTile(
                title: Text(
                  menu[index]['strMeal'],
                  style: TextStyle(color: Colors.white), // Text color
                ),
                leading: Image.network(
                  menu[index]['strMealThumb'],
                  width: 50,
                  height: 50,
                ),
                trailing: selectedItems.contains(menu[index])
                    ? Icon(Icons.check_circle, color: Colors.green)
                    : Icon(Icons.radio_button_unchecked),
                onTap: () {
                  setState(() {
                    if (selectedItems.contains(menu[index])) {
                      selectedItems.remove(menu[index]);
                    } else {
                      selectedItems.add(menu[index]);
                    }
                  });
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange, // FAB color
        onPressed: () {
          _processPayment(context);
        },
        tooltip: 'Generate Bill',
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}

class BillGeneratorScreen extends StatefulWidget {
  final List<Map<String, dynamic>> selectedItems;

  BillGeneratorScreen({required this.selectedItems});

  @override
  _BillGeneratorScreenState createState() => _BillGeneratorScreenState();
}

class _BillGeneratorScreenState extends State<BillGeneratorScreen> {
  bool isPaying = false;
  bool paymentSuccess = false;

  double calculateTotalBill() {
    double total =
        widget.selectedItems.length * 5.0; // Assuming each item costs $5
    return total;
  }

  void _processPayment() {
    setState(() {
      isPaying = true;
    });

    // Simulate payment processing delay
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isPaying = false;
        paymentSuccess = true;
        _showPaymentStatus();
      });
    });
  }

  void _handleAnimationCompletion() {
    // Wait for 2 seconds after animation completion before navigating
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isPaying = false;
        paymentSuccess = true;
      });
      _navigateToPaymentStatus();
    });
  }

  void _navigateToPaymentStatus() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentStatusScreen(
          paymentSuccess: paymentSuccess,
          totalAmount: calculateTotalBill(),
          mockTransactionId: "ABC123",
          time: DateTime.now(),
        ),
      ),
    );
  }

  void _showPaymentStatus() {
    _handleAnimationCompletion();
    String message = paymentSuccess ? 'Payment Successful!' : 'Payment Failed!';
    toastification.showSuccess(
      context: context,
      title: message,
      autoCloseDuration: const Duration(seconds: 5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bill Generator',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 12, 12, 12),
      ),
      body: Center(
        child: isPaying
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    strokeWidth: 5,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Processing Payment...',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              )
            : Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Generated Bill',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.selectedItems.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 5,
                          color: Colors.grey[900], // Darker card background
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            title: Text(
                              widget.selectedItems[index]['strMeal'],
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            subtitle: Text(
                              'Price: \$5.0',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                            ),
                            trailing: Icon(
                              Icons.local_dining,
                              color: Colors.orange,
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Total Amount: \$${calculateTotalBill()}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        _processPayment();
                      },
                      child: Text('Pay'),
                    ),
                  ],
                ),
              ),
      ),
      backgroundColor: Colors.black, // Set dark background color
    );
  }
}

class PaymentStatusScreen extends StatelessWidget {
  final bool paymentSuccess;
  final double totalAmount;
  final String mockTransactionId;
  final DateTime time;

  PaymentStatusScreen({
    required this.paymentSuccess,
    required this.totalAmount,
    required this.mockTransactionId,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 12, 12, 12),
        title: Text(
          'Payment Status',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        color: Colors.black, // Dark background color
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                paymentSuccess ? Icons.check_circle : Icons.error,
                color: paymentSuccess ? Colors.green : Colors.red,
                size: 120,
              ),
              SizedBox(height: 20),
              Text(
                paymentSuccess ? 'Payment Successful!' : 'Payment Failed!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Card(
                color: Colors.grey[900], // Darker card background
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        'Amount Paid:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      Text(
                        '\$${totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      Divider(
                        color: Colors.white,
                        height: 20,
                      ),
                      Text(
                        'Transaction ID: $mockTransactionId',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Time: ${time.toString()}',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
