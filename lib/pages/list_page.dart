import 'package:flutter/material.dart';
import 'package:minimal_social_app/components/my_drawer.dart';

class ListPage extends StatelessWidget {
    const ListPage ({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Page'),
        centerTitle: true,
        backgroundColor:  Theme.of(context).colorScheme.inversePrimary,
        foregroundColor:   Theme.of(context).colorScheme.primary,
      ),
      drawer: const MyDrawer(),
      body: Center(
        child: Text('This is the List Page'),
      ),
    );
  }
}