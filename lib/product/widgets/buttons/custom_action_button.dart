import 'package:flutter/material.dart';

class CustomActionButton extends StatelessWidget {
  final VoidCallback onClicked;
  final IconData icon;
  final String label;
  final Color color;
   const CustomActionButton({super.key, required this.onClicked, required this.icon, required this.label, this.color = const Color(0xffD70000)});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onClicked,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          textStyle: TextStyle(fontFamily: 'Inter',fontSize: 15, fontWeight: FontWeight.w600),
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
    );
  }
}
