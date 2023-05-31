import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/shop_cubit.dart';
import 'package:shop_app/layout/shop_layout/shop_states.dart';

import '../../../shared/components/components.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../my_cart.dart';
import '../favorites screen/favorites_screen.dart';
import '../login_screens/login_screen.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
        builder: (context,state){
        var model = ShopCubit.get(context).profileModel;
        return Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName:  Text(model!.data!.name),
                accountEmail: Text(model.data!.email),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: Image.network(
                      'https://lh3.googleusercontent.com/a-/AOh14Gge7UpTG3TtQ4FS7wqj9-ezLFQhMmNUEh0WVAMg=s360-p-rw-no',
                      fit: BoxFit.cover,
                      width: 90,
                      height: 90,
                    ),
                  ),
                ),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/primaryBg.png')
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.notifications),
                title: const Text('Notification'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.favorite),
                title: const Text('Favorites'),
                onTap: (){
                  navigateTo(context,const FavoritesScreen());
                },
              ),
              ListTile(
                  leading: const Icon(Icons.shopping_cart_rounded),
                  title: const Text('My Cart'),
                  onTap: () {
                    navigateTo(context,const MyCartScreen());
                  }
              ),
              const ListTile(
                leading: Icon(Icons.reorder),
                title: Text('Orders'),
              ),
              const Divider(),
              ListTile(
                  leading: const Icon(Icons.contact_phone_rounded),
                  title: const Text('Contacts'),
                  onTap: () {}
              ),
              const Divider(),
              ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
                  onTap: () {}
              ),
              const Divider(),
              ListTile(
                title: const Text('Log Out'),
                leading: const Icon(Icons.logout_rounded),
                onTap: () {
                  CacheHelper.removeData(key: 'token').then((value) {
                    navigateAndFinish(context, ShopLoginScreen()
                    );
                  });
                },
              ),
            ],
          ),
        );
        }

    );
  }
}
