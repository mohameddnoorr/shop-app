class FavoritesModel {
  late final bool status;
 

  Data? data;

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? false;
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? currentPage;
  List<DataFavorites>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;

  String? path;
  int? perPage;

  int? to;
  int? total;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <DataFavorites>[];
      json['data'].forEach((v) {
        data!.add(DataFavorites.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'] ?? 0;
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }
}

class DataFavorites {
  int? id;
  Product? product;

  DataFavorites.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }
}

class Product {
  int? id;
  int? price;
  int? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
