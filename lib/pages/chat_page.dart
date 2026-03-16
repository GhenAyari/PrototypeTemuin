import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String providerName;
  const ChatPage({super.key, required this.providerName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(providerName),
        backgroundColor: const Color(0xFF0D47A1),
      ),
      body: Column(
        children: [
          Expanded(child: Container(color: Colors.grey[100])), // Area pesan
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Colors.grey.shade300))),
      child: Row(
        children: [
          // Tombol Kirim Media (Gambar/Video)
          IconButton(
            icon: const Icon(Icons.add_a_photo_outlined, color: Color(0xFF0D47A1)),
            onPressed: () { /* Fungsi kirim gambar nanti di sini */ },
          ),
          IconButton(
            icon: const Icon(Icons.attach_file, color: Color(0xFF0D47A1)),
            onPressed: () { /* Fungsi kirim video/file nanti di sini */ },
          ),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(hintText: "Tulis pesan...", border: InputBorder.none),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Color(0xFF0D47A1)),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}