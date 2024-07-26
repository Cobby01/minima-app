import 'package:flutter/material.dart';
import 'package:minimal_social_app/components/my_drawer.dart';
import 'package:minimal_social_app/components/my_product_tile.dart';
import 'package:minimal_social_app/models/shop.dart';
import 'package:provider/provider.dart';


class ShopPage extends StatelessWidget {
  const ShopPage ({super.key});
  @override
  Widget build(BuildContext context) {

    // access product in shop
    final products = context.watch<Shop>().shop;

    return Scaffold(
      appBar: AppBar(
        title: const  Text('Shop Page'),
        centerTitle: true,
        backgroundColor:  Theme.of(context).colorScheme.inversePrimary,
        foregroundColor:   Theme.of(context).colorScheme.primary,
        actions: [
          // go to cart button
          IconButton(
              onPressed: () => Navigator.pushNamed(context, '/cart_page'),
              icon: const Icon(Icons.shopping_cart_outlined))
        ],
      ),
       drawer: const MyDrawer(),
       body: ListView(
        children: [
          const SizedBox(height: 25),

          // shop subtitle
          Center(child: Text(
            "Pick from a selected list of premium products",
            style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
        ),


          // product list 
        SizedBox(
          height: 550,
          child: ListView.builder(
           itemCount: products.length,
           scrollDirection: Axis.horizontal,
           padding: const EdgeInsets.all(15),
           itemBuilder: (context, index){
             // get each individual product from shop
             final product = products[index];
         
             // return as a product tile UI
             return MyProductTile(product: product);
         
            },
          ),
        ),
      ],
     ),  
    );
  }
} 