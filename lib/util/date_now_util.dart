import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateNowUtil extends StatefulWidget {
  final double? fontSize;
  const DateNowUtil({super.key, required this.fontSize});

  @override
  State<DateNowUtil> createState() => _DateNowUtilState();
}

class _DateNowUtilState extends State<DateNowUtil> {
  String _dateNow = '';

  @override
  void initState() {
    super.initState();
    _updateTanggal(); // Memanggil fungsi untuk mengupdate tanggal saat widget diinisialisasi
  }

  void _updateTanggal() {
    setState(() {
      _dateNow = DateFormat('d MMM, EEEE', 'id_ID').format(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _dateNow,
      style: TextStyle(
        fontSize: widget.fontSize, // Sesuaikan ukuran teks
      ),
    );
  }
}
