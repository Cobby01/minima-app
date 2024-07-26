import 'package:flutter/material.dart';
import 'package:minimal_social_app/components/my_drawer.dart';

class AlertPage extends StatelessWidget {
    const AlertPage ({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alert Page'),
        centerTitle: true,
        backgroundColor:  Theme.of(context).colorScheme.inversePrimary,
        foregroundColor:   Theme.of(context).colorScheme.primary,
        elevation: 0,
      ),
      drawer: MyDrawer(),
      body: Center(
        child: Text('This is the Alert Page'),
      ),
    );
  }
}