import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:deeptask/constant/app_color.dart';

class UsageStatsChart extends StatefulWidget {
  final List<AppUsageData> usageData;
  final String title;
  final String yText;

  const UsageStatsChart({
    super.key,
    required this.title,
    required this.yText,
    required this.usageData,
  });

  @override
  State<UsageStatsChart> createState() => _UsageStatsChartState();
}

class _UsageStatsChartState extends State<UsageStatsChart> {
  bool _isLabelVisible = false; // Status isVisible

  @override
  Widget build(BuildContext context) {
    // Batas maksimal lebar grafik (misalnya, lebar layar)
    final double maxWidth = MediaQuery.of(context).size.width;

    // Hitung lebar total grafik berdasarkan jumlah data
    final double chartWidth = widget.usageData.length *
        100; // Setiap batang memiliki lebar 100 (10 untuk batang + 90 untuk jarak)

    // Tentukan lebar grafik yang akan digunakan
    final double actualWidth = chartWidth < maxWidth ? maxWidth : chartWidth;

    return GestureDetector(
      onTap: () {
        // Toggle status isVisible ketika grafik diketuk
        setState(() {
          _isLabelVisible = !_isLabelVisible;
        });
      },
      child: SingleChildScrollView(
        scrollDirection:
            Axis.horizontal, // Geser secara horizontal jika diperlukan
        child: SizedBox(
          width: actualWidth, // Atur lebar grafik
          child: Align(
            alignment: Alignment.centerLeft, // Posisikan grafik di sebelah kiri
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(
                labelStyle: TextStyle(
                  color: AppColor.onSurface,
                ),
              ),
              primaryYAxis: NumericAxis(
                title: AxisTitle(
                  text: widget.yText,
                  textStyle: TextStyle(
                    color: AppColor.onSurface,
                  ),
                ),
                labelStyle: TextStyle(
                  color: AppColor.onSurface,
                ),
              ),
              title: ChartTitle(
                text: widget.title,
                textStyle: TextStyle(
                  color: AppColor.onSurface,
                ),
              ),
              series: <CartesianSeries<AppUsageData, String>>[
                ColumnSeries<AppUsageData, String>(
                  dataSource: widget.usageData,
                  xValueMapper: (AppUsageData data, _) => data.packageName,
                  yValueMapper: (AppUsageData data, _) => data.usageTime,
                  dataLabelSettings: DataLabelSettings(
                    isVisible: _isLabelVisible, // Gunakan status isVisible
                    textStyle: TextStyle(
                      color: AppColor.onSurface,
                    ),
                  ),
                  color: AppColor.primary, // Warna kolom grafik
                  width: 0.4, // Lebar batang (60% dari lebar kategori)
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppUsageData {
  final String packageName;
  final int usageTime;

  AppUsageData(this.packageName, this.usageTime);
}
