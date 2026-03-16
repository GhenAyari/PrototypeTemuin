import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  final Color primaryPurple = const Color(0xFF735BF2);
  final Color bgPurple = const Color(0xFFFBFaff);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgPurple,
      appBar: AppBar(
        backgroundColor: bgPurple,
        elevation: 0,
        title: Text('Find Services', style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold)),
        actions: [

          IconButton(
            icon: Icon(Icons.tune, color: primaryPurple),
            onPressed: () => _showFilterModal(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: _buildSearchBar(),
          ),
          Expanded(
            child: Center(
              child: Text("Search by category, rating, or price", 
                style: GoogleFonts.poppins(color: Colors.grey)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFEDE8FF),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search for mechanics, plumbers...',
          prefixIcon: const Icon(Icons.search),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  void _showFilterModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) => _buildFilterContent(),
    );
  }

  Widget _buildFilterContent() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Filter Results", style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          _filterLabel("Experience"),
          _chipRow(["Junior", "Intermediate", "Expert (> 5yrs)"]),
          const SizedBox(height: 20),
          _filterLabel("Rating"),
          _chipRow(["⭐ 4.0+", "⭐ 4.5+", "⭐ 4.8+"]),
          const SizedBox(height: 20),
          _filterLabel("Price Range"),
          RangeSlider(values: const RangeValues(20, 80), max: 100, divisions: 10, 
            activeColor: primaryPurple, onChanged: (v){}),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: primaryPurple, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
              onPressed: () => Navigator.pop(context),
              child: const Text("Apply Filters", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterLabel(String text) => Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14));

  Widget _chipRow(List<String> labels) {
    return Wrap(spacing: 8, children: labels.map((l) => FilterChip(label: Text(l), onSelected: (v){})).toList());
  }
}