import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minimal_social_app/components/my_drawer.dart';

import 'add_device_page.dart'; // Import the AddDevicePage

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  // Method to handle switch toggle
  void _toggleDeviceStatus(bool newValue, String docId) {
    FirebaseFirestore.instance
        .collection('devices')
        .doc(docId)
        .update({'deviceStatus': newValue});
  }

  // Method to show the delete confirmation dialog
  void _showDeleteDialog(String docId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Device'),
          content: const Text('Do you want to delete this device?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                _deleteDevice(docId); // Delete the device
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                'Yes',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Method to handle device deletion
  void _deleteDevice(String docId) {
    FirebaseFirestore.instance.collection('devices').doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Page'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: const MyDrawer(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('devices').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No devices added yet.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final doc = snapshot.data!.docs[index];
              final device = doc.data() as Map<String, dynamic>;

              return ListTile(
                leading: const Icon(Icons.pin_drop),
                title: Text(device['deviceName']),
                subtitle: Text('IP: ${device['deviceID']} - Type: ${device['deviceType']}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Delete icon with confirmation dialog
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.grey),
                      onPressed: () {
                        _showDeleteDialog(doc.id);
                      },
                    ),
                    // Switch for device status
                    CupertinoSwitch(
                      value: device['deviceStatus'],
                      onChanged: (bool newValue) {
                        _toggleDeviceStatus(newValue, doc.id);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to AddDevicePage
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddDevicePage(),
            ),
          );
        },
        backgroundColor: Colors.deepPurpleAccent,
        child: const Icon(Icons.add),
      ),
    );
  }
}
