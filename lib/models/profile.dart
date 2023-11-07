import 'package:flutter/material.dart';
import 'package:fancy_avatar/fancy_avatar.dart';

class ProfileAvatar extends StatelessWidget {
  final IconData iconData;
  final double size;
  final Color backgroundColor;
  final Color iconColor;

  ProfileAvatar({
    required this.iconData,
    this.size = 120.0,
    this.backgroundColor = Colors.blue,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        width: size,
        height: size,
        // color: backgroundColor,
        child: Center(
          child: SizedBox(
            width: size - 8.0, // Adjust the size here based on your design
            height: size - 8.0, // Adjust the size here based on your design
            child: FancyAvatar(
              // ringColor: Colors.indigoAccent[400],
              ringColor: Colors.blue,
              spaceWidth: 4.5,
              elevation: 15.0,
              radius: (size / 2 - 4.0).round().toDouble(),
              userImage: Image.asset(
                'assets/avatar.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
