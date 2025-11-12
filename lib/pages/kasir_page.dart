import 'package:flutter/material.dart';

class KasirPage extends StatefulWidget {
  const KasirPage({super.key});

  @override
  State<KasirPage> createState() => _KasirPageState();
}

class _KasirPageState extends State<KasirPage> {
  // Contoh data barang (dummy) — pastikan harga adalah int/num
  final List<Map<String, dynamic>> barangToko = [
    {'nama': 'Sabun', 'harga': 5000},
    {'nama': 'Sampo', 'harga': 12000},
    {'nama': 'Pasta Gigi', 'harga': 8000},
    {'nama': 'Tisu', 'harga': 6000},
    {'nama': 'Minyak Goreng', 'harga': 15000},
  ];

  // Keranjang belanja
  List<Map<String, dynamic>> keranjang = [];

  // Hitung total harga — gunakan `num` sementara lalu konversi ke int
  int get totalBayar {
    num total = 0;
    for (var item in keranjang) {
      // Pastikan harga dan jumlah diperlakukan sebagai num lalu dikonversi saat penjumlahan
      final num harga = (item['harga'] as num);
      final num jumlah = (item['jumlah'] as num);
      total += harga * jumlah;
    }
    return total.toInt();
  }

  // Tambahkan barang ke keranjang
  void _tambahKeKeranjang(Map<String, dynamic> barang) {
    setState(() {
      final String nama = barang['nama'].toString();
      final int harga = (barang['harga'] as num).toInt();

      final index = keranjang.indexWhere((item) => item['nama'] == nama);
      if (index >= 0) {
        // pastikan jumlah adalah int
        keranjang[index]['jumlah'] = (keranjang[index]['jumlah'] as int) + 1;
      } else {
        keranjang.add({'nama': nama, 'harga': harga, 'jumlah': 1});
      }
    });
  }

  // Kurangi jumlah barang dari keranjang
  void _kurangiDariKeranjang(Map<String, dynamic> barang) {
    setState(() {
      final index = keranjang.indexWhere((item) => item['nama'] == barang['nama']);
      if (index >= 0) {
        final current = keranjang[index]['jumlah'] as int;
        if (current > 1) {
          keranjang[index]['jumlah'] = current - 1;
        } else {
          keranjang.removeAt(index);
        }
      }
    });
  }

  // Reset transaksi
  void _selesaiTransaksi() {
    if (keranjang.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Keranjang masih kosong!')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi'),
        content: Text('Total pembayaran: Rp${totalBayar}\nApakah transaksi selesai?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                keranjang.clear();
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Transaksi selesai!')),
              );
            },
            child: const Text('Ya'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Kasir'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Daftar barang toko
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Daftar Barang',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    const Divider(),
                    Expanded(
                      child: ListView.builder(
                        itemCount: barangToko.length,
                        itemBuilder: (context, index) {
                          final barang = barangToko[index];
                          return ListTile(
                            leading: const Icon(Icons.shopping_bag_outlined),
                            title: Text(barang['nama'].toString()),
                            subtitle: Text('Rp${(barang['harga'] as num).toInt()}'),
                            trailing: IconButton(
                              icon: const Icon(Icons.add_circle, color: Colors.green),
                              onPressed: () => _tambahKeKeranjang(barang),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Keranjang belanja
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Keranjang Belanja',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    const Divider(),
                    Expanded(
                      child: keranjang.isEmpty
                          ? const Center(
                              child: Text(
                                'Keranjang masih kosong',
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                          : ListView.builder(
                              itemCount: keranjang.length,
                              itemBuilder: (context, index) {
                                final item = keranjang[index];
                                final int harga = (item['harga'] as num).toInt();
                                final int jumlah = (item['jumlah'] as num).toInt();
                                return ListTile(
                                  title: Text(item['nama'].toString()),
                                  subtitle: Text('Rp$harga x $jumlah = Rp${harga * jumlah}'),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove_circle, color: Colors.red),
                                        onPressed: () => _kurangiDariKeranjang(item),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.add_circle, color: Colors.green),
                                        onPressed: () => _tambahKeKeranjang(item),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Text(
                            'Total: Rp${totalBayar}',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton.icon(
                              onPressed: _selesaiTransaksi,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                              ),
                              icon: const Icon(Icons.payment, color: Colors.white),
                              label: const Text(
                                'Selesai Transaksi',
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
