import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// === MODEL DATA ===
class Catatan {
  final String id;
  final String judul;
  final String email;
  final String isi;
  final String kategori;
  final DateTime dibuatPada;

  Catatan({
    required this.id,
    required this.judul,
    required this.email,
    required this.isi,
    required this.kategori,
    required this.dibuatPada,
  });
}

// === APP UTAMA ===
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catatan Mahasiswa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      initialRoute: '/',
      routes: {'/': (context) => const HomePage()},
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/tambah':
            final catatanToEdit = settings.arguments as Catatan?;
            return MaterialPageRoute(
              builder: (_) => TambahCatatanPage(catatanToEdit: catatanToEdit),
            );
          case '/detail':
            final catatan = settings.arguments as Catatan;
            return MaterialPageRoute(
              builder: (_) => DetailCatatanPage(catatan: catatan),
            );
        }
        return null;
      },
    );
  }
}

// === HALAMAN HOME ===
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Catatan> _catatan = [
    Catatan(
      id: '1',
      judul: 'Belajar Flutter',
      email: 'mahasiswa@kampus.ac.id',
      isi: 'Mempelajari Stateful Widget, Form, dan Navigation.',
      kategori: 'Kuliah',
      dibuatPada: DateTime.now(),
    ),
  ];

  String _kategoriFilter = 'Semua';
  final List<String> _opsiFilter = [
    'Semua',
    'Kuliah',
    'Tugas',
    'Pribadi',
    'Lainnya',
  ];

  Future<void> _bukaTambahCatatan() async {
    final hasil = await Navigator.pushNamed(context, '/tambah');

    if (hasil is Catatan) {
      setState(() => _catatan.add(hasil));
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Catatan "${hasil.judul}" ditambahkan')),
      );
    }
  }

  void _hapusCatatan(int index) {
    setState(() {
      _catatan.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final catatanDifilter = _catatan.where((c) {
      if (_kategoriFilter == 'Semua') return true;
      return c.kategori == _kategoriFilter;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catatan Mahasiswa'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _kategoriFilter,
                icon: const Icon(Icons.filter_list, color: Colors.black87),
                onChanged: (String? newValue) {
                  setState(() {
                    _kategoriFilter = newValue!;
                  });
                },
                items: _opsiFilter.map<DropdownMenuItem<String>>((
                  String value,
                ) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
      body: catatanDifilter.isEmpty
          ? const Center(child: Text('Tidak ada catatan untuk kategori ini'))
          : ListView.builder(
              itemCount: catatanDifilter.length,
              itemBuilder: (context, i) {
                final c = catatanDifilter[i];
                final originalIndex = _catatan.indexWhere(
                  (element) => element.id == c.id,
                );

                return ListTile(
                  // Ikon Titik Tiga (PopupMenuButton) di Kiri
                  leading: PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert),
                    onSelected: (value) async {
                      if (value == 'edit') {
                        // Pindah ke halaman edit jika opsi "Edit" ditekan
                        final updatedCatatan = await Navigator.pushNamed(
                          context,
                          '/tambah',
                          arguments: c,
                        );
                        if (updatedCatatan is Catatan) {
                          setState(() {
                            final idx = _catatan.indexWhere(
                              (element) => element.id == updatedCatatan.id,
                            );
                            if (idx != -1) _catatan[idx] = updatedCatatan;
                          });
                        }
                      }
                    },
                    itemBuilder: (context) => [
                      // Isi dari pop-up menu
                      const PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit, size: 20, color: Colors.indigo),
                            SizedBox(width: 8),
                            Text('Edit Catatan'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  title: Text(c.judul),
                  subtitle: Text('${c.kategori} • ${c.email}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _hapusCatatan(originalIndex),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/detail', arguments: c);
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _bukaTambahCatatan,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// === HALAMAN TAMBAH / EDIT CATATAN ===
class TambahCatatanPage extends StatefulWidget {
  final Catatan? catatanToEdit;

  const TambahCatatanPage({super.key, this.catatanToEdit});

  @override
  State<TambahCatatanPage> createState() => _TambahCatatanPageState();
}

class _TambahCatatanPageState extends State<TambahCatatanPage> {
  final _formKey = GlobalKey<FormState>();
  final _judulCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _isiCtrl = TextEditingController();

  String _kategori = 'Kuliah';
  final _kategoriOpsi = const ['Kuliah', 'Tugas', 'Pribadi', 'Lainnya'];

  @override
  void initState() {
    super.initState();
    if (widget.catatanToEdit != null) {
      _judulCtrl.text = widget.catatanToEdit!.judul;
      _emailCtrl.text = widget.catatanToEdit!.email;
      _isiCtrl.text = widget.catatanToEdit!.isi;
      _kategori = widget.catatanToEdit!.kategori;
    }
  }

  @override
  void dispose() {
    _judulCtrl.dispose();
    _emailCtrl.dispose();
    _isiCtrl.dispose();
    super.dispose();
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) return;

    final catatanBaru = Catatan(
      id:
          widget.catatanToEdit?.id ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      judul: _judulCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      isi: _isiCtrl.text.trim(),
      kategori: _kategori,
      dibuatPada: widget.catatanToEdit?.dibuatPada ?? DateTime.now(),
    );

    Navigator.pop(context, catatanBaru);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.catatanToEdit != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Catatan' : 'Tambah Catatan')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _judulCtrl,
              decoration: const InputDecoration(
                labelText: 'Judul',
                prefixIcon: Icon(Icons.title),
                border: OutlineInputBorder(),
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Judul wajib diisi';
                if (v.trim().length < 3) return 'Minimal 3 karakter';
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailCtrl,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email Pengirim',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Email wajib diisi';
                final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                if (!emailRegex.hasMatch(v)) {
                  return 'Format email tidak valid (contoh: nama@email.com)';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _kategori,
              decoration: const InputDecoration(
                labelText: 'Kategori',
                prefixIcon: Icon(Icons.category),
                border: OutlineInputBorder(),
              ),
              items: _kategoriOpsi
                  .map((k) => DropdownMenuItem(value: k, child: Text(k)))
                  .toList(),
              onChanged: (v) => setState(() => _kategori = v!),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _isiCtrl,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Isi Catatan',
                prefixIcon: Icon(Icons.notes),
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Isi wajib diisi' : null,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _simpan,
              icon: const Icon(Icons.save),
              label: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}

// === HALAMAN DETAIL ===
class DetailCatatanPage extends StatelessWidget {
  final Catatan catatan;
  const DetailCatatanPage({super.key, required this.catatan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Catatan')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              catatan.judul,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Chip(label: Text(catatan.kategori)),
                const SizedBox(width: 8),
                Text(
                  catatan.email,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            const Divider(height: 32),
            Text(
              catatan.isi,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
