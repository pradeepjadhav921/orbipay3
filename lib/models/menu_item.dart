// menu_item.dart
import 'package:objectbox/objectbox.dart';

@Entity()
class MenuItem {
  @Id()
  int id = 0;

  String name;
  String sellPrice;
  String sellPriceType;
  String category;
  String? mrp;
  String? purchasePrice;
  String? acSellPrice;
  String? nonAcSellPrice;
  String? onlineDeliveryPrice;
  String? onlineSellPrice;
  String? hsnCode;
  String? itemCode;
  String? barCode;
  String? barCode2;
  String? imagePath;
  int? available;
  int? adjustStock;
  double? gstRate;
  bool? withTax; // Default to "WITH TAX"
  double? cessRate; // Default CESS rate

  MenuItem({
    this.id = 0,
    required this.name,
    required this.sellPrice,
    required this.sellPriceType,
    required this.category,
    this.mrp,
    this.purchasePrice,
    this.acSellPrice,
    this.nonAcSellPrice,
    this.onlineDeliveryPrice,
    this.onlineSellPrice,
    this.hsnCode,
    this.itemCode,
    this.barCode,
    this.barCode2,
    this.imagePath,
    this.available,
    this.adjustStock,
    this.gstRate,
    this.withTax,
    this.cessRate,
  });
}