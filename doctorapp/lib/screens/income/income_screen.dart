import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            Text(
              'Income Report',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Track and Analyze your earnings',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.r),
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
                            padding: EdgeInsets.all(12.r),
                            decoration: BoxDecoration(
                              color: const Color(0xFF4318FF),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Icon(
                              Icons.receipt_long,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Transactions',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),

                // Stats cards grid
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.h,
                  crossAxisSpacing: 16.w,
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
                SizedBox(height: 24.h),

                // Income trends chart
                Text(
                  'Income Trends',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 16.h),
                const IncomeTrendsChart(),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
