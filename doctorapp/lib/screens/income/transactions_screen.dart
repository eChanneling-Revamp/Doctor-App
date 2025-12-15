import 'package:flutter/material.dart';
import '../../widgets/share_widgets/custom_back_button.dart';
import '../../widgets/income/transaction_search_bar.dart';
import '../../widgets/income/export_buttons.dart';
import '../../widgets/income/transaction_item.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Sample transaction data
  final List<Map<String, dynamic>> transactions = List.generate(
    10,
    (index) => {
      'id': '0002025002',
      'date': '2025-12-10',
      'time': '10.30 AM',
      'hospital': 'Hemas Hospital',
      'paymentMethod': 'Bank Transfer',
      'amount': 'LKR 20,000',
      'type': 'Normal',
    },
  );

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const Text(
          'Transactions',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Blue header section with search and export buttons
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF4C40F7),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                // Search bar
                TransactionSearchBar(controller: _searchController),
                const SizedBox(height: 16),
                // Export buttons
                const ExportButtons(),
              ],
            ),
          ),

          // Transaction list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return TransactionItem(
                  id: transaction['id'],
                  date: transaction['date'],
                  time: transaction['time'],
                  hospital: transaction['hospital'],
                  paymentMethod: transaction['paymentMethod'],
                  amount: transaction['amount'],
                  type: transaction['type'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
