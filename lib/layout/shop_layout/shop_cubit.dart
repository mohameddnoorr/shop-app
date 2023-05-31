import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/shop_states.dart';
import 'package:shop_app/models/category%20model/category_model.dart';
import 'package:shop_app/modules/shop_screens/categories_screen/categories_screen.dart';
import 'package:shop_app/modules/shop_screens/profile_screen/profile_screen.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import '../../models/change favorites model/change_favorites_model.dart';
import '../../models/favorites model/favorites_model.dart';
import '../../models/home_model/home_model.dart';
import '../../models/profile model/profile_model.dart';
import '../../modules/shop_screens/home_screen/home_screen.dart';
import '../../shared/components/components.dart';
import 'package:image_picker/image_picker.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(InitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    HomeScreen(),
    const CategoriesScreen(),
    ProfileScreen(),
  ];
  int currentIndex = 0;

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(NavBottomState());
  }

  Map<int, bool> favorites = {};
  HomeModel? homeModel;

  void getHomeData() {
    emit(ShopLoadingState());
    DioHelper.getData(url: home, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      for (var element in homeModel!.data!.products!) {
        favorites.addAll({element.id!: element.inFavorites!});
      }
      emit(ShopSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopErrorState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    emit(CategoriesLoadingState());
    DioHelper.getData(url: categories, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(CategoriesSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(CategoriesErrorState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ChangeFavoritesSuccessState());
    DioHelper.postData(
            url: FAVORITES, data: {'product_id': productId}, token: token)
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (changeFavoritesModel!.status!) {
        getFavoritesData();
      }
      emit(ChangeFavoritesSuccessState());
    }).catchError((error) {
      emit(ChangeFavoritesErrorState());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavoritesData() {
    emit(FavoritesLoadingState());
    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      if (kDebugMode) {
        print('favoritesModel$favoritesModel');
      }

      emit(FavoritesSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(FavoritesErrorState());
    });
  }

  ProfileModel? profileModel;

  void getProfileData() {
    emit(ProfileLoadingState());
    DioHelper.getData(
      url: profile,
      token: token,
    ).then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      if (kDebugMode) {
        print(profileModel!.message);
      }
      emit(ProfileSuccessState(profileModel: profileModel));
    }).catchError((error) {
      emit(ProfileErrorState());
    });
  }

  void putUpProfileData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ProfileLoadingState());
    DioHelper.putData(
      url: updateProfile,
      token: token,
      data: {name: 'name', phone: 'phone', email: 'email'},
    ).then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      if (kDebugMode) {
        print(profileModel!.message);
      }
      emit(UpProfileSuccessState(profileModel: profileModel));
    }).catchError((error) {
      emit(UpProfileErrorState());
    });
  }

  final ImagePicker _picker = ImagePicker();
  XFile? image;
  File? pickImage;

  void imagePicker() async {
    image = await _picker.pickImage(source: ImageSource.gallery).then((image) {
      pickImage = File(image!.path);
      emit(ImageSuccessState(pickedImage: pickImage));
    }).catchError((error) {
      emit(ImageErrorState());
    });
  }
}
