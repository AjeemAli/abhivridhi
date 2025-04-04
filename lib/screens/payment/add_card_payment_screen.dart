import 'package:flutter/material.dart';


class AddCardBottomSheet extends StatefulWidget {
  final Function(String) onCardTypeSelected;

  const AddCardBottomSheet({Key? key, required this.onCardTypeSelected}) : super(key: key);

  @override
  _AddCardBottomSheetState createState() => _AddCardBottomSheetState();
}

class _AddCardBottomSheetState extends State<AddCardBottomSheet> {
  String selectedCardType = "MasterCard";
  bool saveCard = false;

  final TextEditingController cardHolderNameController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Enter Your Card Details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            // Card Type Selection
            DropdownButton<String>(
              value: selectedCardType,
              items: const [
                DropdownMenuItem(value: "MasterCard", child: Text("MasterCard")),
                DropdownMenuItem(value: "Visa", child: Text("Visa")),
              ],
              onChanged: (String? value) {
                if (value != null) {
                  setState(() {
                    selectedCardType = value;
                    widget.onCardTypeSelected(value);
                  });
                }
              },
            ),

            // Card Information Inputs
            TextField(controller: cardHolderNameController, decoration: const InputDecoration(labelText: "Card Holder Name")),
            TextField(controller: cardNumberController, decoration: const InputDecoration(labelText: "Card Number")),
            TextField(controller: expiryDateController, decoration: const InputDecoration(labelText: "Expiry Date")),
            TextField(controller: cvvController, decoration: const InputDecoration(labelText: "CVV")),
            TextField(controller: countryController, decoration: const InputDecoration(labelText: "Country")),
            TextField(controller: postalCodeController, decoration: const InputDecoration(labelText: "Postal Code")),

            Row(
              children: [
                Checkbox(
                  value: saveCard,
                  onChanged: (bool? value) {
                    setState(() {
                      saveCard = value ?? false;
                    });
                  },
                ),
                const Text("Save card details"),
              ],
            ),

            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Save Card"),
            ),
          ],
        ),
      ),
    );
  }
}