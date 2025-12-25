class Cart {
  String? id;
  String? userId;
  List<Items>? items;

  Cart({this.id, this.userId, this.items});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userId = json['userId'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['userId'] = this.userId;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  factory Cart.empty() {
    return Cart(id: '', userId: "", items: []);
  }
}

class Items {
  String? id;
  int? quantity;
  String? addedAt;
  Product? product;

  Items({this.id, this.quantity, this.addedAt, this.product});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    quantity = json['quantity'];
    addedAt = json['addedAt'];
    product = json['product'] != null
        ? new Product.fromJson(json['product'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['quantity'] = this.quantity;
    data['addedAt'] = this.addedAt;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
  String? id;
  String? name;
  double? price;
  String? unit;
  List<String>? images;

  Product({this.id, this.name, this.price, this.unit, this.images});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    price = json['price'];
    unit = json['unit'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['unit'] = this.unit;
    data['images'] = this.images;
    return data;
  }
}
