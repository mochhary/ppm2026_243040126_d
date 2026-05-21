import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PPM Latihan Widget',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'PPM Latihan Widget',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red.shade600,
          foregroundColor: Colors.white,
        ),
        body: Column(
          // Latihan 1
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hello Flutter!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: Color(0xFF2196F3),
                letterSpacing: 2,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Ini teks biasa dengan ukuran kecil!',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 30),
            // Latihan 2
            Container(
              width: 300,
              height: 100,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 4),
                color: Colors.blue,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 50,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'Flutter',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
            SizedBox(height: 30),
            // Latihan 3
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.red,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Red',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(8),
                        child: Text(
                          'Ini adalah kotak berwarna merah',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.green,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Green',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(8),
                        child: Text(
                          'Ini adalah kotak berwarna hijau',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.blue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Blue',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(8),
                        child: Text(
                          'Ini adalah kotak berwarna biru',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        // Latihan 4
        bottomNavigationBar: BottomAppBar(
          color: Color.fromARGB(255, 18, 109, 255),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.search, size: 24, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.chat, size: 32, color: Colors.purple),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.call, size: 48, color: Colors.green),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.receipt_long, size: 64, color: Colors.red),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
