import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'widget_gallery.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ProfilePage(),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // --- STATE DATA PROFIL ---
  String name = 'Mochammad Hari Fitrian';
  String occupation = 'Mahasiswa Teknik Informatika';
  String about =
      'Saya suka belajar hal baru, terutama yang berkaitan dengan teknologi dan musik.';
  String education = 'Universitas Pasundan - Semester 6\nIPK: 3.48';
  String location = 'Bandung, Jawa Barat';
  String contact = 'mochammadharifitrian@gmail.com\n+62 882-294-591-45';
  String skills = 'Flutter • Dart • Laravel • Docker • Git';
  File? profileImage;

  // --- STATE DATA BONUS PENGALAMAN (Diberi nilai default awal kosong) ---
  String expTitle = 'Belum ada judul pengalaman';
  String expDescription =
      'Belum ada deskripsi pengalaman. Silakan tambah/edit melalui menu di samping.';
  File? expImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profil Saya',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                "Menu Utama",
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profil'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.widgets),
              title: const Text('Widget Gallery'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const GalleryHome()),
                );
              },
            ),
            // --- MENU DRAWER UNTUK EDIT/UPLOAD PENGALAMAN ---
            ListTile(
              leading: const Icon(Icons.cloud_upload),
              title: const Text('Upload Pengalaman'),
              onTap: () async {
                Navigator.pop(context);
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UploadPengalamanPage(
                      initialTitle: expTitle,
                      initialDesc: expDescription,
                      initialImage: expImage,
                    ),
                  ),
                );
                if (result != null) {
                  setState(() {
                    expTitle = result['title'].toString().isEmpty
                        ? 'Belum ada judul pengalaman'
                        : result['title'];
                    expDescription = result['desc'].toString().isEmpty
                        ? 'Belum ada deskripsi pengalaman.'
                        : result['desc'];
                    expImage = result['image'];
                  });
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Pengaturan'),
              onTap: () {},
            ),
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
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blue.shade100,
                    backgroundImage: profileImage != null
                        ? FileImage(profileImage!)
                        : null,
                    child: profileImage == null
                        ? const Text(
                            '\u{1F9E5}',
                            style: TextStyle(fontSize: 50),
                          ) // Emoji Jaket
                        : null,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    occupation,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // === BARIS STATISTIK ===
            const Row(
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

            // === SECTION CARD DATA UTAMA ===
            _SectionCard(
              icon: Icons.info_outline,
              title: 'Tentang Saya',
              content: about,
            ),
            _SectionCard(
              icon: Icons.school,
              title: 'Pendidikan',
              content: education,
            ),
            _SectionCard(
              icon: Icons.location_on,
              title: 'Lokasi',
              content: location,
            ),
            _SectionCard(icon: Icons.email, title: 'Kontak', content: contact),
            _SectionCard(icon: Icons.star, title: 'Skills', content: skills),

            // === BONUS A: CARD PENGALAMAN (KINI TERRENDER DEFAULT DI BAWAH SKILL) ===
            const SizedBox(height: 12),
            Card(
              margin: const EdgeInsets.only(bottom: 12),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(Icons.work, color: Colors.blue.shade700, size: 28),
                        const SizedBox(width: 16),
                        const Text(
                          'Pengalaman',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Render gambar jika ada, jika tidak ada render box abu-abu placeholder
                  if (expImage != null)
                    Image.file(
                      expImage!,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    )
                  else
                    Container(
                      width: double.infinity,
                      height: 150,
                      color: Colors.grey.shade200,
                      child: const Icon(
                        Icons.image_not_supported,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          expTitle,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          expDescription,
                          style: const TextStyle(
                            height: 1.4,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => EditProfilePage(
                currentName: name,
                currentAbout: about,
                currentEducation: education,
                currentLocation: location,
                currentContact: contact,
                currentSkills: skills,
                currentImage: profileImage,
              ),
            ),
          );

          if (result != null) {
            setState(() {
              name = result['name'];
              about = result['about'];
              education = result['education'];
              location = result['location'];
              contact = result['contact'];
              skills = result['skills'];
              profileImage = result['image'];
            });
          }
        },
        icon: const Icon(Icons.edit),
        label: const Text('Edit Profil'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
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

// ==========================================
// 1. HALAMAN EDIT PROFIL
// ==========================================
class EditProfilePage extends StatefulWidget {
  final String currentName;
  final String currentAbout;
  final String currentEducation;
  final String currentLocation;
  final String currentContact;
  final String currentSkills;
  final File? currentImage;

  const EditProfilePage({
    super.key,
    required this.currentName,
    required this.currentAbout,
    required this.currentEducation,
    required this.currentLocation,
    required this.currentContact,
    required this.currentSkills,
    this.currentImage,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _aboutController;
  late TextEditingController _eduController;
  late TextEditingController _locController;
  late TextEditingController _contactController;
  late TextEditingController _skillsController;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName);
    _aboutController = TextEditingController(text: widget.currentAbout);
    _eduController = TextEditingController(text: widget.currentEducation);
    _locController = TextEditingController(text: widget.currentLocation);
    _contactController = TextEditingController(text: widget.currentContact);
    _skillsController = TextEditingController(text: widget.currentSkills);
    _selectedImage = widget.currentImage;
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profil')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Foto Profil',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: _selectedImage != null
                        ? FileImage(_selectedImage!)
                        : null,
                    child: _selectedImage == null
                        ? const Icon(Icons.person, size: 50)
                        : null,
                  ),
                  TextButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.image),
                    label: const Text('Pilih Foto dari Galeri'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Informasi Profil',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nama Lengkap',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _aboutController,
              decoration: const InputDecoration(
                labelText: 'Bio/Tentang Saya',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _eduController,
              decoration: const InputDecoration(
                labelText: 'Pendidikan',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _locController,
              decoration: const InputDecoration(
                labelText: 'Lokasi',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _contactController,
              decoration: const InputDecoration(
                labelText: 'Kontak (Email / No.HP)',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _skillsController,
              decoration: const InputDecoration(
                labelText: 'Skills',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context, {
                    'name': _nameController.text,
                    'about': _aboutController.text,
                    'education': _eduController.text,
                    'location': _locController.text,
                    'contact': _contactController.text,
                    'skills': _skillsController.text,
                    'image': _selectedImage,
                  });
                },
                child: const Text(
                  'Simpan Perubahan',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// BONUS C: HALAMAN UPLOAD / EDIT PENGALAMAN
// ==========================================
class UploadPengalamanPage extends StatefulWidget {
  final String? initialTitle;
  final String? initialDesc;
  final File? initialImage;

  const UploadPengalamanPage({
    super.key,
    this.initialTitle,
    this.initialDesc,
    this.initialImage,
  });

  @override
  State<UploadPengalamanPage> createState() => _UploadPengalamanPageState();
}

class _UploadPengalamanPageState extends State<UploadPengalamanPage> {
  late TextEditingController _titleController;
  late TextEditingController _descController;
  File? _expImage;

  @override
  void initState() {
    super.initState();
    // Jika masih teks bawaan kosong, kosongkan form TextField agar user nyaman mengetik baru
    _titleController = TextEditingController(
      text: widget.initialTitle == 'Belum ada judul pengalaman'
          ? ''
          : widget.initialTitle,
    );
    _descController = TextEditingController(
      text:
          widget.initialDesc ==
              'Belum ada deskripsi pengalaman. Silakan tambah/edit melalui menu di samping.'
          ? ''
          : widget.initialDesc,
    );
    _expImage = widget.initialImage;
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _expImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Pengalaman')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Informasi Pengalaman',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Judul Pengalaman',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(
                labelText: 'Deskripsi Singkat',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 20),
            const Text(
              'Foto Pengalaman',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: _expImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(_expImage!, fit: BoxFit.cover),
                      )
                    : const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_a_photo, size: 40, color: Colors.grey),
                          SizedBox(height: 8),
                          Text(
                            'Ketuk untuk pilih gambar',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context, {
                    'title': _titleController.text,
                    'desc': _descController.text,
                    'image': _expImage,
                  });
                },
                child: const Text(
                  'Simpan Pengalaman',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// KUSTOM WIDGET PENDUKUNG
// ==========================================
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
