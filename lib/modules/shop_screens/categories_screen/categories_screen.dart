import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/shop_cubit.dart';
import 'package:shop_app/layout/shop_layout/shop_states.dart';
import 'package:shop_app/models/category%20model/category_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,state) {},
      builder:(context,state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 40,
                decoration: const BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(100),
                    bottomRight: Radius.circular(100),
                  ),
                ),
              ),
             
                ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index)=>catItem(ShopCubit.get(context).categoriesModel!.data!.data![index]),
                  separatorBuilder: (context, index)=>myLine(),
                  itemCount: ShopCubit.get(context).categoriesModel!.data!.data!.length,
                )
            ],
          ),
        );
      } ,

    );
  }
  Widget catItem(  DataModel model)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(mainAxisAlignment: MainAxisAlignment.start,
      children:   [
        Image(fit: BoxFit.cover,
          height: 80,
          width: 80,
          image: NetworkImage('${model.image}'),
        ),
        const SizedBox(
          width: 20,
        ),
        Text('${model.name}',
          style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w900),

        ),


      ],
    ),
  );

  Widget myLine()=>Container(
    height: 1,
    color: Colors.grey[200],
  );


}
