import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/student.dart';
import 'package:toastification/toastification.dart';
import '../models/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentDetailsScreen extends StatefulWidget {
  final Student student;
  final List<Student> students;

  StudentDetailsScreen({
    required this.student,
    required this.students,
  });

  @override
  _StudentDetailsScreenState createState() =>
      _StudentDetailsScreenState(students: students, student: student);
}

class _StudentDetailsScreenState extends State<StudentDetailsScreen> {
  List<Student> students;
  late Student student;

  late SharedPreferences _prefs;
  late String _studentKey;

  late TextEditingController _nameController;
  late TextEditingController _classController;
  late TextEditingController _branchController;
  late TextEditingController _rollNoController;
  late TextEditingController _phoneController;
  late TextEditingController _fatherController;
  late TextEditingController _motherController;

  _StudentDetailsScreenState({
    required this.students,
    required this.student,
  }) {
    _nameController = TextEditingController(text: student.name);
    _classController = TextEditingController(); // Initialization added here
    _branchController = TextEditingController(text: student.branch);
    _rollNoController = TextEditingController(text: student.rollNo.toString());
    _phoneController = TextEditingController(text: student.phoneNumber);
    _fatherController = TextEditingController(text: student.fatherName);
    _motherController = TextEditingController(text: student.motherName);
  }

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _studentKey =
        'student_${student.name}'; // Choose a unique key for each student
    _loadStudentDetails();
  }

  void _loadStudentDetails() {
    _nameController.text =
        _prefs.getString('$_studentKey.name') ?? student.name;
    _classController.text = _prefs.getString('$_studentKey.class') ?? '';
    _branchController.text =
        _prefs.getString('$_studentKey.branch') ?? student.branch;
    _rollNoController.text =
        _prefs.getString('$_studentKey.rollNo') ?? student.rollNo.toString();
    _phoneController.text =
        _prefs.getString('$_studentKey.phoneNumber') ?? student.phoneNumber;
    _fatherController.text =
        _prefs.getString('$_studentKey.fatherName') ?? student.fatherName;
    _motherController.text =
        _prefs.getString('$_studentKey.motherName') ?? student.motherName;
  }

  void _saveStudentDetails() {
    _prefs.setString('$_studentKey.name', _nameController.text);
    _prefs.setString('$_studentKey.class', _classController.text);
    _prefs.setString('$_studentKey.branch', _branchController.text);
    _prefs.setString('$_studentKey.rollNo', _rollNoController.text);
    _prefs.setString('$_studentKey.phoneNumber', _phoneController.text);
    _prefs.setString('$_studentKey.fatherName', _fatherController.text);
    _prefs.setString('$_studentKey.motherName', _motherController.text);
  }

  void _editStudent(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 20, 20, 20),
          title: Text(
            'Edit Student Details',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                // ... (your text fields for editing)
                _buildTextField(_nameController, 'Student Name'),
                _buildTextField(_branchController, 'Branch'),
                _buildTextField(
                    _rollNoController, 'Roll No', TextInputType.number),
                _buildTextField(
                    _phoneController, 'Phone Number', TextInputType.phone),
                _buildTextField(_fatherController, 'Father\'s Name'),
                _buildTextField(_motherController, 'Mother\'s Name'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Update'),
              onPressed: () {
                Student updatedStudent = Student(
                  name: _nameController.text,
                  branch: _branchController.text,
                  rollNo: int.parse(_rollNoController.text),
                  phoneNumber: _phoneController.text,
                  fatherName: _fatherController.text,
                  motherName: _motherController.text,
                );

                int index =
                    students.indexWhere((element) => element == student);

                if (index != -1) {
                  setState(() {
                    students[index] = updatedStudent;
                    student = updatedStudent;
                    // _saveStudentDetails();
                  });
                }
                _saveStudentDetails();
                toastification.showSuccess(
                  padding: EdgeInsets.all(20),
                  context: context,
                  title: 'Student details updated successfully!',
                  autoCloseDuration: const Duration(seconds: 3),
                );

                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            // ... (rest of your code for cancel button)
          ],
        );
      },
    );
  }

  void _saveUpdatedStudents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> studentStrings =
        students.map((student) => json.encode(student.toJson())).toList();
    await prefs.setStringList('students', studentStrings);
  }

  void _deleteStudent(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Student'),
          content: Text('Are you sure you want to delete this student?'),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                setState(() {
                  students.removeWhere((s) => s.name == student.name);
                  _prefs.remove('$_studentKey.name');
                  _prefs.remove('$_studentKey.class');
                  _prefs.remove('$_studentKey.branch');
                  _prefs.remove('$_studentKey.rollNo');
                  _prefs.remove('$_studentKey.phoneNumber');
                  _prefs.remove('$_studentKey.fatherName');
                  _prefs.remove('$_studentKey.motherName');
                  // students.remove(student);
                  // students.removeWhere((s) => s.name == student.name);
                });
                print(student.name);
                toastification.showSuccess(
                  context: context,
                  title: 'Deletion successful!',
                  autoCloseDuration: const Duration(seconds: 3),
                );
                // Navigator.of(context).pop();
                // Navigator.of(context).pop(student.name);
                _saveUpdatedStudents();
                Navigator.of(context).pop(students);
                Navigator.of(context).pop();
              },
            ),
            // ... (rest of your code for No button)
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 20, 20, 20),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 12, 12, 12),
          title: Text('Student Details'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _editStudent(context);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _deleteStudent(context);
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            // constraints: BoxConstraints.expand(),
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  ProfileAvatar(
                    iconData: Icons.person_outlined,
                    backgroundColor: Colors.orange,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Table(
                      border: TableBorder.all(
                          width: 1,
                          color: const Color.fromARGB(255, 55, 55, 55),
                          borderRadius: BorderRadius.circular(8)),
                      children: <TableRow>[
                        // ... (your table rows)
                        _buildDetailRow('Student Name', student.name),
                        _buildDetailRow('Branch', student.branch),
                        _buildDetailRow('Roll No', student.rollNo.toString()),
                        _buildDetailRow('Phone Number', student.phoneNumber),
                        _buildDetailRow('Father\'s Name', student.fatherName),
                        _buildDetailRow('Mother\'s Name', student.motherName),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TableRow _buildDetailRow(String label, String value) {
    return TableRow(
      children: [
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 20, 20, 20),
              // border: Border.all(
              //   color: Colors.black,
              //   width: 1,
              // ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
              ),
            ),
            child: Text(
              label,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.amber),
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 20, 20, 20),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
              ),
            ),
            child: Text(
              value,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String labelText, [
    TextInputType keyboardType = TextInputType.text,
  ]) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextField(
        style: TextStyle(color: Colors.white),
        controller: controller,
        decoration: InputDecoration(
            labelText: labelText, labelStyle: TextStyle(color: Colors.green)),
        keyboardType: keyboardType,
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _classController.dispose();
    _branchController.dispose();
    _rollNoController.dispose();
    _phoneController.dispose();
    _fatherController.dispose();
    _motherController.dispose();
    super.dispose();
  }
}
