import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Halo, Flutter!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('\u{1F44B}', style: TextStyle(fontSize: 64)),
              SizedBox(height: 16),
              Text(
                'Halo, Mochammad Hari Fitrian',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Selamat datang di dunia Flutter!',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              SizedBox(height: 24),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 32),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Column(
                  children: [
                    Text(
                      "NIM : 243040126",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Prodi : Teknik Informatika",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Semester : 6",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                child: Text("Tap Me!"),
                onPressed: () => print("Tombol diklik!"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
