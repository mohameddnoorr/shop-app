import 'dart:io';

import 'package:shop_app/models/profile%20model/profile_model.dart';

abstract class ShopStates{}
class InitialState extends ShopStates{}
class NavBottomState extends ShopStates{}

class ShopSuccessState extends ShopStates{}
class ShopErrorState extends ShopStates{}
class ShopLoadingState extends ShopStates{}

class CategoriesSuccessState extends ShopStates{}
class CategoriesErrorState extends ShopStates{}
class CategoriesLoadingState extends ShopStates{}

class ChangeFavoritesSuccessState extends ShopStates{}
class ChangeFavoritesErrorState extends ShopStates{}

class FavoritesLoadingState extends ShopStates{}
class FavoritesSuccessState extends ShopStates{}
class FavoritesErrorState extends ShopStates{}

class ProfileSuccessState extends ShopStates{
    final ProfileModel? profileModel;
   ProfileSuccessState({
      this.profileModel
});
}
class ProfileErrorState extends ShopStates{}
class ProfileLoadingState extends ShopStates{}

class UpProfileSuccessState extends ShopStates{
   final ProfileModel? profileModel;
  UpProfileSuccessState({
    this.profileModel
  });
}
class UpProfileErrorState extends ShopStates{}
class UpProfileLoadingState extends ShopStates{}


class ImageSuccessState extends ShopStates{
 File? pickedImage;
 ImageSuccessState( {required this.pickedImage});
}
class ImageErrorState extends ShopStates{}
