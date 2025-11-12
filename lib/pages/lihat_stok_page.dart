import 'package:flutter/material.dart';

class LihatStokPage extends StatefulWidget {
  const LihatStokPage({super.key});

  @override
  State<LihatStokPage> createState() => _LihatStokPageState();
}

class _LihatStokPageState extends State<LihatStokPage> {
  // Data stok barang (dummy)
  final List<Map<String, dynamic>> stokBarang = [
    {'nama': 'Sabun', 'jumlah': 25, 'harga': 5000},
    {'nama': 'Sampo', 'jumlah': 18, 'harga': 12000},
    {'nama': 'Pasta Gigi', 'jumlah': 15, 'harga': 8000},
    {'nama': 'Tisu', 'jumlah': 30, 'harga': 6000},
    {'nama': 'Minyak Goreng', 'jumlah': 10, 'harga': 15000},
  ];

  // Fungsi untuk menampilkan detail barang
  void _tampilkanDetail(Map<String, dynamic> barang) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(barang['nama']),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Jumlah Stok: ${barang['jumlah']}'),
            Text('Harga Satuan: Rp${barang['harga']}'),
            const SizedBox(height: 10),
            Text(
              'Total Nilai Stok: Rp${(barang['jumlah'] * barang['harga'])}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  // Hitung total semua stok (untuk ditampilkan di bawah)
  int get totalNilaiStok {
    int total = 0;
    for (var item in stokBarang) {
      total += (item['jumlah'] as int) * (item['harga'] as int);
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lihat Stok Barang'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Header total stok
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.blue.shade50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Jenis Barang: ${stokBarang.length}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  'Total Nilai Stok: Rp$totalNilaiStok',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 0),

          // Daftar stok barang
          Expanded(
            child: ListView.builder(
              itemCount: stokBarang.length,
              itemBuilder: (context, index) {
                final barang = stokBarang[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  elevation: 2,
                  child: ListTile(
                    leading: const Icon(Icons.inventory_2_rounded,
                        color: Colors.blueAccent),
                    title: Text(
                      barang['nama'].toString(),
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                        'Jumlah: ${barang['jumlah']} | Harga: Rp${barang['harga']}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.info_outline, color: Colors.grey),
                      onPressed: () => _tampilkanDetail(barang),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
