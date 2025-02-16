import 'package:flutter/material.dart';

class CustomTitleInfoCard extends StatelessWidget {
  final Widget icon;
  final String infoTitle;
  final Color color;

  const CustomTitleInfoCard({super.key, required this.icon, required this.infoTitle, this.color = Colors.blue});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10,bottom: 0),
      height: 45,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            icon,
            SizedBox(width: 8),
            Text(
              infoTitle,
              style: TextStyle(fontFamily: 'Inter',fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
