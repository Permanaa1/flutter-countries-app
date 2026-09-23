import 'package:flutter/material.dart';
import 'home.dart';
import 'detail.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State createState() => _HistoryPageState();
}

class _HistoryPageState extends State {
  // Fitur Hard Delete: Menghapus permanen seluruh riwayat
  void _hardDeleteAllHistory() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hard Delete Riwayat'),
        content: const Text(
          'Apakah Anda yakin ingin menghapus seluruh riwayat secara permanen? Data yang dihapus tidak dapat dipulihkan.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() {
                historyCountries.clear(); // Hard delete: mengosongkan list secara permanen
              });
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Seluruh riwayat berhasil dihapus permanen!'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text('Hapus Permanen', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Kunjungan'),
        backgroundColor: const Color.fromARGB(255, 13, 105, 225),
        actions: [
          if (historyCountries.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_forever),
              tooltip: 'Hard Delete Seluruh Riwayat',
              onPressed: _hardDeleteAllHistory,
            ),
        ],
      ),
      body: historyCountries.isEmpty
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history, size: 70, color: Colors.grey),
            SizedBox(height: 12),
            Text(
              'Belum ada riwayat negara yang dibuka',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      )
          : ListView.builder(
        itemCount: historyCountries.length,
        itemBuilder: (context, i) {
          final country = historyCountries[i];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: country.flagsPng != null
                  ? Image.network(
                country.flagsPng!,
                width: 50,
                errorBuilder: (context, error, stackTrace) =>
                const SizedBox(
                  width: 50,
                  child: Icon(Icons.broken_image, size: 24),
                ),
              )
                  : const SizedBox(width: 50),
              title: Text(country.name),
              subtitle: Text('Benua: ${country.region}'),
              trailing: IconButton(
                icon: const Icon(Icons.close, color: Colors.grey),
                tooltip: 'Hapus dari riwayat',
                onPressed: () {
                  setState(() {
                    historyCountries.removeAt(i);
                  });
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(country: country),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}