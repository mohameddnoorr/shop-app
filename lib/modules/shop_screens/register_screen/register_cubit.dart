import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_screens/register_screen/register_states.dart';

import '../../../models/login model/login_model.dart';
import '../../../shared/network/end_point.dart';
import '../../../shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context)=>BlocProvider.of(context);


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
  void usersRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }){
    emit(RegisterLoadingState());
    DioHelper.postData(
        url: register,
        data:{
          'email':email,
          'password':password,
          'name':name,
          'phone':phone,
        }
    ).then((value){
      print(value.data);
      loginModel= LoginModel.fromJson(value.data);
      emit(RegisterSuccessState(loginModel:loginModel));

    }).catchError((error){
      print(error);
      emit(RegisterErrorState(error: error.toString()));
    });
  }



}