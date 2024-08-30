import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minimal_social_app/components/my_button.dart';
import 'package:minimal_social_app/components/my_deivce_box.dart';
import 'package:minimal_social_app/components/my_textfield.dart';

import 'list_page.dart';

class AddDevicePage extends StatefulWidget {
  const AddDevicePage({super.key});

  @override
  State<AddDevicePage> createState() => _AddDevicePageState();
}

class _AddDevicePageState extends State<AddDevicePage> {
  final TextEditingController deviceNameController = TextEditingController();
  final TextEditingController deviceIDController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  List myDevices = [
    ['Person', 'assets/images/vector/Person.png', false],
    ['Bicycle', 'assets/images/vector/Bicycle.png', false],
    ['Pets', 'assets/images/vector/Pet.png', false],
    ['Vehicle', 'assets/images/vector/Vehicle.png', false],
  ];

  int selectedDeviceIndex = 0;

  @override
  void dispose() {
    deviceNameController.dispose();
    deviceIDController.dispose();
    latitudeController.dispose();
    longitudeController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  void deviceStatusChanged(bool value, int index) {
    setState(() {
      selectedDeviceIndex = index;
      myDevices[index][2] = value;
    });
  }

  Future<void> addDevice() async {
    final String deviceName = deviceNameController.text;
    final String deviceID = deviceIDController.text;
    final double latitude = double.tryParse(latitudeController.text) ?? 0.0;
    final double longitude = double.tryParse(longitudeController.text) ?? 0.0;
    final selectedDevice = myDevices[selectedDeviceIndex];
    final String phoneNumber = phoneNumberController.text;

    // Add the device to Firestore
    await FirebaseFirestore.instance.collection('devices').add({
      'deviceName': deviceName,
      'deviceID': deviceID,
      'deviceType': selectedDevice[0],
      'deviceStatus': selectedDevice[2],
      'latitude': latitude,
      'longitude': longitude,
      'lastUpdated': Timestamp.now(),
      'phoneNumber': phoneNumber,
    });

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
              const SizedBox(height: 10),
              MyTextfield(
                hintText: "Latitude",
                obscureText: false,
                controller: latitudeController,
              ),
              const SizedBox(height: 10),
              MyTextfield(
                hintText: "Longitude",
                obscureText: false,
                controller: longitudeController,
              ),
              const SizedBox(height: 10),
              MyTextfield(
                hintText: "Phone Number",
                obscureText: false,
                controller: phoneNumberController,
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
