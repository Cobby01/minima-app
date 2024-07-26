import 'package:flutter/material.dart';
import 'package:minimal_social_app/components/my_button.dart';
import 'package:minimal_social_app/models/product.dart';
import 'package:minimal_social_app/models/shop.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

    // remove item from cart method
    void removeItemFromCart(BuildContext context, Product product) {
       showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text("Remove this item from your cart?"),
        actions: [
          // cancel button
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),

          // yes button
            MaterialButton(
            onPressed: () {
              //pop dialog box
              Navigator.pop(context);

              // add to cart
              context.read<Shop>().removeFromCart(product);

            },
            child: const Text("Yes"),
          ),
        ],
      ),
    );
    }

    // user pressed the pay button 
    void payBttonPressed(BuildContext context) {
      showDialog(
        context: context,
         builder: (context) =>  const AlertDialog(
          content: Text("User wants to pay! Connect this app to payment backend"),
         ),
      );
    }
  @override
  Widget build(BuildContext context) {

    // get access to the cart
    final cart = context.watch<Shop>().cart;

    return Scaffold(
            appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
        backgroundColor:  Theme.of(context).colorScheme.inversePrimary,
        foregroundColor:   Theme.of(context).colorScheme.primary,
      ),
    backgroundColor:  Theme.of(context).colorScheme.background,
    body: Column(
      children: [

        //cart list
        Expanded(
          child: cart.isEmpty 
          ? const Center(child: Text("Your cart is empty.. "))
          : ListView.builder(
            itemCount: cart.length,
            itemBuilder: (context, index) {
            // get individual items in cart
            final item = cart[index];

            // retuen as a cart tile UI
            return ListTile(
                title: Text(item.name),
                subtitle: Text(item.price.toStringAsFixed(2)),
                trailing: IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () => removeItemFromCart(context, item),
                ),
            );
          }
          ),
        ),

        // pay button
        Padding(
          padding: const EdgeInsets.all(50.0),
          child: MyButton(
            text: ("PAY NOW"),
             onTap: () => payBttonPressed(context),
             ),
        )
      ],
    ),
    );
  }
}