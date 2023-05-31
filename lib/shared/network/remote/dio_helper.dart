import 'package:dio/dio.dart';

class DioHelper{
  static late Dio dio;

  static void init(){
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,

      ),

    );
  }

  static Future<Response> getData({
    required String url,
    Map<String,dynamic>? quire,
    String lang ='en',
    String? token,
  })async{
    dio.options.headers=
    {
      'lang':lang,
      'Authorization':token??'',
      'Content-Type':'application/json',
    };
    return await dio.get(
      url,
      queryParameters: quire,
    );

  }

  static Future<Response> postData({
    required String url,
    Map<String,dynamic>? quire,
    required Map<String,dynamic> data,
    String lang ='en',
    String? token,
  })async{
    dio.options.headers={
      'lang':lang,
      'Authorization':token??'',
      'Content-Type':'application/json',
    };
    return await dio.post(
      url,
      queryParameters: quire,
      data: data,


    );
  }

  static Future<Response> putData({
    required String url,
    Map<String,dynamic>? quire,
    required Map<String,dynamic> data,
    String lang ='en',
    String? token,
  })async{
    dio.options.headers={
      'lang':lang,
      'Authorization':token??'',
      'Content-Type':'application/json',
    };
    return await dio.put(
      url,
      queryParameters: quire,
      data: data,


    );
  }
}

