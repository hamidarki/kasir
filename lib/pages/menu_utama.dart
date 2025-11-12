import 'package:flutter/material.dart';
import 'login_page.dart';
import 'stok_barang_page.dart';
import 'kasir_page.dart';
import 'rekap_penjualan_page.dart';
import 'lihat_stok_page.dart';

class MenuUtama extends StatelessWidget {
  const MenuUtama({super.key});

  Widget buildMenuButton({
    required Color color,
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white, size: 24),
        label: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _logout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
        title: const Text(
          '📌 Menu Utama',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            onPressed: () => _logout(context),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildMenuButton(
            color: Colors.blue,
            icon: Icons.inventory_2_rounded,
            text: 'Stok Barang',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const StokBarangPage()),
              );
            },
          ),
          buildMenuButton(
            color: Colors.green,
            icon: Icons.attach_money_rounded,
            text: 'Kasir',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const KasirPage()),
              );
            },
          ),
          buildMenuButton(
            color: Colors.orange,
            icon: Icons.bar_chart_rounded,
            text: 'Rekap Penjualan',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RekapPenjualanPage()),
              );
            },
          ),
          buildMenuButton(
            color: Colors.purple,
            icon: Icons.inventory_rounded,
            text: 'Lihat Stok',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LihatStokPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
