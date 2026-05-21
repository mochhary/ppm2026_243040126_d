import 'package:flutter/material.dart';
import 'widget_gallery.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: ProfilePage());
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile Saya',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Aksi ketika tombol edit ditekan
            },
          ),
        ],
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                "Menu",
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.widgets),
              title: const Text('Widget Gallery'),
              onTap: () {
                Navigator.pop(context); // tutup drawer dulu
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const GalleryHome()),
                );
              },
            ),
            ListTile(leading: Icon(Icons.home), title: Text('Beranda')),
            ListTile(leading: Icon(Icons.person), title: Text('Profil')),
            ListTile(leading: Icon(Icons.settings), title: Text('Pengaturan')),
            ListTile(leading: Icon(Icons.info), title: Text('Tentang')),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // === HEADER PROFIL ===
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blue,
                    child: Text(
                      '\u{1F921}', // Unicode untuk emoji jaket
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Mochammad Hari Fitrian',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Mahasiswa Teknik Informatika',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // === BARIS STATISTIK (Row + Expanded) ===
            Row(
              children: [
                Expanded(
                  child: _StatBox(label: 'Post', value: '12'),
                ),
                Expanded(
                  child: _StatBox(label: 'Teman', value: '128'),
                ),
                Expanded(
                  child: _StatBox(label: 'Like', value: '1.2K'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // === SECTION CARD ===
            _SectionCard(
              icon: Icons.info_outline,
              title: 'Tentang Saya',
              content:
                  'Saya suka belajar hal baru, terutama yang berkaitan '
                  'dengan teknologi dan musik.',
            ),
            _SectionCard(
              icon: Icons.school,
              title: 'Pendidikan',
              content: 'Universitas Pasundan - Semester 6\nIPK: 3.48',
            ),
            _SectionCard(
              icon: Icons.favorite,
              title: 'Hobi & Minat',
              content: 'Coding • Bernyanyi • Game • Musik Pop Punk',
            ),
            _SectionCard(
              icon: Icons.email,
              title: 'Kontak',
              content: 'mochammadharifitrian@gmail.com\n+62 882-294-591-45',
            ),
            _SectionCard(
              icon: Icons.star,
              title: 'Skills',
              content: 'Flutter • Dart • Laravel • Docker • Git',
            ),
            const SizedBox(height: 80), // ruang agar FAB tidak nutupi konten
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.edit),
        label: const Text('Edit'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,

        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Pesan'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
        ],
        onTap: (i) {},
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;
  const _StatBox({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.grey.shade600)),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;
  const _SectionCard({
    required this.icon,
    required this.title,
    required this.content,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.blue, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(content, style: const TextStyle(height: 1.4)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
