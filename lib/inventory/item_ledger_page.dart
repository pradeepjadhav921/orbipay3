import 'package:flutter/material.dart';
import '../models/menu_item.dart';
import '../models/objectbox.g.dart';
import 'package:objectbox/objectbox.dart';

class ItemLedgerPage extends StatelessWidget {
 final MenuItem item;
  final Store store;  // Add this line

  const ItemLedgerPage({
    Key? key,
    required this.item,
    required this.store,  // Add this
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final transactions = List.generate(6, (index) {
      return {
        'type': 'Sale',
        'date': '2024-12-${10 + index}',
        'quantity': index + 1,
        'stock': (item.adjustStock ?? 0) - index,
      };
    });

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 25,
              ),
            ),
            Row(
              children: [
                Text(
                  "ID: ${item.id}",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  "Barcode: ${item.barCode ?? 'N/A'}",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.purple.shade700,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white ),
            onPressed: () {
              // TODO: Navigate to edit page
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Delete Item"),
                  content: const Text("Are you sure you want to delete this item?"),
                  actions: [
                    TextButton(
                      child: const Text("Cancel"),
                      onPressed: () => Navigator.pop(context, false),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text("Delete"),
                      onPressed: () => Navigator.pop(context, true),
                    ),
                  ],
                ),
              );

              if (confirmed == true) {
                // Access the ObjectBox store and delete the item
                final box = store.box<MenuItem>();
                final query = box.query(MenuItem_.name.equals(item.name)).build();
                final itemsToDelete = query.find();

                // 🗑️ Delete them
                for (var target in itemsToDelete) {
                  box.remove(target.id);
                }

                query.close(); // Always close the query
                Navigator.pop(context); // Close the ledger page
                ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Item deleted successfully")),
                );
              }
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📦 Summary Box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name, 
                    style: const TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.bold
                    )
                  ),
                  const SizedBox(height: 8),
                  Text("Stock: ${item.adjustStock ?? 0}", 
                    style: const TextStyle(
                      fontSize: 16, 
                      fontWeight: FontWeight.bold
                    )
                  ),
                ],
              ),
            ),

            // 📜 Transactions List
            const Text("Recent Transactions", 
              style: TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.bold
              )
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final tx = transactions[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: Icon(
                      tx['type'] == 'Sale' 
                        ? Icons.check_circle 
                        : Icons.arrow_circle_up,
                      color: tx['type'] == 'Sale' 
                        ? Colors.green 
                        : Colors.blue,
                    ),
                    title: Text("${tx['type']} - Qty: ${tx['quantity']}"),
                    subtitle: Text("Date: ${tx['date']}"),
                    trailing: Text("Stock: ${tx['stock']}"),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}