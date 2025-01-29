import 'package:flutter/material.dart';

class DetailsTaskDisplay extends StatelessWidget {
  const DetailsTaskDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Padding(
          padding: EdgeInsets.all(16),
          child: SizedBox(
            width: 300,
            child: Table(
              columnWidths: const {
                0: FixedColumnWidth(90),
                1: FixedColumnWidth(20),
                2: FlexColumnWidth(2),
              },
              children: [
                _buildRow(['Name', ':', 'Study']),
                _buildRow(['Detail', ':', 'Learn English']),
                _buildRow(['Tanggal', ':', '30-01-2024']),
                _buildRow(['Waktu', ':', '30']),
              ],
            ),
          )),
    );
  }

  TableRow _buildRow(List<String> cells, {bool isHeader = false}) {
    return TableRow(
      children: cells.map((cell) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            cell,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        );
      }).toList(),
    );
  }
}
