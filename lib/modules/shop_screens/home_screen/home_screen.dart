import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/shop_cubit.dart';
import 'package:shop_app/models/home_model/home_model.dart';
import '../../../layout/shop_layout/shop_states.dart';
import '../../../shared/components/components.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen( {Key? key}) : super(key: key);

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Stack(
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
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    top: 20,

                  ),
                  child: Center(
                    child: Container(
                      height: 45,
                      width: 240,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50)),
                      child: DefaultFormField(
                        controller: searchController,
                        prefix: Icons.search_rounded,
                        obscure: false,
                        border: InputBorder.none,
                        type: TextInputType.text,
                        validate: (String? value) {return null;},
                      ),
                    ),
                  ),
                ),
              ]
              ),
              const SizedBox(
                height: 20,
              ),
              ConditionalBuilder(
                  condition: ShopCubit.get(context).homeModel != null,
                  builder: (context) =>
                      homeBuilder(ShopCubit.get(context).homeModel!,context),
                  fallback: (context) =>
                      const Center(child: CircularProgressIndicator())),
            ],
          ),
        );
      },
    );
  }
  Widget homeBuilder(HomeModel model,context) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                    items: model.data!.banners!
                        .map((e) => ClipRect(
                            clipBehavior: Clip.antiAlias,
                            child: Image.network(
                              '${e.image}',
                              fit: BoxFit.cover,
                            )))
                        .toList(),
                    options: CarouselOptions(
                      height: 200,
                      viewportFraction: 1.0,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 5),
                      autoPlayAnimationDuration: const Duration(seconds: 3),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    )),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 10),
                  child: Row(
                    children:  [
                      Text(
                        'Up to',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.grey[400]
                        ),
                      ),
                      const SizedBox(width: 5,),
                      const Text(
                        '45',
                        style: TextStyle(
                            fontSize: 56.0,
                            fontWeight: FontWeight.w900,
                            color: Colors.teal
                        ),
                      ),
                      const SizedBox(width: 2,),
                      Text(
                        '%',
                        style: TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.w900,
                            color: Colors.grey[400]
                        ),
                      ),
                    ],
                  ),
                ),
                Container(

                  height: 160.0,

                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>buildDisItem(ShopCubit.get(context).homeModel!.data!.products![index]) ,
                    separatorBuilder: (context, index) => const SizedBox(width: 6.0,),
                    itemCount: 6,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Container(color: Colors.grey[300],
                  child: GridView.count(
                    shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                      childAspectRatio: 1/1.6,
                      children:List.generate(
                          model.data!.products!.length,
                          (index) =>buildGridProduct(model.data!.products![index],context)
                  )
                  ),
                ),
              ],
      );
  Widget buildGridProduct(ProductModel productModel,context)=>Container(
    color: Colors.white,
    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(width: double.infinity,height: 200,
                image: NetworkImage('${productModel.image}')),
            if(productModel.discount!=0)
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
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${productModel.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style:const TextStyle(fontSize: 14,

                ) ,
              ),
              const SizedBox(height: 6,),
              Row(
                children: [
                  Text('Price: ${productModel.price!.round()}',
                    style:const TextStyle(fontSize: 14,
                     color: Colors.green,
                        fontWeight: FontWeight.bold,
                    ) ,
                  ),
                  const SizedBox(width: 5,),
                  if(productModel.discount!=0)
                  Text('${productModel.oldPrice!.round()}',
                    style:const TextStyle(fontSize: 12,
                        color: Colors.grey,
                      decoration: TextDecoration.lineThrough
                    ) ,
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed:(){
                        ShopCubit.get(context).changeFavorites(productModel.id!);

                      },
                      icon:  Icon(Icons.favorite_rounded,
                      color: ShopCubit.get(context).favorites[productModel.id]! ? Colors.red : Colors.grey[500],
                      )

                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
  Widget buildDisItem(ProductModel productModel) => Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(

      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 6,
          blurRadius: 11,
          offset: const Offset(3,3), // changes position of shadow
        ),
      ],
      color: Colors.white,
    ),
    child: Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children:
      [

        Image(
          image: NetworkImage('${productModel.image}'),

        ),
        Container(
          color: Colors.black.withOpacity(.8,),
          width: 100.0,

          child: Text(
            '${productModel.name}',
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );

}
