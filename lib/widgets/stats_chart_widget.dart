// lib/widgets/stats_chart_widget.dart
import 'package:deeptask/data/app_usage_data.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:deeptask/constant/app_color.dart';

class UsageStatsChart extends StatefulWidget {
  final List<AppUsageData> usageData;
  final String title;
  final String yText;
  final double titleFontSize; // Tambahkan parameter baru
  final double axisTitleFontSize; // Tambahkan parameter baru
  final double axisLabelFontSize; // Tambahkan parameter baru
  final double dataLabelFontSize; // Tambahkan parameter baru

  const UsageStatsChart({
    super.key,
    required this.title,
    required this.yText,
    required this.usageData,
    this.titleFontSize = 16.0, // Nilai default
    this.axisTitleFontSize = 14.0, // Nilai default
    this.axisLabelFontSize = 12.0, // Nilai default
    this.dataLabelFontSize = 12.0, // Nilai default
  });

  @override
  State<UsageStatsChart> createState() => _UsageStatsChartState();
}

class _UsageStatsChartState extends State<UsageStatsChart> {
  bool _isLabelVisible = false;

  @override
  Widget build(BuildContext context) {
    final double maxWidth = MediaQuery.of(context).size.width;
    final double chartWidth = widget.usageData.length * 90;
    final double actualWidth = chartWidth < maxWidth ? maxWidth : chartWidth;

    return GestureDetector(
      onTap: () {
        setState(() {
          _isLabelVisible = !_isLabelVisible;
        });
      },
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: actualWidth,
          child: Align(
            alignment: Alignment.centerLeft,
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(
                labelStyle: TextStyle(
                  color: AppColor.onSurface,
                  fontSize: widget.axisLabelFontSize, // Pakai parameter baru
                ),
              ),
              primaryYAxis: NumericAxis(
                title: AxisTitle(
                  text: widget.yText,
                  textStyle: TextStyle(
                    color: AppColor.onSurface,
                    fontSize: widget.axisTitleFontSize, // Pakai parameter baru
                  ),
                ),
                labelStyle: TextStyle(
                  color: AppColor.onSurface,
                  fontSize: widget.axisLabelFontSize, // Pakai parameter baru
                ),
              ),
              title: ChartTitle(
                text: widget.title,
                textStyle: TextStyle(
                  color: AppColor.onSurface,
                  fontSize: widget.titleFontSize, // Pakai parameter baru
                ),
              ),
              series: <CartesianSeries<AppUsageData, String>>[
                ColumnSeries<AppUsageData, String>(
                  dataSource: widget.usageData,
                  xValueMapper: (AppUsageData data, _) => data.packageName,
                  yValueMapper: (AppUsageData data, _) => data.usageTime,
                  dataLabelSettings: DataLabelSettings(
                    isVisible: _isLabelVisible,
                    textStyle: TextStyle(
                      color: AppColor.onSurface,
                      fontSize:
                          widget.dataLabelFontSize, // Pakai parameter baru
                    ),
                  ),
                  color: AppColor.primary,
                  width: 0.4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
