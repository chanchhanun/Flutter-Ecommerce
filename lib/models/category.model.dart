class Category {
  String? id;
  String? name;
  bool? isActive;
  String? description;
  String? image;
  int? iV;

  Category({
    this.id,
    this.name,
    this.isActive,
    this.description,
    this.image,
    this.iV,
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    isActive = json['isActive'];
    description = json['description'];
    image = json['image'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    data['isActive'] = this.isActive;
    data['description'] = this.description;
    data['image'] = this.image;
    data['__v'] = this.iV;
    return data;
  }
}
