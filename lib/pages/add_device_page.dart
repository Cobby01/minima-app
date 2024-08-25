import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minimal_social_app/components/my_button.dart';
import 'package:minimal_social_app/components/my_deivce_box.dart';
import 'package:minimal_social_app/components/my_textfield.dart';

import 'list_page.dart';  // Import the ListPage

class AddDevicePage extends StatefulWidget {
  const AddDevicePage({super.key});

  @override
  State<AddDevicePage> createState() => _AddDevicePageState();
}

class _AddDevicePageState extends State<AddDevicePage> {
  // Controllers for the text fields
  final TextEditingController deviceNameController = TextEditingController();
  final TextEditingController deviceIDController = TextEditingController();

  // List of devices
  List myDevices = [
    ['Person', 'assets/images/vector/Person.png', false],
    ['Bicycle', 'assets/images/vector/Bicycle.png', false],
    ['Pets', 'assets/images/vector/Pet.png', false],
    ['Vehicle', 'assets/images/vector/Vehicle.png', false],
  ];

  // Selected device type index
  int selectedDeviceIndex = 0;

  // Power button switched
  void deviceStatusChanged(bool value, int index) {
    setState(() {
      selectedDeviceIndex = index;
      myDevices[index][2] = value;
    });
  }

  // Add device method
  Future<void> addDevice() async {
    // Capture the current input values
    final String deviceName = deviceNameController.text;
    final String deviceIP = deviceIDController.text;
    final selectedDevice = myDevices[selectedDeviceIndex];

    // Add the device to Firestore
    await FirebaseFirestore.instance.collection('devices').add({
      'deviceName': deviceName,
      'deviceIP': deviceIP,
      'deviceType': selectedDevice[0],
      'deviceStatus': selectedDevice[2],
    });

    // Navigate to the ListPage
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ListPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Device'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const Row(
                children: [
                  Text(
                    'Device Details',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Add device text fields
              MyTextfield(
                hintText: "Device Name",
                obscureText: false,
                controller: deviceNameController,
              ),
              const SizedBox(height: 10),
              MyTextfield(
                hintText: "Device ID",
                obscureText: false,
                controller: deviceIDController,
              ),
              const SizedBox(height: 25),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Type",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: myDevices.length,
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.1,
                  ),
                  itemBuilder: (context, index) {
                    return MyDeivceBox(
                      deviceName: myDevices[index][0],
                      iconPath: myDevices[index][1],
                      deviceStatus: myDevices[index][2],
                      onChanged: (value) => deviceStatusChanged(value, index),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              // Add Device button
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: MyButton(
                  text: "Add Device",
                  onTap: addDevice,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
