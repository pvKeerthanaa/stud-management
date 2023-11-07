import 'package:flutter/material.dart';

class Course {
  String title;
  String description;
  final List<String> assignments;

  Course({
    required this.title,
    required this.description,
    required this.assignments,
  });
}

void main() {
  runApp(CourseScreen());
}

class CourseScreen extends StatefulWidget {
  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  final List<Course> courses = [
    Course(
      title: 'Mathematics',
      description: 'Advanced Mathematics Course',
      assignments: ['Assignment 1', 'Assignment 2'],
    ),
    Course(
      title: 'Science',
      description: 'General Science Course',
      assignments: ['Assignment 1'],
    ),
    Course(
      title: 'History',
      description: 'World History Course',
      assignments: ['Assignment 1', 'Assignment 2', 'Assignment 3'],
    ),
    Course(
      title: 'Politics',
      description: 'World Politics Course',
      assignments: ['Assignment 1', 'Assignment 2', 'Assignment 3'],
    ),
    Course(
      title: 'Geography',
      description: 'World Geography Course',
      assignments: ['Assignment 1', 'Assignment 2', 'Assignment 3'],
    ),
    Course(
      title: 'Python',
      description: 'Hello Python!',
      assignments: ['Assignment 1', 'Assignment 2', 'Assignment 3'],
    ),
    Course(
      title: 'Java',
      description: 'The complete java developer',
      assignments: ['Assignment 1', 'Assignment 2', 'Assignment 3'],
    ),
  ];

  List<Course> filteredCourses = [];

  TextEditingController newCourseController = TextEditingController();
  TextEditingController newDescriptionController = TextEditingController();

  @override
  void initState() {
    filteredCourses = List.from(courses);
    super.initState();
  }

  void filterCourses(String query) {
    setState(() {
      filteredCourses = courses
          .where((course) =>
              course.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void enrollToCourse(Course course) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Enrolled in ${course.title}'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void addCourse() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Course'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: newCourseController,
                decoration: InputDecoration(labelText: 'Course Title'),
              ),
              TextField(
                controller: newDescriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Add'),
              onPressed: () {
                setState(() {
                  courses.add(Course(
                    title: newCourseController.text,
                    description: newDescriptionController.text,
                    assignments: [],
                  ));
                  filteredCourses = List.from(courses);
                  newCourseController.clear();
                  newDescriptionController.clear();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void editCourse(Course course) {
    TextEditingController editTitleController =
        TextEditingController(text: course.title);
    TextEditingController editDescriptionController =
        TextEditingController(text: course.description);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Course'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: editTitleController,
                decoration: InputDecoration(labelText: 'Course Title'),
              ),
              TextField(
                controller: editDescriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Update'),
              onPressed: () {
                setState(() {
                  course.title = editTitleController.text;
                  course.description = editDescriptionController.text;
                  filteredCourses = List.from(courses);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void deleteCourse(Course course) {
    setState(() {
      courses.remove(course);
      filteredCourses = List.from(courses);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 20, 20, 20),
      appBar: AppBar(
        title: Text('Course Management'),
        backgroundColor: Color.fromARGB(255, 12, 12, 12),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Courses',
                hintStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                filterCourses(value);
              },
            ),
          ),
          ElevatedButton(
            onPressed: addCourse,
            child: Text('Add Course'),
            style: ElevatedButton.styleFrom(
              primary: Colors.green, // Background color
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCourses.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    filteredCourses[index].title,
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    filteredCourses[index].description,
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _navigateToCourseDetails(
                              context, filteredCourses[index]);
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          editCourse(filteredCourses[index]);
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          deleteCourse(filteredCourses[index]);
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    enrollToCourse(filteredCourses[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToCourseDetails(BuildContext context, Course course) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CourseDetailsScreen(course: course),
      ),
    );
  }
}

class CourseDetailsScreen extends StatelessWidget {
  final Course course;

  CourseDetailsScreen({required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 20, 20, 20),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 20, 20, 20),
        title: Text(
          'Course Details',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              course.title,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            SizedBox(height: 10),
            Text(
              course.description,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              'Assignments:',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Column(
              children: course.assignments
                  .map((assignment) => ListTile(
                        title: Text(
                          assignment,
                          style: TextStyle(color: Colors.orange),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
