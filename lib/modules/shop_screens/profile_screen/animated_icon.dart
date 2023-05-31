import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/shop_cubit.dart';
import 'package:shop_app/layout/shop_layout/shop_states.dart';

class AnimationIcon extends StatefulWidget {
  const AnimationIcon({Key? key}) : super(key: key);

  @override
  State<AnimationIcon> createState() => _AnimationIconState();
}

class _AnimationIconState extends State<AnimationIcon> {
  CrossFadeState crossFadeState = CrossFadeState.showFirst;
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        crossFadeState = CrossFadeState.showSecond;
      });
    });

    Future.delayed(const Duration(seconds: 8), () {
      setState(() {
        crossFadeState = CrossFadeState.showFirst;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var model = ShopCubit.get(context).profileModel;
        return AnimatedCrossFade(
          crossFadeState:crossFadeState ,
          duration:const Duration(seconds: 1),
          reverseDuration: const Duration(seconds: 2),
          firstCurve: Curves.easeInToLinear,
          secondCurve: Curves.easeInToLinear,
          firstChild:const Icon(Icons.credit_card_rounded,size: 50,color: Colors.white,) ,
          secondChild: Text('${model!.data!.credit}',
            style: const TextStyle(fontSize: 50,color: Colors.white,fontWeight: FontWeight.w900),) ,
        );
      },

    );

  }
}



class AnimationIcon2 extends StatefulWidget {
  const AnimationIcon2({Key? key}) : super(key: key);

  @override
  State<AnimationIcon2> createState() => _AnimationIcon2State();
}

class _AnimationIcon2State extends State<AnimationIcon2> {
  CrossFadeState crossFadeState = CrossFadeState.showFirst;
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        crossFadeState = CrossFadeState.showSecond;
      });
    });

    Future.delayed(const Duration(seconds: 8), () {
      setState(() {
        crossFadeState = CrossFadeState.showFirst;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var model = ShopCubit.get(context).profileModel;
        return AnimatedCrossFade(
        crossFadeState:crossFadeState ,
        duration:const Duration(seconds: 1),
        reverseDuration: const Duration(seconds: 2),
        firstCurve: Curves.easeInToLinear,
        secondCurve: Curves.easeInToLinear,
        firstChild:const Icon(Icons.monetization_on_rounded,size: 50,color: Colors.white,) ,
        secondChild: Text('${model!.data!.points}',
          style: const TextStyle(fontSize: 50,color: Colors.white,fontWeight: FontWeight.w900),) ,
      );
      },

    );

  }
}

