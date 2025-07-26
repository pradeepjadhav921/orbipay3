import 'package:flutter/material.dart';
import 'printer_setup_page.dart'; // <-- make sure this exists

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => PrinterSetupPage()),
                );
              },
              icon: Icon(Icons.print),
              label: Text("Printer Settings"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(vertical: 16),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text("⚙️ Settings Page", style: TextStyle(fontSize: 24)),
            ),
          ],
        ),
      ),
    );
  }
}
