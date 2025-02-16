import 'package:flutter/material.dart';
import 'package:smart_device_mobile_app/product/constants/icons/icon_constants.dart';

class CustomAddDeviceButton extends StatelessWidget {
  const CustomAddDeviceButton({super.key, required this.onClicked, required this.text});

  final VoidCallback onClicked;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClicked,
      child: Container(
        height: 130,
        decoration: BoxDecoration(color: Color(0xffF6F6F6), borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Padding(
          padding: EdgeInsets.only(top: 10),
          child: Column(
            children: [
              SizedBox(
                width: 165,
                height: 82,
                child: Image.asset("assets/icons/${IconConstants.smartDevicesIconPath}.png"),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(text, style: TextStyle(fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.w600)),
                  SizedBox(width: 3),
                  IconConstants.addIcon
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
