import 'package:flutter/material.dart';
import '../model/Item.dart';
import "package:provider/provider.dart";
import "../provider/shoppingcart_provider.dart";

class Checkout extends StatelessWidget {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          getItems(context),
          //moved the computation of the price to the getItems function 
          //that way it only appears when there are objects in the cart. 
          TextButton(
            child: const Text("Go back to Your Cart Catalog"),
            onPressed: () {
              Navigator.pushNamed(context, "/cart");
            },
          ),
          TextButton(
            child: const Text("Go back to Product Catalog"),
            onPressed: () {
              Navigator.pushNamed(context, "/products");
            },
          )
        ],
      ),
    );
  }

  Widget getItems(BuildContext context) {
    List<Item> products = context.watch<ShoppingCart>().cart;
    String productname = "";
    return products.isEmpty //if the products list is empty, print the text Item Details and No Items to Checkout
        ? const Flexible (child: Center(
            child: Column(
              children: [Text('Item Details'), Text('No Items to Checkout'), ],
            ),
          ))
        : Expanded(
            child: Column(
            children: [
              Flexible(
                  child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: const Icon(Icons.food_bank),
                    title: Text(products[index].name),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        productname = products[index].name;
                        context.read<ShoppingCart>().removeItem(productname);

                        if (products.isNotEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("$productname removed!"),
                            duration:
                                const Duration(seconds: 1, milliseconds: 100),
                          ));
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Cart Empty!"),
                            duration: Duration(seconds: 1, milliseconds: 100),
                          ));
                        }
                      },
                    ),
                  );
                },
              )),
              computeCost(),
            ],
          ));
  }

  Widget computeCost() {
    return Consumer<ShoppingCart>(builder: (context, cart, child) {
      return Flexible( child: Center(
          child: Column(
        children: [ //Compute Cost now also contains the button to pay and the divider to ensure the UI makes sense.
          Text("Total: ${cart.cartTotal}"),
          const Divider(height: 4, color: Colors.black),
          ElevatedButton(
              onPressed: () {
                context.read<ShoppingCart>().removeAll();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Payment Successful!"),
                  duration: Duration(seconds: 1, milliseconds: 100),
                ));
              },
              child: const Text("Pay Now!")),
        ],
      )));
    });
  }
}
