import 'package:flutter/material.dart';
import '../models/student.dart';
import '../widgets/studentDetailScreen.dart';
import 'package:toastification/toastification.dart';
import 'progress.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class StudentListScreen extends StatefulWidget {
  @override
  _StudentListScreenState createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  late SharedPreferences _prefs;
  List<Student> students = []; // Initialize as an empty list

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  Future<void> _loadStudents() async {
    _prefs = await SharedPreferences.getInstance();
    String studentsJson = _prefs.getString('students') ?? '[]';
    List<dynamic> studentsData = json.decode(studentsJson);
    setState(() {
      students = studentsData.map((data) => Student.fromJson(data)).toList();
    });
  }

  Future<void> _saveStudents() async {
    List<Map<String, dynamic>> studentsData =
        students.map((student) => student.toJson()).toList();
    String studentsJson = json.encode(studentsData);
    await _prefs.setString('students', studentsJson);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 20, 20, 20),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            AttendanceCard(totalAttendanceToday: .7, portionCompleted: .8),
            SizedBox(height: 10),
            Text(
              "List of Students in class",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.green,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: students.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 2,
                    shadowColor: Color.fromARGB(255, 95, 95, 95),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      tileColor: const Color.fromARGB(255, 35, 35, 34),
                      leading: CircleAvatar(
                          backgroundColor: Colors.orange,
                          child: Icon(
                            Icons.account_circle,
                            color: Colors.white,
                          )),
                      title: Text(
                        students[index].name,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        _navigateToStudentDetails(context, students[index]);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.green,
            onPressed: () {
              _addStudent(context);
            },
            tooltip: 'Add Student',
            child: Icon(Icons.add),
          ),
          SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            backgroundColor: Colors.amber,
            onPressed: () {
              // loadStudentsFromPrefs();
              setState(() {});
            },
            tooltip: 'Refresh',
            child: Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }

  void _addStudent(BuildContext context) {
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _branchController = TextEditingController();
    final TextEditingController _rollNoController = TextEditingController();
    final TextEditingController _phoneController = TextEditingController();

    String? validateField(String value) {
      if (value.isEmpty) {
        return 'This field is required';
      }
      return null;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 20, 20, 20),
          title: Text(
            'Add Student',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField(_nameController, 'Student Name', validateField),
                _buildTextField(_branchController, 'Branch', validateField),
                _buildTextField(
                  _rollNoController,
                  'Roll No',
                  validateField,
                  TextInputType.number,
                ),
                _buildTextField(
                  _phoneController,
                  'Phone Number',
                  validateField,
                  TextInputType.phone,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Add'),
              onPressed: () {
                if (_nameController.text.isNotEmpty &&
                    _branchController.text.isNotEmpty &&
                    _rollNoController.text.isNotEmpty &&
                    _phoneController.text.isNotEmpty) {
                  setState(() {
                    students.add(
                      Student(
                        name: _nameController.text,
                        branch: _branchController.text,
                        rollNo: int.parse(_rollNoController.text),
                        phoneNumber: _phoneController.text,
                        fatherName: 'Not Provided',
                        motherName: 'Not Provided',
                      ),
                    );
                    _saveStudents();
                  });
                  Navigator.of(context).pop();
                  toastification.showSuccess(
                    context: context,
                    title: 'Student added successfully!',
                    autoCloseDuration: const Duration(seconds: 5),
                  );
                } else {
                  toastification.showError(
                    context: context,
                    title: 'No Fields can be empty',
                    autoCloseDuration: const Duration(seconds: 3),
                  );
                }
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText,
      String? Function(String) validator,
      [TextInputType keyboardType = TextInputType.text]) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextField(
        style: TextStyle(color: Colors.white),
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.green,
          ),
        ),
        keyboardType: keyboardType,
      ),
    );
  }

  void _navigateToStudentDetails(BuildContext context, Student student) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentDetailsScreen(
          student: student,
          students: students,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        students = List.from(
            result); // Update the student list with the returned result
      });
    }
  }
}
