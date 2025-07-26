import 'package:flutter/material.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bill_printer.dart';

class PrinterSetupPage extends StatefulWidget {
  @override
  _PrinterSetupPageState createState() => _PrinterSetupPageState();
}

class _PrinterSetupPageState extends State<PrinterSetupPage> {
  List<BluetoothDevice> _devices = [];
  BluetoothDevice? _selectedDevice;
  String? _savedDeviceName;
  bool _isScanning = false;

  BlueThermalPrinter printer = BlueThermalPrinter.instance;

  @override
  void initState() {
    super.initState();
    _loadSavedDevice();
    _getBondedDevices();
  }

  Future<void> _getBondedDevices() async {
    setState(() {
      _isScanning = true;
    });

    List<BluetoothDevice> devices = [];

    try {
      devices = await printer.getBondedDevices();
    } catch (e) {
      print("Error getting devices: $e");
    }

    setState(() {
      _devices = devices;
      _isScanning = false;
    });
  }

  Future<void> _saveSelectedDevice(BluetoothDevice device) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved_printer_address', device.address!);
    await prefs.setString('savedDeviceName', device.name ?? "Unknown");

    setState(() {
      _savedDeviceName = device.name;
    });


    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("✅ Printer saved: ${device.name}"),
    ));
  }


  void onDeviceSelected(BluetoothDevice device) async {
    await BillPrinter.savePrinter(device); // ✅ Save the selected device
    print("bt printer selecte & save ");
    await BlueThermalPrinter.instance.connect(device);
  }


  Future<void> _loadSavedDevice() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedName = prefs.getString('savedDeviceName');

    setState(() {
      _savedDeviceName = savedName;
    });
  }

  Future<void> _clearSavedDevice() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('savedDeviceAddress');
    await prefs.remove('savedDeviceName');

    setState(() {
      _savedDeviceName = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("🗑️ Saved printer cleared"),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("🔌 Printer Setup"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_savedDeviceName != null)
              Card(
                color: Colors.green[100],
                child: ListTile(
                  title: Text("✅ Saved Printer: $_savedDeviceName"),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: _clearSavedDevice,
                  ),
                ),
              ),
            SizedBox(height: 16),
            Row(
              children: [
                Text("📡 Paired Bluetooth Printers", style: TextStyle(fontWeight: FontWeight.bold)),
                Spacer(),
                if (_isScanning)
                  CircularProgressIndicator(strokeWidth: 2)
                else
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: _getBondedDevices,
                  ),
              ],
            ),
            Expanded(
              child: _devices.isEmpty
                  ? Center(child: Text("No paired devices found."))
                  : ListView.builder(
                itemCount: _devices.length,
                itemBuilder: (context, index) {
                  var device = _devices[index];
                  return ListTile(
                    title: Text(device.name ?? "Unknown"),
                    subtitle: Text(device.address ?? ""),
                    trailing: ElevatedButton(
                      onPressed: () => _saveSelectedDevice(device),
                      child: Text("Save"),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
