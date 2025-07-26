import 'dart:ui' as BorderType;

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:test1/printer_setup_page.dart';

import 'bill_printer.dart'; // Adjust the import path

final printer = BillPrinter();



class NewOrderPage extends StatefulWidget {
  @override
  _NewOrderPageState createState() => _NewOrderPageState();

}

class _NewOrderPageState extends State<NewOrderPage> {
  final List<String> categories = [
    "BEST SELLER ITEMS",
    "01 SNACKS",
    "02 MAINS",
    "03 RICE PREPARATION",
    "04 THALI",
    "05 VEG SOUP",
    "06 NON VEG SOUP",
    "07 RICE VEG",
    "08 NOODLES VEG",
    "10 NOODLES NON VEG",
    "11 STARTER VEG",
    "12 STARTER NON VEG",
  ];

  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  BluetoothDevice? selectedDevice;

  final List<Map<String, dynamic>> items = [
    // Fast Food (10 items)
    {"name": "Veg Burger", "price": 80, "category": "Fast Food", "qty": 0, "selected": false},
    {"name": "Fries", "price": 50, "category": "Fast Food", "qty": 0, "selected": false},
    {"name": "Pizza", "price": 120, "category": "Fast Food", "qty": 0, "selected": false},
    {"name": "Cheese Sandwich", "price": 60, "category": "Fast Food", "qty": 0, "selected": false},
    {"name": "Paneer Wrap", "price": 90, "category": "Fast Food", "qty": 0, "selected": false},
    {"name": "Samosa", "price": 20, "category": "Fast Food", "qty": 0, "selected": false},
    {"name": "Hot Dog", "price": 100, "category": "Fast Food", "qty": 0, "selected": false},
    {"name": "Veg Puff", "price": 25, "category": "Fast Food", "qty": 0, "selected": false},
    {"name": "Spring Roll", "price": 70, "category": "Fast Food", "qty": 0, "selected": false},
    {"name": "Aloo Tikki", "price": 45, "category": "Fast Food", "qty": 0, "selected": false},

// Beverages (10 items)
    {"name": "Tea", "price": 20, "category": "Beverages", "qty": 0, "selected": false},
    {"name": "Coffee", "price": 30, "category": "Beverages", "qty": 0, "selected": false},
    {"name": "Coke", "price": 40, "category": "Beverages", "qty": 0, "selected": false},
    {"name": "Pepsi", "price": 40, "category": "Beverages", "qty": 0, "selected": false},
    {"name": "Lemonade", "price": 35, "category": "Beverages", "qty": 0, "selected": false},
    {"name": "Orange Juice", "price": 50, "category": "Beverages", "qty": 0, "selected": false},
    {"name": "Cold Coffee", "price": 60, "category": "Beverages", "qty": 0, "selected": false},
    {"name": "Milkshake", "price": 70, "category": "Beverages", "qty": 0, "selected": false},
    {"name": "Buttermilk", "price": 25, "category": "Beverages", "qty": 0, "selected": false},
    {"name": "Iced Tea", "price": 45, "category": "Beverages", "qty": 0, "selected": false},

// Starters (10 items)
    {"name": "Paneer Tikka", "price": 150, "category": "Starters", "qty": 0, "selected": false},
    {"name": "Chicken Tikka", "price": 180, "category": "Starters", "qty": 0, "selected": false},
    {"name": "Veg Manchurian", "price": 130, "category": "Starters", "qty": 0, "selected": false},
    {"name": "Chilli Paneer", "price": 140, "category": "Starters", "qty": 0, "selected": false},
    {"name": "Hara Bhara Kebab", "price": 110, "category": "Starters", "qty": 0, "selected": false},
    {"name": "Chicken 65", "price": 160, "category": "Starters", "qty": 0, "selected": false},
    {"name": "Fish Fingers", "price": 170, "category": "Starters", "qty": 0, "selected": false},
    {"name": "Crispy Corn", "price": 120, "category": "Starters", "qty": 0, "selected": false},
    {"name": "Stuffed Mushrooms", "price": 150, "category": "Starters", "qty": 0, "selected": false},
    {"name": "Seekh Kebab", "price": 180, "category": "Starters", "qty": 0, "selected": false},

// Main Course (10 items)
    {"name": "Dal Makhani", "price": 120, "category": "Main Course", "qty": 0, "selected": false},
    {"name": "Paneer Butter Masala", "price": 150, "category": "Main Course", "qty": 0, "selected": false},
    {"name": "Chicken Curry", "price": 180, "category": "Main Course", "qty": 0, "selected": false},
    {"name": "Veg Biryani", "price": 130, "category": "Main Course", "qty": 0, "selected": false},
    {"name": "Chicken Biryani", "price": 200, "category": "Main Course", "qty": 0, "selected": false},
    {"name": "Palak Paneer", "price": 140, "category": "Main Course", "qty": 0, "selected": false},
    {"name": "Rajma Chawal", "price": 110, "category": "Main Course", "qty": 0, "selected": false},
    {"name": "Kadhai Paneer", "price": 160, "category": "Main Course", "qty": 0, "selected": false},
    {"name": "Fish Curry", "price": 190, "category": "Main Course", "qty": 0, "selected": false},
    {"name": "Mushroom Masala", "price": 150, "category": "Main Course", "qty": 0, "selected": false},

// Desserts (10 items)
    {"name": "Gulab Jamun", "price": 40, "category": "Desserts", "qty": 0, "selected": false},
    {"name": "Rasmalai", "price": 50, "category": "Desserts", "qty": 0, "selected": false},
    {"name": "Ice Cream", "price": 60, "category": "Desserts", "qty": 0, "selected": false},
    {"name": "Chocolate Cake", "price": 90, "category": "Desserts", "qty": 0, "selected": false},
    {"name": "Jalebi", "price": 30, "category": "Desserts", "qty": 0, "selected": false},
    {"name": "Rasgulla", "price": 35, "category": "Desserts", "qty": 0, "selected": false},
    {"name": "Brownie", "price": 70, "category": "Desserts", "qty": 0, "selected": false},
    {"name": "Fruit Custard", "price": 50, "category": "Desserts", "qty": 0, "selected": false},
    {"name": "Kheer", "price": 45, "category": "Desserts", "qty": 0, "selected": false},
    {"name": "Cheesecake", "price": 100, "category": "Desserts", "qty": 0, "selected": false},

// South Indian (10 items)
    {"name": "Dosa", "price": 80, "category": "South Indian", "qty": 0, "selected": false},
    {"name": "Idli", "price": 50, "category": "South Indian", "qty": 0, "selected": false},
    {"name": "Vada", "price": 40, "category": "South Indian", "qty": 0, "selected": false},
    {"name": "Uttapam", "price": 90, "category": "South Indian", "qty": 0, "selected": false},
    {"name": "Pongal", "price": 70, "category": "South Indian", "qty": 0, "selected": false},
    {"name": "Upma", "price": 60, "category": "South Indian", "qty": 0, "selected": false},
    {"name": "Masala Dosa", "price": 100, "category": "South Indian", "qty": 0, "selected": false},
    {"name": "Rava Dosa", "price": 110, "category": "South Indian", "qty": 0, "selected": false},
    {"name": "Onion Uttapam", "price": 95, "category": "South Indian", "qty": 0, "selected": false},
    {"name": "Medu Vada", "price": 45, "category": "South Indian", "qty": 0, "selected": false},

// Chinese (10 items)
    {"name": "Veg Noodles", "price": 90, "category": "Chinese", "qty": 0, "selected": false},
    {"name": "Chicken Noodles", "price": 120, "category": "Chinese", "qty": 0, "selected": false},
    {"name": "Veg Fried Rice", "price": 100, "category": "Chinese", "qty": 0, "selected": false},
    {"name": "Chicken Fried Rice", "price": 130, "category": "Chinese", "qty": 0, "selected": false},
    {"name": "Manchow Soup", "price": 70, "category": "Chinese", "qty": 0, "selected": false},
    {"name": "Hot & Sour Soup", "price": 75, "category": "Chinese", "qty": 0, "selected": false},
    {"name": "Szechuan Noodles", "price": 110, "category": "Chinese", "qty": 0, "selected": false},
    {"name": "Hakka Noodles", "price": 95, "category": "Chinese", "qty": 0, "selected": false},
    {"name": "American Chopsuey", "price": 140, "category": "Chinese", "qty": 0, "selected": false},
    {"name": "Schezwan Fried Rice", "price": 125, "category": "Chinese", "qty": 0, "selected": false},

// Italian (10 items)
    {"name": "Pasta", "price": 120, "category": "Italian", "qty": 0, "selected": false},
    {"name": "Spaghetti", "price": 130, "category": "Italian", "qty": 0, "selected": false},
    {"name": "Margherita Pizza", "price": 150, "category": "Italian", "qty": 0, "selected": false},
    {"name": "Garlic Bread", "price": 80, "category": "Italian", "qty": 0, "selected": false},
    {"name": "Lasagna", "price": 180, "category": "Italian", "qty": 0, "selected": false},
    {"name": "Risotto", "price": 160, "category": "Italian", "qty": 0, "selected": false},
    {"name": "Fettuccine Alfredo", "price": 170, "category": "Italian", "qty": 0, "selected": false},
    {"name": "Bruschetta", "price": 90, "category": "Italian", "qty": 0, "selected": false},
    {"name": "Tiramisu", "price": 110, "category": "Italian", "qty": 0, "selected": false},
    {"name": "Cannoli", "price": 95, "category": "Italian", "qty": 0, "selected": false},

// Mexican (10 items)
    {"name": "Tacos", "price": 100, "category": "Mexican", "qty": 0, "selected": false},
    {"name": "Burrito", "price": 120, "category": "Mexican", "qty": 0, "selected": false},
    {"name": "Quesadilla", "price": 110, "category": "Mexican", "qty": 0, "selected": false},
    {"name": "Nachos", "price": 90, "category": "Mexican", "qty": 0, "selected": false},
    {"name": "Enchiladas", "price": 140, "category": "Mexican", "qty": 0, "selected": false},
    {"name": "Fajitas", "price": 150, "category": "Mexican", "qty": 0, "selected": false},
    {"name": "Chimichanga", "price": 130, "category": "Mexican", "qty": 0, "selected": false},
    {"name": "Guacamole", "price": 70, "category": "Mexican", "qty": 0, "selected": false},
    {"name": "Salsa", "price": 50, "category": "Mexican", "qty": 0, "selected": false},
    {"name": "Churros", "price": 80, "category": "Mexican", "qty": 0, "selected": false},

// Japanese (10 items)
    {"name": "Sushi", "price": 200, "category": "Japanese", "qty": 0, "selected": false},
    {"name": "Ramen", "price": 180, "category": "Japanese", "qty": 0, "selected": false},
    {"name": "Tempura", "price": 160, "category": "Japanese", "qty": 0, "selected": false},
    {"name": "Udon", "price": 150, "category": "Japanese", "qty": 0, "selected": false},
    {"name": "Miso Soup", "price": 90, "category": "Japanese", "qty": 0, "selected": false},
    {"name": "Teriyaki Chicken", "price": 190, "category": "Japanese", "qty": 0, "selected": false},
    {"name": "Gyoza", "price": 120, "category": "Japanese", "qty": 0, "selected": false},
    {"name": "Sashimi", "price": 220, "category": "Japanese", "qty": 0, "selected": false},
    {"name": "Yakitori", "price": 140, "category": "Japanese", "qty": 0, "selected": false},
    {"name": "Matcha Ice Cream", "price": 110, "category": "Japanese", "qty": 0, "selected": false},

// Thai (10 items)
    {"name": "Pad Thai", "price": 150, "category": "Thai", "qty": 0, "selected": false},
    {"name": "Tom Yum Soup", "price": 120, "category": "Thai", "qty": 0, "selected": false},
    {"name": "Green Curry", "price": 160, "category": "Thai", "qty": 0, "selected": false},
    {"name": "Red Curry", "price": 160, "category": "Thai", "qty": 0, "selected": false},
    {"name": "Massaman Curry", "price": 170, "category": "Thai", "qty": 0, "selected": false},
    {"name": "Som Tum", "price": 110, "category": "Thai", "qty": 0, "selected": false},
    {"name": "Satay", "price": 130, "category": "Thai", "qty": 0, "selected": false},
    {"name": "Khao Soi", "price": 140, "category": "Thai", "qty": 0, "selected": false},
    {"name": "Mango Sticky Rice", "price": 90, "category": "Thai", "qty": 0, "selected": false},
    {"name": "Thai Iced Tea", "price": 70, "category": "Thai", "qty": 0, "selected": false},

// Continental (10 items)
    {"name": "Grilled Chicken", "price": 220, "category": "Continental", "qty": 0, "selected": false},
    {"name": "Beef Steak", "price": 280, "category": "Continental", "qty": 0, "selected": false},
    {"name": "Fish & Chips", "price": 200, "category": "Continental", "qty": 0, "selected": false},
    {"name": "Caesar Salad", "price": 150, "category": "Continental", "qty": 0, "selected": false},
    {"name": "Mushroom Risotto", "price": 180, "category": "Continental", "qty": 0, "selected": false},
    {"name": "Ratatouille", "price": 160, "category": "Continental", "qty": 0, "selected": false},
    {"name": "Bouillabaisse", "price": 240, "category": "Continental", "qty": 0, "selected": false},
    {"name": "Coq au Vin", "price": 260, "category": "Continental", "qty": 0, "selected": false},
    {"name": "Quiche Lorraine", "price": 140, "category": "Continental", "qty": 0, "selected": false},
    {"name": "Crème Brûlée", "price": 120, "category": "Continental", "qty": 0, "selected": false},

// Indian Breads (10 items)
    {"name": "Naan", "price": 30, "category": "Indian Breads", "qty": 0, "selected": false},
    {"name": "Roti", "price": 20, "category": "Indian Breads", "qty": 0, "selected": false},
    {"name": "Paratha", "price": 40, "category": "Indian Breads", "qty": 0, "selected": false},
    {"name": "Kulcha", "price": 35, "category": "Indian Breads", "qty": 0, "selected": false},
    {"name": "Poori", "price": 25, "category": "Indian Breads", "qty": 0, "selected": false},
    {"name": "Bhatura", "price": 45, "category": "Indian Breads", "qty": 0, "selected": false},
    {"name": "Missi Roti", "price": 30, "category": "Indian Breads", "qty": 0, "selected": false},
    {"name": "Tandoori Roti", "price": 25, "category": "Indian Breads", "qty": 0, "selected": false},
    {"name": "Lachha Paratha", "price": 50, "category": "Indian Breads", "qty": 0, "selected": false},
    {"name": "Roomali Roti", "price": 20, "category": "Indian Breads", "qty": 0, "selected": false}
  ];

