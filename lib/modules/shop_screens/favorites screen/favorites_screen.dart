import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/shop_states.dart';
import 'package:shop_app/models/favorites%20model/favorites_model.dart';
import '../../../layout/shop_layout/shop_cubit.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(backgroundColor: Colors.white,
          body: ConditionalBuilder(
            condition: state is! FavoritesLoadingState,
            builder: (context){return ListView.separated(
                itemBuilder: (context,index)=>favItem(ShopCubit.get(context).favoritesModel!.data!.data![index],context),
                separatorBuilder: (context,index)=>myLine(),
                itemCount: ShopCubit.get(context).favoritesModel!.data!.data!.length
            );},
            fallback: (context)=>const Center(child: CircularProgressIndicator()),
          ),
        );
        },

    );
  }

  Widget favItem(DataFavorites dataFavorites,context)=> Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(height: 120,
      child: Row(crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Stack(alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(width: 120,height: 120,

                  image: NetworkImage('${dataFavorites.product!.image}'
                  ),
              ),
              if(dataFavorites.product!.discount != 0)
                Container(color: Colors.red,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text('DISCOUNT',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),),
                  ),
                )
            ],
          ),
          const SizedBox(width: 20,
          ),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text('${dataFavorites.product!.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style:const TextStyle(fontSize: 14,

                  ) ,
                ),
               const Spacer(),
                Row(
                  children: [

                    Text('Price:''${dataFavorites.product!.price}',
                      style:const TextStyle(fontSize: 14,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ) ,
                    ),
                    const SizedBox(width: 5,
                    ),
                     if(dataFavorites.product!.discount!=0)
                      Text('${dataFavorites.product!.oldPrice}',
                        style:const TextStyle(fontSize: 12,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough
                        ) ,
                      ),
                    const Spacer(),
                    IconButton(
                        onPressed:(){
                           ShopCubit.get(context).changeFavorites(dataFavorites.product!.id!);

                        },
                        icon:  Icon(Icons.favorite_rounded,
                           color: ShopCubit.get(context).favorites[dataFavorites.product!.id]! ? Colors.red : Colors.grey[500],
                        )

                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget myLine()=>Container(
    height: 1,
    color: Colors.grey[200],
  );


}
