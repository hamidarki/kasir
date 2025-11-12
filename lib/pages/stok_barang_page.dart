import 'package:flutter/material.dart';
import 'input_barang_baru_page.dart';
import 'tambah_stok_lama_page.dart';

class StokBarangPage extends StatefulWidget {
  const StokBarangPage({super.key});

  @override
  State<StokBarangPage> createState() => _StokBarangPageState();
}

class _StokBarangPageState extends State<StokBarangPage> {
  // List untuk menyimpan data barang (sederhana, tanpa database)
  List<Map<String, dynamic>> daftarBarang = [];

  // Fungsi menerima data barang baru dari halaman Input
  void _tambahBarangBaru(Map<String, dynamic> barang) {
    setState(() {
      daftarBarang.add(barang);
    });
  }

  // Fungsi menambah stok barang lama
  void _tambahStokLama(String namaBarang, int jumlahTambah) {
    setState(() {
      for (var item in daftarBarang) {
        if (item['nama'] == namaBarang) {
          item['jumlah'] += jumlahTambah;
          return;
        }
      }
      // Jika barang belum ada, bisa tampilkan pesan
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Barang "$namaBarang" belum terdaftar!')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stok Barang'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Tombol Input Barang Baru
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: const Icon(Icons.add_box, color: Colors.white),
                label: const Text('Input Stok Barang Baru'),
                onPressed: () async {
                  final barangBaru = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InputBarangBaruPage(),
                    ),
                  );
                  if (barangBaru != null) {
                    _tambahBarangBaru(barangBaru);
                  }
                },
              ),
            ),
            const SizedBox(height: 12),

            // Tombol Tambah Stok Lama
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: const Icon(Icons.add_shopping_cart, color: Colors.white),
                label: const Text('Tambah Stok Barang Lama'),
                onPressed: () async {
                  final hasil = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TambahStokLamaPage(),
                    ),
                  );
                  if (hasil != null) {
                    _tambahStokLama(hasil['nama'], hasil['jumlah']);
                  }
                },
              ),
            ),

            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 10),

            // Daftar Barang
            Expanded(
              child: daftarBarang.isEmpty
                  ? const Center(
                      child: Text(
                        'Belum ada data barang',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: daftarBarang.length,
                      itemBuilder: (context, index) {
                        final item = daftarBarang[index];
                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.inventory_2_outlined,
                                color: Colors.blue),
                            title: Text(item['nama']),
                            subtitle: Text('Jumlah: ${item['jumlah']}'),
                            trailing:
                                Text('Rp${item['harga']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
