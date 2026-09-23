import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'detail.dart';

// Variabel data bersama (Global State)
final List favoriteCountries = [];
final List historyCountries = [];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State {
  late dynamic countries;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _sortBy = 'name'; // Opsi: 'name' atau 'region'

  @override
  void initState() {
    super.initState();
    countries = fetchCountries();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future fetchCountries() async {
    final uri = Uri.parse('https://www.apicountries.com/countries');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List jsonData = jsonDecode(response.body);
      return jsonData.map((j) => Country.fromJson(j)).toList();
    } else {
      throw Exception('Failed to load countries: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countries'),
        backgroundColor: const Color.fromARGB(255, 13, 105, 225),
      ),
      body: Column(
        children: [
          // Search Bar & Dropdown Sorting Benua
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Cari negara...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                      )
                          : null,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: _sortBy,
                      icon: const Icon(Icons.sort),
                      items: const [
                        DropdownMenuItem(
                          value: 'name',
                          child: Text('Nama'),
                        ),
                        DropdownMenuItem(
                          value: 'region',
                          child: Text('Benua'),
                        ),
                      ],
                      onChanged: (dynamic value) {
                        if (value != null) {
                          setState(() {
                            _sortBy = value;
                          });
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Daftar Negara
          Expanded(
            child: FutureBuilder(
              future: countries,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
                  return const Center(child: Text('No countries found'));
                }

                final List rawList = snapshot.data as List;
                List listData = rawList.where((country) {
                  return country.name
                      .toString()
                      .toLowerCase()
                      .contains(_searchQuery.toLowerCase());
                }).toList();

                if (_sortBy == 'region') {
                  listData.sort((a, b) {
                    int compareRegion = a.region.toString().compareTo(b.region.toString());
                    if (compareRegion != 0) return compareRegion;
                    return a.name.toString().compareTo(b.name.toString());
                  });
                } else {
                  listData.sort((a, b) => a.name.toString().compareTo(b.name.toString()));
                }

                if (listData.isEmpty) {
                  return const Center(
                    child: Text('Negara tidak ditemukan'),
                  );
                }

                return ListView.builder(
                  itemCount: listData.length,
                  itemBuilder: (context, i) {
                    final country = listData[i];
                    final bool isFav = favoriteCountries.any(
                          (c) => c.name == country.name,
                    );

                    return Card(
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
                          icon: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: isFav ? Colors.red : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              if (isFav) {
                                favoriteCountries.removeWhere(
                                      (c) => c.name == country.name,
                                );
                              } else {
                                favoriteCountries.add(country);
                              }
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  isFav
                                      ? '${country.name} dihapus dari favorit'
                                      : '${country.name} ditambahkan ke favorit',
                                ),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                        ),
                        onTap: () {
                          // Catat ke Riwayat secara unik (paling baru di posisi teratas)
                          historyCountries.removeWhere((c) => c.name == country.name);
                          historyCountries.insert(0, country);

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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Country {
  final String name;
  final String region;
  final String? capital;
  final int population;
  final String? flagsPng;
  final List? languages;
  final List? currencies;

  Country({
    required this.name,
    required this.region,
    required this.population,
    this.capital,
    this.flagsPng,
    this.languages,
    this.currencies,
  });

  factory Country.fromJson(Map json) {
    List? langs;
    if (json['languages'] != null) {
      langs = (json['languages'] as List)
          .map((l) => l['name'].toString())
          .toList();
    }

    List? cur;
    if (json['currencies'] != null) {
      cur = (json['currencies'] as List)
          .map((c) => c['name'].toString())
          .toList();
    }

    return Country(
      name: json['name'] ?? 'N/A',
      region: json['region'] ?? 'N/A',
      population: json['population'] ?? 0,
      capital: json['capital'],
      flagsPng: json['flags'] != null ? json['flags']['png'] : null,
      languages: langs,
      currencies: cur,
    );
  }
}