  Set<int> selectedIndexes = {};

  void _onQtyTap(int index) async {
    final result = await showDialog<int>(
      context: context,
      builder: (context) {
        TextEditingController controller = TextEditingController(
          text: items[index]['qty'].toString(),
        );
        return AlertDialog(
          title: Text('Enter Quantity'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () {
                int enteredQty = int.tryParse(controller.text) ?? 0;
                Navigator.of(context).pop(enteredQty);
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );

    if (result != null) {
      setState(() {
        items[index]['qty'] = result;
      });
    }
  }

  void showPrintOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("🧾 Choose Action"),
        content: Text("Would you like to print or print & settle the bill?"),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await printer.printCart(
                  cart: cart,
                  total: getTotal(),
                  mode: "print"
              );
            },
            child: Text("PRINT"),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              // TODO: Implement print & settle logic
              await printer.printCart(
                  cart: cart,
                  total: getTotal(),
                  mode: "settle"
              );

              print("Printing & Settling...");
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: Text("PRINT & SETTLE"),
          ),
        ],
      ),
    );
  }

  void _onItemTap(int index) {
    setState(() {
      if (selectedIndexes.contains(index)) {
        selectedIndexes.remove(index);
      } else {
        selectedIndexes.add(index);
      }
    });
  }
  List<Map<String, dynamic>> cart = [];

  void updateCart(Map<String, dynamic> item) {
    setState(() {
      // Check if selected
      if (item['selected'] == true) {
        item['qty'] = (item['qty'] == 0 || item['qty'] == null) ? 1 : item['qty'];

        // Check if item already in cart by ID or name
        final existing = cart.indexWhere((i) => i['name'] == item['name']);
        if (existing == -1) {
          cart.add({...item}); // clone to avoid pointer side-effects
        } else {
          cart[existing] = {...item};
        }
      } else {
        // Remove from cart if deselected
        cart.removeWhere((i) => i['name'] == item['name']);
      }
    });
  }

  void showCartItems() {
    print("BILL RECEIPT ITEMS:");
    for (var item in cart) {
      print("${item['name']} x ${item['qty']} @ ₹${item['price']} = ₹${item['qty'] * item['price']}");
    }
  }

  int getTotal() {
    int total = 0;
    if (cart == null) return total; // if cart is nullable

    for (var item in cart) {
      final qty = item['qty'] ?? 0;
      final price = item['price'] ?? 0;
      total += (qty is int ? qty : int.tryParse(qty.toString()) ?? 0) *
          (price is int ? price : int.tryParse(price.toString()) ?? 0);
    }
    return total;
  }

  void showCartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("🧾 Bill Receipt"),
          content: cart.isEmpty
              ? Text("No items selected.")
              : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Text("Item",
                          style: TextStyle(
                              fontWeight: FontWeight.bold))),
                  Expanded(
                      child: Center(
                          child: Text("Qty",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold)))),
                  Text("Amount",
                      style:
                      TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              Divider(),

              // Cart Items
              ...cart.map((item) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text("${item['name']}")),
                  Expanded(
                      child: Center(
                          child: Text("x${item['qty']}"))),
                  Text("₹${item['qty'] * item['price']}"),
                ],
              )),

              Divider(),

              // Total Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("₹${getTotal()}",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              )
            ],
          ),
          actions: [
            TextButton(
              child: Text("Close"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    Map<String, List<Map<String, dynamic>>> groupedItems = {};
    for (var item in items) {
      String category = item["category"];
      if (!groupedItems.containsKey(category)) {
        groupedItems[category] = [];
      }
      groupedItems[category]!.add(item);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Items"),
        backgroundColor: Colors.blue[900],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              children: [
                // Left Category Panel
                Container(
                  width: 100,
                  height: constraints.maxHeight,
                  color: Colors.grey[350],

                  child: Column(
                    children: [
                      //white space
                      SizedBox(height: 60),
                      // ListView below
                      Expanded(
                        child: ListView.builder(
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return Container(

                              margin: EdgeInsets.all(2),
                              width: 80,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.white, // Background color of each item
                                border: Border.all(color: Colors.black12), // 🔲 Light border
                                borderRadius: BorderRadius.circular(8), // 🔘 Rounded corners
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 2,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  categories[index],
                                  style: TextStyle(fontSize: 12),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          },

                        ),
                      ),
                    ],
                  ),
                ),



                // Right side Grid
                Expanded(

                  child: Column(
                    children: [
                      // Top grey patch (T-head) with square buttons
                      Container(
                        width: double.infinity,
                        color: Colors.grey[350], // Flat grey background
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        //margin: EdgeInsets.only(bottom: 8), // Space before GridView
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildFlatSquareButton(Icons.add, "Items", () {
                              // Do something
                            }),
                            _buildFlatSquareButton(Icons.edit, "HOLD", () {
                              // Do something
                            }),
                            _buildFlatSquareButton(Icons.local_shipping, "PARCEL", () {
                              // Do something
                            }),
                          ],
                        ),
                      ),


                      // Item grid below
                      Expanded(
                        child: Container(
                          color: Colors.grey[200],
                            child:ListView.builder(
                              itemCount: groupedItems.length,
                              itemBuilder: (context, categoryIndex) {
                                String category = groupedItems.keys.elementAt(categoryIndex);
                                List<Map<String, dynamic>> categoryItems = groupedItems[category]!;

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                      child: Text(
                                        category,
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
                                      ),
                                    ),

                                    GridView.custom(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 6,
                                        mainAxisSpacing: 6,
                                        childAspectRatio: 1,
                                      ),
                                      childrenDelegate: SliverChildBuilderDelegate(
                                            (context, index) {
                                          final item = categoryItems[index];

                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (item['selected'] == true) {
                                                  item['qty'] += 1; // increase qty
                                                } else {
                                                  item['selected'] = true;
                                                  item['qty'] = 1;
                                                }
                                                updateCart(item);
                                              });
                                            },
                                            child: Stack(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: item['selected'] == true ? Colors.green[100] : Colors.white,
                                                    border: Border.all(color: Colors.black12),
                                                    borderRadius: BorderRadius.circular(4),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(4),
                                                    child: Column(
                                                      children: [
                                                        Flexible(
                                                          child: Text(
                                                            item["name"],
                                                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                                            textAlign: TextAlign.center,
                                                            softWrap: true,
                                                            overflow: TextOverflow.visible,
                                                            maxLines: 3,
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () async {
                                                                TextEditingController _controller = TextEditingController(
                                                                    text: item['qty'].toString());

                                                                final newQuantity = await showDialog<String>(
                                                                  context: context,
                                                                  builder: (context) {
                                                                    return AlertDialog(
                                                                      title: Text("Enter Quantity"),
                                                                      content: TextField(
                                                                        controller: _controller,
                                                                        keyboardType: TextInputType.number,
                                                                        decoration: InputDecoration(hintText: "Enter quantity"),
                                                                      ),
                                                                      actions: [
                                                                        TextButton(
                                                                          child: Text("Cancel"),
                                                                          onPressed: () => Navigator.of(context).pop(),
                                                                        ),
                                                                        ElevatedButton(
                                                                          child: Text("OK"),
                                                                          onPressed: () => Navigator.of(context).pop(_controller.text),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                );

                                                                if (newQuantity != null && newQuantity.isNotEmpty) {
                                                                  setState(() {
                                                                    item['qty'] = int.tryParse(newQuantity) ?? 0;
                                                                    updateCart(item);
                                                                  });
                                                                }
                                                              },
                                                              child: Container(
                                                                width: 30,
                                                                height: 25,
                                                                decoration: BoxDecoration(
                                                                  border: Border.all(color: Colors.black26),
                                                                  color: item['qty'] == 0 ? Colors.grey[200] : Colors.green[300],
                                                                ),
                                                                child: Center(
                                                                  child: FittedBox(
                                                                    child: Text(
                                                                      item['qty'].toString(),
                                                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),

                                                            DottedBorder(
                                                              color: Colors.black54,
                                                              strokeWidth: 1,
                                                              dashPattern: [4, 2],
                                                              radius: Radius.circular(4),
                                                              child: Container(
                                                                width: 30,
                                                                height: 15,
                                                                alignment: Alignment.center,
                                                                child: Text(
                                                                  "${item["price"]}",
                                                                  style: TextStyle(
                                                                    fontSize: 12,
                                                                    fontWeight: FontWeight.bold,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                                // ❌ Remove Icon – visible only if selected
                                                if (item['selected'] == true)
                                                  Positioned(
                                                    top: 2,
                                                    right: 2,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          item['selected'] = false;
                                                          item['qty'] = 0;
                                                          updateCart(item);
                                                        });
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets.all(2),
                                                        decoration: BoxDecoration(
                                                          color: Colors.red,
                                                          shape: BoxShape.circle,
                                                        ),
                                                        child: Icon(Icons.close, size: 18, color: Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          );

                                            },
                                        childCount: categoryItems.length,
                                      ),
                                    ),

                                    Divider(color: Colors.blue.shade400, thickness: 1.5),
                                  ],
                                );
                              },
                            )


                        ),
                      ),


                    ],
                  ),
                ),


              ],
            );
          },
        ),

      ),



      // Bottom Bar
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[300],
        elevation: 0, // Optional: remove shadow
        child: SizedBox(
          height: 60, // Exact height of buttons
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // DETAILS Button
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle DETAILS
                    showCartDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Touch bottom
                    ),
                  ),
                  child: const Text("DETAILS", style: TextStyle(fontSize: 18)),
                ),
              ),

              const SizedBox(width: 8),

              // KOT Button
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle KOT
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("KOT", style: TextStyle(fontSize: 18)),
                ),
              ),

              const SizedBox(width: 8),

              // SAVE Button (disabled)
              Expanded(
                child: ElevatedButton(
                  onPressed: () => showPrintOptions(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "SAVE (₹ ${getTotal()})",
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ),
              ),


            ],
          ),
        ),
      ),

    );
  }

  void selectItem(int index) {
    setState(() {
      for (int i = 0; i < items.length; i++) {
        print("Item selected: ${items[index]}");

        items[i]['selected'] = (i == index); // Only highlight the tapped one
      }
    });
  }
}





Widget _buildFlatSquareButton(IconData icon, String label, VoidCallback onPressed) {
  return Container(
    color: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: InkWell(
      onTap: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20, color: Colors.black87),
          SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(color: Colors.black87, fontSize: 13),
          ),
        ],
      ),
    ),
  );
}



