class ProfileModel {
  late bool status;
  late String message;
  Data? data;


  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message']??'success';
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late int points;
  late int credit;
  late String token;


  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image']??'mh';
    points = json['points']?? 0;
    credit = json['credit']?? 0;
    token = json['token'];
  }


}
