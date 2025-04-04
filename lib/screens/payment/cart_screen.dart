import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/app_color.dart';
import '../../widgets/custom_button.dart';
import 'add_card_payment_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isAccepted = false;
  final TextEditingController emailController = TextEditingController();
  String selectedCardType = "";

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void _showAddCardBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return AddCardBottomSheet(
          onCardTypeSelected: (String cardType) {
            setState(() {
              selectedCardType = cardType;
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text("Cart")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              const Text(
                'Cart Items',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              CartItemWidget(
                title: "Parcel",
                subtitle: "Delivered to service point",
                price: "30",
              ),
              CartItemWidget(
                title: "Gift",
                subtitle: "Wrapped and ready for delivery",
                price: "20",
              ),
              const SizedBox(height: 10),

              const Text(
                'Contact Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              SizedBox(
                height: 45,
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email Address",
                    labelStyle: TextStyle(
                      fontSize: 14,
                      color: AppColors.secondary,
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              const Text(
                'Your receipt which includes postage codes and QR code for printing parcel label will be sent to your email address.',
                maxLines: 3,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                  color: AppColors.secondary,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Pay with',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      _showAddCardBottomSheet(context);
                    },
                    icon: Icon(
                      Icons.add,
                      size: 18,
                      color: AppColors.background,
                    ),
                    label: const Text("Add Card"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                  ),
                ],
              ),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: 10,
                  children: const [
                    PaymentOption(
                      imagePath: 'assets/images/card.png',
                      cardName: 'Gold Card',
                      amount: '1452',
                    ),

                    PaymentOption(
                      imagePath: 'assets/images/visa.png',
                      cardName: 'Silver Card',
                      amount: '1452',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              Row(
                children: [
                  Checkbox(
                    value: isAccepted,
                    onChanged: (bool? value) {
                      setState(() {
                        isAccepted = value ?? false;
                      });
                    },
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isAccepted = !isAccepted;
                        });
                      },
                      child: const Text(
                        'Yes, I Accept the Terms & Conditions',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              CustomButton(
                onPressed: isAccepted
                    ? () {
                  Get.offAllNamed('/payment-success');
                }
                    : null,
                width: double.infinity,
                borderRadius: 30,
                height: 48,
                text: 'Proceed to Payment',
                textColor: AppColors.text,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                isDisabled: false,
                hasShadow: false,
                isOutlined: false,
                color: AppColors.btnColor,
                //borderColor: AppColors.primary,
              ),

            ],
          ),
        ),
      ),
    );
  }
}

/// Widget for individual cart items
class CartItemWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;

  const CartItemWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      elevation: 3,
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: Text(
          '\u{20B9} $price',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}

/// Widget for payment options
class PaymentOption extends StatelessWidget {
  final String imagePath;
  final String cardName;
  final String amount;

  const PaymentOption({
    super.key,
    required this.imagePath,
    required this.cardName,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 2),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(imagePath, height: 50, width: 50),
          const SizedBox(height: 10),
          Text(
            cardName,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            '\u{20B9} $amount',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
