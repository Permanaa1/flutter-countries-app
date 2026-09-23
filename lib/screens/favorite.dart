import 'package:flutter/material.dart';
import 'home.dart';
import 'detail.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State createState() => _FavoritePageState();
}

class _FavoritePageState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Negara Favorit'),
        backgroundColor: const Color.fromARGB(255, 13, 105, 225),
      ),
      body: favoriteCountries.isEmpty
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border, size: 70, color: Colors.grey),
            SizedBox(height: 12),
            Text(
              'Belum ada negara favorit',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      )
          : ListView.builder(
        itemCount: favoriteCountries.length,
        itemBuilder: (context, i) {
          final country = favoriteCountries[i];
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
                icon: const Icon(Icons.delete, color: Colors.red),
                tooltip: 'Hapus dari favorit',
                onPressed: () {
                  setState(() {
                    favoriteCountries.removeAt(i);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${country.name} dihapus dari favorit'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(country: country),
                  ),
                ).then((_) => setState(() {}));
              },
            ),
          );
        },
      ),
    );
  }
}