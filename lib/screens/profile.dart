import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final VoidCallback? onHomeTap;
  const ProfilePage({super.key, this.onHomeTap});

  // Data Anggota Kelompok 2 (Shift 1)
  final teamMembers = const [
    {
      'Nama': 'Ryan Gabriel Marsiamto',
      'NIM': '21120124120021',
      'Foto': 'https://picsum.photos/seed/ryan/300/300',
    },
    {
      'Nama': 'Raditya Gilang Daneshworo',
      'NIM': '21120124140116',
      'Foto': 'https://picsum.photos/seed/raditya/300/300',
    },
    {
      'Nama': 'Razzaq Permana',
      'NIM': '21120123120016',
      'Foto': 'https://picsum.photos/seed/razzaq/300/300',
    },
    {
      'Nama': 'Bagus Ariiq Ambiya',
      'NIM': '21120124140151',
      'Foto': 'https://picsum.photos/seed/bagus/300/300',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Kelompok 2'),
        backgroundColor: const Color.fromARGB(255, 13, 105, 225),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: onHomeTap,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Wadah Foto Bersama Kelompok
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  Image.network(
                    'https://picsum.photos/seed/kelompok2shift1/800/400',
                    height: 190,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 190,
                      color: Colors.grey.shade300,
                      child: const Center(
                        child: Icon(Icons.groups, size: 64, color: Colors.grey),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    color: const Color.fromARGB(255, 13, 105, 225),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: const Text(
                      'FOTO BERSAMA KELOMPOK 2 — SHIFT 1',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24.0),

            // Judul Bagian Anggota
            const Text(
              'Daftar Anggota Kelompok',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12.0),

            // 2. Grid Foto & Identitas Masing-Masing Anggota
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: teamMembers.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                childAspectRatio: 0.80,
              ),
              itemBuilder: (context, index) {
                final member = teamMembers[index];
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 36,
                          backgroundColor: Colors.grey.shade200,
                          backgroundImage: NetworkImage(member['Foto']!),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          member['Nama'] ?? 'No Name',
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13.0,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          member['NIM'] ?? 'No NIM',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}