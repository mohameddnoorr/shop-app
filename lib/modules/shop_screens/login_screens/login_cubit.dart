import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login%20model/login_model.dart';
import 'package:shop_app/modules/shop_screens/login_screens/login_states.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context)=>BlocProvider.of(context);


  bool isPassword = true;
  IconData suffix =Icons.remove_red_eye_rounded;
  void changeObscure(){
    isPassword = !isPassword;
    suffix=isPassword
        ? Icons.remove_red_eye_rounded
        : Icons.visibility_off_rounded;
    emit(ObscureState());
  }

   LoginModel? loginModel;
  void usersLogin({
    required String email,
    required String password,
}){
    emit(LoginLoadingState());
    DioHelper.postData(
        url: login,
        data:{
          'email':email,
          'password':password,}
    ).then((value){
      print(value.data);
      loginModel= LoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel:loginModel));

    }).catchError((error){
      print(error);
      emit(LoginErrorState(error: error.toString()));
    });
  }



}
