class Product {
  String? id;
  String? name;
  String? category;
  String? brand;
  String? model;
  double? price;
  String? colour;
  String? weight;
  String? imageUrl;

  Product(
      {this.id,
      this.name,
      this.category,
      this.brand,
      this.model,
      this.price,
      this.colour,
      this.weight,
      this.imageUrl});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category = json['category'];
    brand = json['brand'];
    model = json['model'];
    price = json['price'];
    colour = json['colour'];
    weight = json['weight'];
    imageUrl = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['category'] = category;
    data['brand'] = brand;
    data['model'] = model;
    data['price'] = price;
    data['colour'] = colour;
    data['weight'] = weight;
    data['image'] = imageUrl;
    return data;
  }
}
