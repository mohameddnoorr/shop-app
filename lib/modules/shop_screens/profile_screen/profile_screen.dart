import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/shop_cubit.dart';
import 'package:shop_app/layout/shop_layout/shop_states.dart';
import '../../../shared/components/components.dart';
import 'animated_icon.dart';



class ProfileScreen extends StatelessWidget {
   ProfileScreen({Key? key}) : super(key: key);

  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final phoneController = TextEditingController();

  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var model = ShopCubit.get(context).profileModel;
        nameController.text = model!.data!.name;
        emailController.text = model.data!.email;
        phoneController.text = model.data!.phone;
        return SingleChildScrollView(
          child: Form(key: formKey,
            child: Column(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 80,
                        decoration: const BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(80),
                            bottomRight: Radius.circular(80),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          height: 160,
                          width:160,
                          margin: const EdgeInsetsDirectional.only(
                            top: 12,
                          ),
                          decoration:  BoxDecoration(
                            border: Border.all(
                                color: Colors.white,
                                width: 3
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            shape: BoxShape.circle,

                          ),
                          child:    CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.teal,
                            backgroundImage:ShopCubit.get(context).pickImage == null? null: FileImage(ShopCubit.get(context).pickImage!),
                            child: Container(alignment: AlignmentDirectional.bottomEnd,

                              child:  CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white,
                                child: IconButton(
                                  onPressed:
                                    ShopCubit.get(context).imagePicker,
                                  icon: const Icon(
                                    Icons.camera_alt_rounded,
                                  ),
                                ),
                              ),
                            ),
                          ),

                        ),
                      ),

                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children:  [
                          Column(
                            children: [
                              Container(alignment: AlignmentDirectional.center,
                                  width: 80,
                                  height: 80,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.tealAccent
                                  ),
                                  child:   const AnimationIcon()
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text('Credit',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black38
                                ),
                              )
                            ],
                          ),
                          const Spacer(),
                          Column(
                            children: [
                              Container(alignment: AlignmentDirectional.center,
                                  width: 80,
                                  height: 80,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.tealAccent
                                  ),
                                  child: const AnimationIcon2()
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text('Points',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black38
                                ),
                              )
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),


                  const SizedBox(
                    height: 6,
                  ),
                  ConditionalBuilder(
                    condition:ShopCubit.get(context).profileModel != null ,
                    builder:(context){return Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(

                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: DefaultFormField(
                            border: InputBorder.none,
                            controller: nameController,
                            prefix: Icons.person,
                            obscure: false,
                            type: TextInputType.text,
                            validate: (String? value){return null;},
                            label:'Full Name' ,

                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(

                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: DefaultFormField(
                            border: InputBorder.none,
                            controller: phoneController,
                            prefix: Icons.phone_android_rounded,
                            obscure: false,
                            type: TextInputType.phone,
                            validate: (String? value){return null;},
                            label:'Mobile Number' ,

                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(

                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: DefaultFormField(
                            border: InputBorder.none,
                            controller: emailController,
                            prefix: Icons.email_rounded,
                            obscure: false,
                            type: TextInputType.emailAddress,
                            validate: (String? value){return null;},
                            label:'Email Address' ,

                          ),
                        ),
                      ],
                    );

                    },
                    fallback:(context)=>const Center(child: CircularProgressIndicator()) ,

                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(margin: const EdgeInsetsDirectional.only(end: 16),
                        height: 60,width: 60,
                        decoration: BoxDecoration(
                            color: Colors.teal,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset: const Offset(3, 3), // changes position of shadow
                              ),
                            ]
                        ),
                        child: IconButton(
                          onPressed: (){

                            if(formKey.currentState!.validate()){
                              ShopCubit.get(context).putUpProfileData(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                          icon: const Icon(Icons.edit,size: 30,color: Colors.white,),
                        ),
                      ),
                    ],
                  )
                ]
            ),
          ),
        );
      },
    );
  }


}


