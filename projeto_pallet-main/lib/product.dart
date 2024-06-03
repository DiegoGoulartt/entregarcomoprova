class Product {
  final int? id;
  final String name;
  final String? description;
  bool selected;

  Product({
    this.id,
    required this.name,
    this.description,
    this.selected = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'selected': selected ? 1 : 0,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      selected: map['selected'] == 1,
    );
  }
}
