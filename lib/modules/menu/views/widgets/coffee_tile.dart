import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../cart/controllers/cart_controller.dart';

class CoffeeTile extends StatefulWidget {
  final dynamic coffee;

  const CoffeeTile({
    super.key,
    required this.coffee,
  });

  @override
  State<CoffeeTile> createState() => _CoffeeTileState();
}

class _CoffeeTileState extends State<CoffeeTile> {
  bool pressed = false;

  final cart = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 180),
      transform: Matrix4.identity()..scale(pressed ? 0.97 : 1.0),
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.brown.shade50,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.shade200.withAlpha(77),
            blurRadius: 6,
            offset: Offset(2, 2),
          )
        ],
      ),
      child: Row(
        children: [
          // FULL TILE TAP AREA (EXCEPT CART BUTTON)
          Expanded(
            child: InkWell(
              onTapDown: (_) => setState(() => pressed = true),
              onTapCancel: () => setState(() => pressed = false),
              onTapUp: (_) => setState(() => pressed = false),
              onTap: () {
                Get.toNamed(
                  '/coffee-details',
                  arguments: widget.coffee.id,
                );
              },
              child: Row(
                children: [
                  Hero(
                    tag: "coffee_${widget.coffee.name}",
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        widget.coffee.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown.shade800,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    "\$${widget.coffee.price.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(width: 12),

          // CART BUTTON (Does NOT trigger navigation)
          IconButton(
            icon: Icon(Icons.add_shopping_cart, color: Colors.brown.shade700),
            onPressed: () {
              cart.addToCart(widget.coffee);
            },
          ),
        ],
      ),
    );
  }
}
