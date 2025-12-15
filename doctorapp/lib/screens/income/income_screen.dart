import 'package:flutter/material.dart';
import 'transactions_screen.dart';
import '../../widgets/income/period_selector.dart';
import '../../widgets/income/stat_card.dart';
import '../../widgets/income/income_trends_chart.dart';

class IncomeScreen extends StatefulWidget {
  const IncomeScreen({super.key});

  @override
  State<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  String selectedPeriod = 'This Month';
  final List<String> periods = [
    'Today',
    'Last week',
    'This Week',
    'Last Month',
    'This Month',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Income Report',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Track and Analyze your earnings',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter and period selector
            Row(
              children: [
                PeriodSelector(
                  selectedPeriod: selectedPeriod,
                  periods: periods,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectedPeriod = newValue;
                      });
                    }
                  },
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TransactionsScreen(),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4318FF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.receipt_long,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Transactions',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Stats cards grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1,
              children: [
                StatCard(
                  icon: Icons.attach_money,
                  iconColor: const Color(0xFF4318FF),
                  iconBgColor: const Color(0xFFE9E3FF),
                  title: 'Total Income',
                  amount: 'Rs. 140,000',
                  change: '+20%',
                  isPositive: true,
                ),
                StatCard(
                  icon: Icons.people_outline,
                  iconColor: Colors.green,
                  iconBgColor: Colors.green.withOpacity(0.1),
                  title: 'Normal',
                  amount: 'Rs. 87,500',
                  subtitle: '25 sessions',
                  change: '+15%',
                  isPositive: true,
                ),
                StatCard(
                  icon: Icons.videocam_outlined,
                  iconColor: const Color(0xFF4318FF),
                  iconBgColor: const Color(0xFFE9E3FF),
                  title: 'Teleconsultations',
                  amount: 'Rs. 52,500',
                  subtitle: '15 sessions',
                  change: '+50%',
                  isPositive: true,
                ),
                StatCard(
                  icon: Icons.trending_up,
                  iconColor: Colors.red,
                  iconBgColor: Colors.red.withOpacity(0.1),
                  title: 'Avg per Session',
                  amount: 'Rs. 3500',
                  change: '+3%',
                  isPositive: true,
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Income trends chart
            const Text(
              'Income Trends',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            const IncomeTrendsChart(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
