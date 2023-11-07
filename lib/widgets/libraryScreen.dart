import 'package:flutter/material.dart';

class StudentBookDetails {
  final String studentName;
  final String bookName;
  final DateTime takenDate;
  final bool returned;

  StudentBookDetails({
    required this.studentName,
    required this.bookName,
    required this.takenDate,
    required this.returned,
  });
}

class LibraryManagementScreen extends StatelessWidget {
  final List<StudentBookDetails> studentsBookDetails = [
    StudentBookDetails(
      studentName: 'Alice',
      bookName: 'Introduction to Flutter',
      takenDate: DateTime(2023, 10, 15),
      returned: true,
    ),
    StudentBookDetails(
      studentName: 'Bob',
      bookName: 'Dart Programming',
      takenDate: DateTime(2023, 10, 20),
      returned: false,
    ),
    StudentBookDetails(
      studentName: 'Test',
      bookName: 'Java',
      takenDate: DateTime(2023, 10, 20),
      returned: true,
    ),
    StudentBookDetails(
      studentName: 'Keerthana',
      bookName: 'Python',
      takenDate: DateTime(2023, 10, 20),
      returned: false,
    ),
    StudentBookDetails(
      studentName: 'Jack',
      bookName: 'C',
      takenDate: DateTime(2023, 10, 20),
      returned: false,
    ),
    StudentBookDetails(
      studentName: 'Ann',
      bookName: 'C+',
      takenDate: DateTime(2023, 10, 20),
      returned: true,
    ),
    StudentBookDetails(
      studentName: 'Lance',
      bookName: 'Angular',
      takenDate: DateTime(2023, 10, 20),
      returned: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212), // Dark background color
      appBar: AppBar(
        title: Text('Library Management'),
        backgroundColor: Color(0xFF121212), // Dark app bar color
      ),
      body: Container(
        color: Color(0xFF121212), // Dark container color
        padding: const EdgeInsets.all(16.0),
        child: Theme(
          data: ThemeData.dark(),
          child: ListView(
            children: studentsBookDetails
                .map(
                  (data) => Card(
                    color: Colors.grey[900], // Dark grey card color
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      title: Text(
                        'Student: ${data.studentName}',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Book: ${data.bookName}',
                            style: TextStyle(color: Colors.cyan),
                          ),
                          Text(
                            'Taken Date: ${data.takenDate}',
                            style: TextStyle(color: Colors.white70),
                          ),
                          Text(
                            'Returned: ${data.returned ? 'Yes' : 'No'}',
                            style: TextStyle(
                                color:
                                    data.returned ? Colors.green : Colors.red,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            color: Colors.blue,
                            onPressed: () {
                              // Add edit action
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () {
                              // Add delete action
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
