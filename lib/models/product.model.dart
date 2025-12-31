class Product {
  String? id;
  String? name;
  Category? category;
  Category? brand;
  String? description;
  int? sold;
  double? price;
  int? rating;
  int? stock;
  String? unit;
  String? sku;
  List<String>? images;
  ExclusiveOffer? exclusiveOffer;
  String? createdAt;
  String? updatedAt;
  int? iV;
  double? currentPrice;
  bool? hasActiveOffer;

  Product({
    this.id,
    this.name,
    this.category,
    this.brand,
    this.description,
    this.sold,
    this.price,
    this.rating,
    this.stock,
    this.unit,
    this.sku,
    this.images,
    this.exclusiveOffer,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.currentPrice,
    this.hasActiveOffer,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];

    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
    brand = json['brand'] != null ? Category.fromJson(json['brand']) : null;

    description = json['description'];
    sold = json['sold'] is double
        ? (json['sold'] as double).toInt()
        : json['sold'];
    price = (json['price'] as num?)?.toDouble(); // <-- handles int/double
    rating = json['rating'] is double
        ? (json['rating'] as double).toInt()
        : json['rating'];
    stock = json['stock'];
    unit = json['unit'];
    sku = json['sku'];

    images = json['images'] != null ? List<String>.from(json['images']) : [];

    exclusiveOffer = json['exclusiveOffer'] != null
        ? ExclusiveOffer.fromJson(json['exclusiveOffer'])
        : null;

    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'] is double ? (json['__v'] as double).toInt() : json['__v'];

    currentPrice = (json['currentPrice'] as num?)?.toDouble();
    hasActiveOffer = json['hasActiveOffer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.brand != null) {
      data['brand'] = this.brand!.toJson();
    }
    data['description'] = this.description;
    data['sold'] = this.sold;
    data['price'] = this.price;
    data['rating'] = this.rating;
    data['stock'] = this.stock;
    data['unit'] = this.unit;
    data['sku'] = this.sku;
    data['images'] = this.images;
    if (this.exclusiveOffer != null) {
      data['exclusiveOffer'] = this.exclusiveOffer!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['currentPrice'] = this.currentPrice;
    data['hasActiveOffer'] = this.hasActiveOffer;
    return data;
  }

  // empty product
  factory Product.empty() {
    return Product(
      id: '',
      name: '',
      description: '',
      price: 0,
      sold: 0,
      rating: 0,
      stock: 0,
      unit: '',
      sku: '',
      images: [],
      category: Category(id: '', name: ''),
      brand: Category(id: '', name: ''),
      exclusiveOffer: ExclusiveOffer(
        isActive: false,
        discountPercent: 0,
        originalPrice: 0,
        validUntil: '',
        badgeText: '',
      ),
      createdAt: '',
      updatedAt: '',
      iV: 0,
      currentPrice: 0,
      hasActiveOffer: false,
    );
  }

  @override
  String toString() {
    return Product(
      id: id,
      name: name,
      description: description,
      price: price,
      sold: sold,
      rating: rating,
      stock: stock,
      unit: unit,
      sku: sku,
      images: images,
      category: category,
      brand: brand,
      exclusiveOffer: exclusiveOffer,
      createdAt: createdAt,
      updatedAt: updatedAt,
      iV: iV,
      currentPrice: currentPrice,
      hasActiveOffer: hasActiveOffer,
    ).toJson().toString();
  }
}

class Category {
  String? id;
  String? name;

  Category({this.id, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class ExclusiveOffer {
  bool? isActive;
  int? discountPercent;
  double? originalPrice;
  String? validUntil;
  String? badgeText;

  ExclusiveOffer({
    this.isActive,
    this.discountPercent,
    this.originalPrice,
    this.validUntil,
    this.badgeText,
  });

  ExclusiveOffer.fromJson(Map<String, dynamic> json) {
    isActive = json['isActive'];
    discountPercent = json['discountPercent'] is double
        ? (json['discountPercent'] as double).toInt()
        : json['discountPercent'];

    originalPrice = (json['originalPrice'] as num?)?.toDouble();
    validUntil = json['validUntil'];
    badgeText = json['badgeText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isActive'] = this.isActive;
    data['discountPercent'] = this.discountPercent;
    data['originalPrice'] = this.originalPrice;
    data['validUntil'] = this.validUntil;
    data['badgeText'] = this.badgeText;
    return data;
  }
}
