import 'package:flutter/material.dart';

class UpcomingEventsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 20, 20, 20),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(
                'Upcoming Events', Color.fromARGB(255, 0, 69, 125)),
            SizedBox(height: 10),
            EventCard(
              title: 'Science Fair',
              date: 'November 20, 2023',
              description:
                  'Annual science fair showcasing projects from students.',
            ),
            EventCard(
              title: 'Mathematics Olympiad',
              date: 'December 5, 2023',
              description:
                  'National-level math competition for high school students.',
            ),
            // Add more EventCard widgets for other events...

            SizedBox(height: 20),

            _buildSectionTitle(
                'Upcoming Exams', Color.fromARGB(255, 0, 69, 125)),
            SizedBox(height: 10),
            ExamCard(
              title: 'Physics Exam',
              date: 'November 25, 2023',
              subject: 'Physics',
            ),
            ExamCard(
              title: 'English Literature Exam',
              date: 'December 10, 2023',
              subject: 'English',
            ),
            // Add more ExamCard widgets for other exams...
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final String title;
  final String date;
  final String description;

  EventCard({
    required this.title,
    required this.date,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      color: Color.fromARGB(255, 35, 35, 35),
      child: ListTile(
        trailing: Image.asset('assets/trophy.png'),
        title: Text(
          title,
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Date: $date',
              style: TextStyle(color: Colors.yellow),
            ),
            Text(
              'Description: $description',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class ExamCard extends StatelessWidget {
  final String title;
  final String date;
  final String subject;

  ExamCard({
    required this.title,
    required this.date,
    required this.subject,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      color: Color.fromARGB(255, 35, 35, 35),
      child: ListTile(
        trailing: Image.asset('assets/exam.png'),
        title: Text(
          title,
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Date: $date',
              style: TextStyle(color: Colors.red),
            ),
            Text(
              'Subject: $subject',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
