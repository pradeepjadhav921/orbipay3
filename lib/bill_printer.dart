import 'dart:convert';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BillPrinter {
  final BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  Function()? onTransactionAdded;

  Future<void> printCart({
    required List<Map<String, dynamic>> cart,
    required int total,
    required String mode,
  }) async {
    try {
      final device = await _getSavedPrinter();
      if (device == null) {
        print("❌ No saved printer found.");
        return;
      }

      bool? connected = await bluetooth.isConnected;
      if (connected != true) {
        await bluetooth.connect(device);
      }

      bluetooth.printNewLine();
      bluetooth.printCustom("Dosti Kitchen", 3, 1);
      //bluetooth.printCustom("Cart Bill", 1, 1);
      bluetooth.printNewLine();

      for (var item in cart) {
        String name = item['name'] ?? 'Item';
        int qty = item['qty'] ?? 0;
        int price = item['price'] ?? 0;
        bluetooth.printLeftRight("$name x$qty", "Rs.${qty * price}", 1);
      }

      bluetooth.printNewLine();
      bluetooth.printCustom("Total: Rs.$total", 2, 2);
      bluetooth.printNewLine();
      bluetooth.printCustom("Thank you!", 1, 1);
      bluetooth.printNewLine();
      bluetooth.paperCut();
      bluetooth.disconnect();

      print("✅ Printed successfully.");

      // ✅ Save to recent transactions
      if(mode=="settle") {
        await _saveTransactionToLocal(
          cart: cart,
          total: total,
          tableNo: 1,
        );
      }
    } catch (e) {
      print("❌ Error while printing: $e");
      bluetooth.disconnect();
    }
  }


  Future<void> _saveTransactionToLocal({
    required List<Map<String, dynamic>> cart,
    required int total,
    int? tableNo,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    // Get existing list
    final List<String> existing =
        prefs.getStringList('recent_transactions') ?? [];

    // Create a new entry
    final Map<String, dynamic> newTx = {
      'time': DateTime.now().toIso8601String(),
      'tableNo': tableNo,
      'total': total,
      'cart': cart,
    };

    existing.insert(0, jsonEncode(newTx));

    // Limit to latest 20 transactions
    // if (existing.length > 20) {
    //   existing.removeRange(20, existing.length);
    // }

    await prefs.setStringList('recent_transactions', existing);
    if (onTransactionAdded != null) {
      onTransactionAdded!(); // 🟢 Triggers reload in UI
    }
    print("✅ Transaction saved.");
  }


  Future<BluetoothDevice?> _getSavedPrinter() async {
    final prefs = await SharedPreferences.getInstance();
    String? address = prefs.getString('saved_printer_address');
    if (address == null) return null;

    List<BluetoothDevice> devices = await bluetooth.getBondedDevices();
    try {
      return devices.firstWhere((d) => d.address == address);
    } catch (e) {
      return null; // Return null if no match found
    }
  }


  // Optional: Call this at app start (e.g., in main or splash)
  Future<void> autoConnectIfSaved() async {
    final device = await _getSavedPrinter();
    if (device == null) return;

    try {
      bool? isConnected = await bluetooth.isConnected;
      if (isConnected != true) {
        await bluetooth.connect(device);
        print("✅ Auto-connected to saved printer.");
      }
    } catch (e) {
      print("❌ Auto-connect failed: $e");
    }
  }

  // Optional: Save printer on setup page
  static Future<void> savePrinter(BluetoothDevice device) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('saved_printer_address', device.address ?? '');
    print("✅ Saved printer: ${device.name}");
  }
}
