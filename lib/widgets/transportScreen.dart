import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class TransportManagementScreen extends StatefulWidget {
  @override
  _TransportManagementScreenState createState() =>
      _TransportManagementScreenState();
}

class _TransportManagementScreenState extends State<TransportManagementScreen> {
  MapController mapController = MapController();
  List<Route> routes = [
    Route(
      student: 'Alice',
      name: 'School to Home',
      start: LatLng(10.2137, 76.4233), // Fisat Engineering College
      end: LatLng(10.2150, 76.4225), // Alice's Home (Nearby)
    ),
    Route(
      student: 'Bob',
      name: 'Friend\'s House to School',
      start: LatLng(10.2142, 76.4245), // Bob's Home (Nearby)
      end: LatLng(10.2137, 76.4233), // Fisat Engineering College
    ),
    Route(
      student: 'Keerthana',
      name: 'School to home',
      start: LatLng(10.2135, 76.4223), // Keerthana's Home (Nearby)
      end: LatLng(10.2137, 76.4233), // Fisat Engineering College
    ),
  ];

  List<String> students = ['All', 'Alice', 'Bob', 'Keerthana'];
  String selectedStudent = 'All';

  List<Route> getFilteredRoutes() {
    if (selectedStudent == 'All') {
      return routes;
    } else {
      return routes.where((route) => route.student == selectedStudent).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transport Management'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedStudent,
              onChanged: (String? student) {
                setState(() {
                  selectedStudent = student!;
                });
              },
              style: TextStyle(color: Colors.green, fontSize: 16),
              underline: Container(
                height: 2,
                color: Colors.blue,
              ),
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.blue,
              ),
              dropdownColor: Color.fromARGB(255, 20, 20, 20),
              items: students
                  .map((student) => DropdownMenuItem(
                        value: student,
                        child: Text(
                          student,
                          style: TextStyle(color: Colors.white),
                        ),
                      ))
                  .toList(),
            ),
          ),
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(10.2137,
                    76.4233), // Centered around Fisat Engineering College
                zoom: 16.0,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                PolylineLayerOptions(
                  polylines: getFilteredRoutes()
                      .map(
                        (route) => Polyline(
                          points: [
                            route.start ?? LatLng(0, 0),
                            route.end ?? LatLng(0, 0),
                          ],
                          color: route.student == 'Alice'
                              ? Colors.red
                              : Colors.blue,
                          strokeWidth: 3,
                          isDotted: route.student == 'Bob',
                        ),
                      )
                      .toList(),
                ),
                MarkerLayerOptions(
                  markers: getFilteredRoutes()
                      .map(
                        (route) => Marker(
                          width: 80.0,
                          height: 80.0,
                          point: route.start ?? LatLng(0, 0),
                          builder: (ctx) => Container(
                            child: Icon(
                              route.student == 'Keerthana'
                                  ? Icons.home
                                  : Icons.directions_bus,
                              color: route.student == 'Keerthana'
                                  ? Colors.red
                                  : Colors.blue,
                              size: 35,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
              mapController: mapController,
            ),
          ),
        ],
      ),
    );
  }
}

class Route {
  final String student;
  final String name;
  final LatLng? start;
  final LatLng? end;

  Route({
    required this.student,
    required this.name,
    this.start,
    this.end,
  });
}
