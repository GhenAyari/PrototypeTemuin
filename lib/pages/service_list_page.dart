import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../widgets/provider_card.dart';

class ServiceListPage extends StatelessWidget {
  final String categoryName;

  const ServiceListPage({Key? key, required this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Filter data berdasarkan kategori yang dipilih
    final filteredProviders = dummyProviders.where((p) => p.category == categoryName).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Jasa $categoryName'),
      ),
      body: filteredProviders.isEmpty
          ? const Center(child: Text('Belum ada penyedia jasa di kategori ini.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredProviders.length,
              itemBuilder: (context, index) {
                return ProviderCard(provider: filteredProviders[index]);
              },
            ),
    );
  }
}