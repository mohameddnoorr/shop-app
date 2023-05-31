
import 'package:shop_app/models/login%20model/login_model.dart';

abstract class LoginStates{}
class LoginInitialState extends LoginStates{}
class ObscureState extends LoginStates{}

class LoginLoadingState extends LoginStates{}
class LoginSuccessState extends LoginStates{
  final LoginModel? loginModel;
 LoginSuccessState({
    this.loginModel
});
}
class LoginErrorState extends LoginStates{
    final String error;
   LoginErrorState({
     required this.error,
});

}