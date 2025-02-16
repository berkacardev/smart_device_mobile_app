import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_device_mobile_app/product/constants/icons/icon_constants.dart';
import 'package:smart_device_mobile_app/product/constants/lang/local_keys_tr.dart';
import 'package:smart_device_mobile_app/product/helpers/helper.dart';
import 'package:smart_device_mobile_app/product/models/smart_device/smart_device.dart';
import 'package:smart_device_mobile_app/product/themes/app_colors.dart';

class CustomSmartDeviceCard extends StatelessWidget {
  final VoidCallback onClicked;
  final SmartDevice smartDevice;
  final DateTime? dataTime;
  final bool areThereCriticalGasDanger;

  const CustomSmartDeviceCard({
    super.key,
    required this.onClicked,
    required this.smartDevice,
    required this.dataTime,
    this.areThereCriticalGasDanger = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClicked,
      child: Container(
        height: 108,
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Color(0xffF6F6F6),
          borderRadius: BorderRadius.all(Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset("assets/icons/${IconConstants.smartDustbinIconPath}.png"),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 1),
                Text(
                  LocalKeysTr.SMART_DUSTBIN,
                  style: TextStyle(fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 1),
                Text(
                  "${LocalKeysTr.LAST_UPDATE}: ${dataTime == null ? LocalKeysTr.ERROR : Helper.getTimeAgo(dataTime!)}",
                  style: TextStyle(fontFamily: 'Inter', fontSize: 13, fontWeight: FontWeight.w500),
                ),
                Row(
                  children: [
                    Text(
                      areThereCriticalGasDanger == false
                          ? LocalKeysTr.EVERYTHING_IS_NORMAL_YOUR_DEVICE
                          : LocalKeysTr.ARE_THERE_SAME_PROBLEM_YOUR_SMART_DEVICE,
                      style: TextStyle(fontFamily: 'Inter', fontSize: 13, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(width: 5),
                    Image.asset(areThereCriticalGasDanger == false
                        ? "assets/icons/${IconConstants.smileEmojiIconPath}.png"
                        : "assets/icons/${IconConstants.sadEmojiIconPath}.png")
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  static Widget loading() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 75,
                height: 82,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)), color: AppColors.EXTRAORDINARY_ABUNDANCE_OF_TINGE),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 20,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6), color: AppColors.EXTRAORDINARY_ABUNDANCE_OF_TINGE),
                      margin: EdgeInsets.only(bottom: 10),
                    ),
                    Container(
                      height: 18,
                      width: 195,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6), color: AppColors.EXTRAORDINARY_ABUNDANCE_OF_TINGE),
                      margin: EdgeInsets.only(bottom: 10),
                    ),
                    Container(
                      height: 18,
                      width: 215,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6), color: AppColors.EXTRAORDINARY_ABUNDANCE_OF_TINGE),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
