import 'package:flutter/material.dart';

class BillingHistoryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> paymentHistory = [
    {
      'title': 'Monthly Subscription',
      'amount': 499.00,
      'date': '2025-05-01',
      'status': 'Paid',
      'method': 'Credit Card',
    },
    {
      'title': 'One-time Purchase',
      'amount': 1499.00,
      'date': '2025-04-15',
      'status': 'Paid',
      'method': 'UPI',
    },
    {
      'title': 'Refund Processed',
      'amount': -499.00,
      'date': '2025-03-10',
      'status': 'Refunded',
      'method': 'Bank Transfer',
    },
  ];

  IconData _getPaymentMethodIcon(String method) {
    switch (method) {
      case 'Credit Card':
        return Icons.credit_card;
      case 'UPI':
        return Icons.phone_android;
      case 'Bank Transfer':
        return Icons.account_balance;
      default:
        return Icons.payment;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Paid':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      case 'Failed':
        return Colors.red;
      case 'Refunded':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Billing & Payment History'),
        backgroundColor: Colors.indigo,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: paymentHistory.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = paymentHistory[index];
          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Icon(
                _getPaymentMethodIcon(item['method']),
                color: Colors.indigo,
                size: 32,
              ),
              title: Text(item['title'], style: TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text('${item['date']} • ${item['method']}'),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '₹${item['amount'].toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: item['amount'] < 0 ? Colors.red : Colors.black,
                    ),
                  ),
                  Text(
                    item['status'],
                    style: TextStyle(
                      fontSize: 12,
                      color: _getStatusColor(item['status']),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
