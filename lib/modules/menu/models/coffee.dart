class Coffee {
  final String name;
  final double price;

  Coffee({required this.name, required this.price});

  factory Coffee.fromMap(Map<String, dynamic> data) {
    return Coffee(
      name: data['name'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
    );
  }
}