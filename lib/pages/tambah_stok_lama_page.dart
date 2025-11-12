import 'package:flutter/material.dart';

class TambahStokLamaPage extends StatefulWidget {
  const TambahStokLamaPage({super.key});

  @override
  State<TambahStokLamaPage> createState() => _TambahStokLamaPageState();
}

class _TambahStokLamaPageState extends State<TambahStokLamaPage> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController jumlahController = TextEditingController();

  void _tambahStok() {
    if (namaController.text.isEmpty || jumlahController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mohon isi semua kolom!')),
      );
      return;
    }

    final hasil = {
      'nama': namaController.text,
      'jumlah': int.parse(jumlahController.text),
    };

    Navigator.pop(context, hasil);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Stok Barang Lama')),
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
                labelText: 'Jumlah Tambahan',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _tambahStok,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
                child: const Text(
                  'Tambah Stok',
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
