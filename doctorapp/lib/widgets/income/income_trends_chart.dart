import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'chart_legend.dart';

class IncomeTrendsChart extends StatelessWidget {
  const IncomeTrendsChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ChartLegend(color: Colors.blue, label: 'Normal'),
              SizedBox(width: 24.w),
              const ChartLegend(
                color: Colors.purple,
                label: 'Teleconsultation',
              ),
            ],
          ),
          SizedBox(height: 20.h),
          SizedBox(
            height: 250.h,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 50000,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(color: Colors.grey[200], strokeWidth: 1.r);
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30.h,
                      interval: 1,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        final style = TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                        );
                        Widget text;
                        switch (value.toInt()) {
                          case 0:
                            text = Text('week 1', style: style);
                            break;
                          case 1:
                            text = Text('week 2', style: style);
                            break;
                          case 2:
                            text = Text('Week 3', style: style);
                            break;
                          case 3:
                            text = Text('week 4', style: style);
                            break;
                          default:
                            text = Text('', style: style);
                            break;
                        }
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: text,
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 50000,
                      reservedSize: 42.w,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        final style = TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                        );
                        String text;
                        if (value == 0) {
                          text = '0';
                        } else if (value == 50000) {
                          text = '50k';
                        } else if (value == 100000) {
                          text = '100k';
                        } else if (value == 150000) {
                          text = '150k';
                        } else {
                          return Container();
                        }
                        return Text(
                          text,
                          style: style,
                          textAlign: TextAlign.left,
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: 3,
                minY: 0,
                maxY: 150000,
                lineBarsData: [
                  // Normal line (blue)
                  LineChartBarData(
                    spots: [
                      const FlSpot(0, 90000),
                      const FlSpot(1, 95000),
                      const FlSpot(2, 100000),
                      const FlSpot(3, 130000),
                    ],
                    isCurved: true,
                    color: Colors.blue,
                    barWidth: 3.r,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 4.r,
                          color: Colors.blue,
                          strokeWidth: 2.r,
                          strokeColor: Colors.white,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(show: false),
                  ),
                  // Teleconsultation line (purple)
                  LineChartBarData(
                    spots: [
                      const FlSpot(0, 45000),
                      const FlSpot(1, 60000),
                      const FlSpot(2, 55000),
                      const FlSpot(3, 95000),
                    ],
                    isCurved: true,
                    color: Colors.purple,
                    barWidth: 3.r,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 4.r,
                          color: Colors.purple,
                          strokeWidth: 2.r,
                          strokeColor: Colors.white,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
