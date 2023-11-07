import 'package:flutter/material.dart';
import 'package:student/widgets/canteenScreen.dart';
import 'package:student/widgets/transportScreen.dart';
import 'libraryScreen.dart';
import 'courseScreen.dart';

class AttendanceCard extends StatelessWidget {
  final double totalAttendanceToday;
  final double portionCompleted;

  AttendanceCard({
    required this.totalAttendanceToday,
    required this.portionCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Color.fromARGB(255, 20, 20, 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 4,
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CourseScreen(),
                    // builder: (context) => CanteenManagementScreen(),
                  ),
                );
              },
              child: _buildImageCard(
                'Courses',
                'assets/course.png',
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TransportManagementScreen(),
                    // builder: (context) => CanteenManagementScreen(),
                  ),
                );
              },
              child: _buildImageCard(
                'Transport',
                'assets/bus.png',
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LibraryManagementScreen(),
                    // builder: (context) => CanteenManagementScreen(),
                  ),
                );
              },
              child: _buildImageCard(
                'Library',
                'assets/diary.png',
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    // builder: (context) => LibraryManagementScreen(),
                    builder: (context) => CanteenManagementScreen(),
                  ),
                );
              },
              child: _buildImageCard(
                'Canteen',
                'assets/burger.png',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCard(String title, String imagePath) {
    return Card(
      color: const Color.fromARGB(255, 23, 1, 26),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 8),
          Image.asset(
            imagePath,
            width: 80,
            height: 80,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
