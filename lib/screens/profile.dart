import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final VoidCallback? onHomeTap;
  const ProfilePage({super.key, this.onHomeTap});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List<Map<String, String>> teamMembers = [
    {
      'Nama': 'Ryan Gabriel Marsiamto',
      'NIM': '21120124120021',
    },
    {
      'Nama': 'Raditya Gilang Daneshworo',
      'NIM': '21120124140116',
    },
    {
      'Nama': 'Razzaq Permana',
      'NIM': '21120123120016',
    },
    {
      'Nama': 'Bagus Ariiq Ambiya',
      'NIM': '21120124140151',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Kelompok 2'),
        backgroundColor: const Color.fromARGB(255, 13, 105, 225),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: widget.onHomeTap,
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: FractionallySizedBox(
              alignment: Alignment.topCenter,
              heightFactor: 0.45,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    image: NetworkImage(
                      'https://picsum.photos/1200/800',
                    ),
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3.0),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          'https://api.dicebear.com/7.x/bottts/png?seed=Kelompok2',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade900.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Shift 1 - Kelompok 2',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        children: [
                          for (var member in teamMembers) ...[
                            ListTile(
                              leading: const CircleAvatar(
                                backgroundColor: Color.fromARGB(255, 13, 105, 225),
                                child: Icon(Icons.person, color: Colors.white),
                              ),
                              title: Text(
                                member['Nama'] ?? 'No Name',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0,
                                ),
                              ),
                              subtitle: Text(
                                member['NIM'] ?? 'No NIM',
                                style: TextStyle(color: Colors.grey.shade700),
                              ),
                            ),
                            if (member != teamMembers.last)
                              const Divider(height: 1, indent: 16, endIndent: 16),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}