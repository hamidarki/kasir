import 'package:flutter/material.dart';

class InputBarangBaruPage extends StatefulWidget {
  const InputBarangBaruPage({super.key});

  @override
  State<InputBarangBaruPage> createState() => _InputBarangBaruPageState();
}

class _InputBarangBaruPageState extends State<InputBarangBaruPage> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController jumlahController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();

  void _simpanBarang() {
    if (namaController.text.isEmpty ||
        jumlahController.text.isEmpty ||
        hargaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mohon isi semua kolom!')),
      );
      return;
    }

    final barang = {
      'nama': namaController.text,
      'jumlah': int.parse(jumlahController.text),
      'harga': int.parse(hargaController.text),
    };

    Navigator.pop(context, barang);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Input Barang Baru')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: namaController,
              decoration: const InputDecoration(
                labelText: 'Nama Barang',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: jumlahController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Jumlah',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: hargaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Harga Satuan',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _simpanBarang,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text(
                  'Simpan Barang',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
