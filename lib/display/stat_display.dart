import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UsageBarChart(),
    );
  }
}

class UsageBarChart extends StatelessWidget {
  final List<double> usageData = [2, 4, 5, 3, 6, 8, 5]; // Data jam per hari
  final List apk = [
    ["Tiktok", "80"],
    ["WhatsApp", "50"],
    ["Instagram", "50"],
    ["Youtube", "30"],
    ["Facebook", "30"],
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Grafik Penggunaan HP per Minggu",
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            SizedBox(
              height: 300, // Menetapkan tinggi tertentu pada grafik batang
              child: BarChart(BarChartData(
                barGroups: _generateBarGroups(),
                titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) {
                          const days = [
                            'Sen',
                            'Sel',
                            'Rab',
                            'Kam',
                            'Jum',
                            'Sab',
                            'Min'
                          ];
                          return Text(
                            days[value.toInt()],
                            style: const TextStyle(fontSize: 12),
                          );
                        },
                        reservedSize: 30,
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles:
                            false, // Hilangkan keterangan jam di kiri chart
                      ),
                    ),
                    topTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false))),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(show: false),
                barTouchData: BarTouchData(
                  enabled:
                      true, // Nonaktifkan touch untuk menghilangkan angka di atas chart
                ),
              )),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16, bottom: 8),
              child: Text(
                "Penggunaan Hari ini",
                style: TextStyle(fontSize: 18),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: apk.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Theme.of(context).colorScheme.surface,
                    child: ListTile(
                      leading: Icon(
                        Icons.app_blocking_outlined,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      title: Text(apk[index][0]),
                      trailing: Text(
                        "${apk[index][1]} menit", // Menghapus tanda kurung kurawal
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  List<BarChartGroupData> _generateBarGroups() {
    return List.generate(
      usageData.length,
      (i) => BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: usageData[i],
            color: Colors.blue,
            width: 20,
          ),
        ],
      ),
    );
  }
}
