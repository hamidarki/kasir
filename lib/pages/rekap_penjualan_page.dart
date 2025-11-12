import 'package:flutter/material.dart';

class RekapPenjualanPage extends StatefulWidget {
  const RekapPenjualanPage({super.key});

  @override
  State<RekapPenjualanPage> createState() => _RekapPenjualanPageState();
}

class _RekapPenjualanPageState extends State<RekapPenjualanPage> {
  // Contoh data transaksi (tanpa database)
  final List<Map<String, dynamic>> transaksiList = [
    {
      'tanggal': DateTime(2025, 11, 10),
      'barang': 'Sabun',
      'jumlah': 3,
      'total': 15000,
    },
    {
      'tanggal': DateTime(2025, 11, 10),
      'barang': 'Pasta Gigi',
      'jumlah': 2,
      'total': 16000,
    },
    {
      'tanggal': DateTime(2025, 11, 11),
      'barang': 'Minyak Goreng',
      'jumlah': 1,
      'total': 15000,
    },
    {
      'tanggal': DateTime(2025, 11, 11),
      'barang': 'Tisu',
      'jumlah': 4,
      'total': 24000,
    },
  ];

  // Filter tanggal
  DateTime? selectedDate;

  List<Map<String, dynamic>> get filteredTransaksi {
    if (selectedDate == null) return transaksiList;
    return transaksiList.where((transaksi) {
      final tgl = transaksi['tanggal'] as DateTime;
      return tgl.year == selectedDate!.year &&
          tgl.month == selectedDate!.month &&
          tgl.day == selectedDate!.day;
    }).toList();
  }

  int get totalPendapatan {
    int total = 0;
    for (var t in filteredTransaksi) {
      total += (t['total'] as num).toInt();
    }
    return total;
  }

  // Pilih tanggal dengan date picker
  Future<void> _pilihTanggal(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2026),
      locale: const Locale('id', 'ID'),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _hapusFilter() {
    setState(() {
      selectedDate = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rekap Penjualan'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            tooltip: 'Pilih Tanggal',
            onPressed: () => (),
          ),
          if (selectedDate != null)
            IconButton(
              icon: const Icon(Icons.clear),
              tooltip: 'Hapus Filter',
              onPressed: _hapusFilter,
            ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.blue.shade50,
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  selectedDate == null
                      ? 'Menampilkan semua transaksi'
                      : 'Tanggal: ${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Total Pendapatan: Rp$totalPendapatan',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 0),
          Expanded(
            child: filteredTransaksi.isEmpty
                ? const Center(
                    child: Text(
                      'Tidak ada data penjualan untuk tanggal ini',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredTransaksi.length,
                    itemBuilder: (context, index) {
                      final transaksi = filteredTransaksi[index];
                      final tanggal = transaksi['tanggal'] as DateTime;
                      final namaBarang = transaksi['barang'].toString();
                      final jumlah = transaksi['jumlah'] as int;
                      final total = transaksi['total'] as int;

                      return Card(
                        margin:
                            const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: ListTile(
                          leading: const Icon(Icons.shopping_cart_outlined,
                              color: Colors.blue),
                          title: Text(namaBarang),
                          subtitle: Text(
                              'Jumlah: $jumlah\nTanggal: ${tanggal.day}-${tanggal.month}-${tanggal.year}'),
                          trailing: Text(
                            'Rp$total',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.black87),
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
