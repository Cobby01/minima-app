import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyDeivceBox extends StatelessWidget {
  final String deviceName;
  final String iconPath;
  final bool deviceStatus;
  void Function(bool)? onChanged;

     MyDeivceBox({
    super.key,
    required this.deviceName,
    required this.iconPath,
     required this.deviceStatus,
     required this.onChanged,
    }); 

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                
              // Icon 
              Image.asset(iconPath),
                
                
              // My device name 
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(deviceName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      ),
                    ),
                  ),
                  CupertinoSwitch(
                    value: deviceStatus,
                     onChanged: onChanged,
                     ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}