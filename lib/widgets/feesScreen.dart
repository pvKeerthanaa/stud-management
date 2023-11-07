import 'package:flutter/material.dart';

class Student {
  final String name;
  final bool hasPaid;

  Student({required this.name, required this.hasPaid});
}

class FeePaymentScreen extends StatefulWidget {
  @override
  _FeePaymentScreenState createState() => _FeePaymentScreenState();
}

class _FeePaymentScreenState extends State<FeePaymentScreen> {
  List<Student> students = [
    Student(name: 'Alice', hasPaid: true),
    Student(name: 'Bob', hasPaid: false),
    Student(name: 'Charlie', hasPaid: true),
    Student(name: 'David', hasPaid: false),
    Student(name: 'Eva', hasPaid: true),
    // Add more student data
  ];

  @override
  Widget build(BuildContext context) {
    int paidCount = students.where((student) => student.hasPaid).length;
    int pendingCount = students.length - paidCount;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 20, 20, 20),
      body: Column(
        children: <Widget>[
          Card(
            color: Color.fromARGB(255, 30, 30, 30),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 70,
                        width: 70,
                        child: Image.asset('assets/paid.png'),
                      ),
                    ),
                    Expanded(
                      child: _buildPercentageIndicator(
                        value: paidCount / students.length,
                        color: Colors.blue,
                        title: 'Paid',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Card(
            color: Color.fromARGB(255, 30, 30, 30),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 70,
                        width: 70,
                        child: Image.asset('assets/pending.png'),
                      ),
                    ),
                    Expanded(
                      child: _buildPercentageIndicator(
                        value: pendingCount / students.length,
                        color: Colors.red,
                        title: 'Pending',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(
              'List of Students:',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    students[index].name,
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: students[index].hasPaid
                      ? Icon(Icons.check, color: Colors.green)
                      : Icon(Icons.close, color: Colors.red),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPercentageIndicator({
    required double value,
    required Color color,
    required String title,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 130,
      child: Stack(
        children: [
          Center(
            child: SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(
                value: value,
                strokeWidth: 8,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
          ),
          Center(
            child: Text(
              '$title: ${(value * 100).round()}%',
              style:
                  TextStyle(color: Colors.green, fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }
}
