class HomeModel {
  bool? status;

  HomeModelData? data;


  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? HomeModelData.fromJson(json['data']) : null;
  }

}

class HomeModelData {
  List<BannerModel>? banners;
  List<ProductModel>? products;
  String? ad;

  HomeModelData({this.banners, this.products, this.ad});

  HomeModelData.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      banners = <BannerModel>[];
      json['banners'].forEach((v) {
        banners!.add(BannerModel.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <ProductModel>[];
      json['products'].forEach((v) {
        products!.add(ProductModel.fromJson(v));
      });
    }
    ad = json['ad'];
  }


}

class BannerModel {
  int? id;
  String? image;
  dynamic category;
  dynamic product;


  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    category = json['category'];
    product = json['product'];
  }


}

class ProductModel {
  int? id;
  num? price;
  num? oldPrice;
  num? discount;
  String? image;
  String? name;
  String? description;
  List<String>? images;
  bool? inFavorites;
  bool? inCart;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount =  json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }

}