class Order {
  final int id;
  final String driverName;
  final String vehiclePlate;
  final String shipmentId;
  final String clientName;
  final List<int> selectedProductIds;

  Order({
    required this.id,
    required this.driverName,
    required this.vehiclePlate,
    required this.shipmentId,
    required this.clientName,
    required this.selectedProductIds,
  });

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      driverName: map['driverName'],
      vehiclePlate: map['vehiclePlate'],
      shipmentId: map['shipmentId'],
      clientName: map['clientName'],
      selectedProductIds: List<int>.from(map['selectedProductIds'].split(',').map(int.parse)),
    );
  }
}

class Product {
  final int id;
  final String name;

  Product({required this.id, required this.name});

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
    );
  }
}
