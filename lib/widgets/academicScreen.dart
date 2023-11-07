import 'package:flutter/material.dart';

class Student {
  final String name;
  final int marks;
  final String grade;
  final double attendance;

  Student({
    required this.name,
    required this.marks,
    required this.grade,
    required this.attendance,
  });
}

class AcademicsPage extends StatelessWidget {
  final List<Student> students = [
    Student(name: 'Alice', marks: 85, grade: 'A', attendance: 0.92),
    Student(name: 'Bob', marks: 75, grade: 'B', attendance: 0.88),
    Student(name: 'Charlie', marks: 90, grade: 'A', attendance: 0.95),
    Student(name: 'David', marks: 60, grade: 'C', attendance: 0.75),
    Student(name: 'Eva', marks: 70, grade: 'B', attendance: 0.80),
    // Add more student data
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 20, 20, 20),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            color: Color.fromARGB(255, 25, 25, 25),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(color: Colors.grey.shade800, width: 1),
            ),
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              contentPadding: EdgeInsets.all(16),
              title: Text(
                students[index].name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Marks: ${students[index].marks}',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Grade: ${students[index].grade}',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Attendance: ${(students[index].attendance * 100).toStringAsFixed(2)}%',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              // trailing: Icon(
              //   Icons.book_outlined,
              //   color: Colors.grey,
              //   size: 36,
              // ),
              trailing: Image.asset('assets/academics.png'),
            ),
          );
        },
      ),
    );
  }
}
