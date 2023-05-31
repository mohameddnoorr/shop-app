import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_screens/register_screen/register_cubit.dart';
import 'package:shop_app/modules/shop_screens/register_screen/register_states.dart';

import '../../../layout/shop_layout/shop_layout.dart';
import '../../../shared/components/components.dart';
import '../../../shared/network/local/cache_helper.dart';


class RegisterScreen extends StatelessWidget {
   RegisterScreen({Key? key}) : super(key: key);


  final emailController = TextEditingController();
   final passwordController = TextEditingController();
   final phoneController = TextEditingController();
   final nameController = TextEditingController();


   final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context,state){
          if (state is RegisterSuccessState) {
            if (state.loginModel!.status) {
              if (kDebugMode) {
                print(state.loginModel!.message);
              }
              if (kDebugMode) {
                print(state.loginModel!.data!.token);
              }
              showToast(
                  states: ToastStates.SUCCESS,
                  msg: state.loginModel!.message);
              CacheHelper.saveData(
                  key: 'token',
                  value: state.loginModel!.data!.token)
                  .then((value) {
                token = state.loginModel!.data!.token;
                navigateAndFinish(context, const ShopLayout());
              });
            } else {
              if (kDebugMode) {
                print(state.loginModel!.message);
              }
              showToast(
                  states: ToastStates.ERROR,
                  msg: state.loginModel!.message);
            }
          }
        },
        builder:(context,state){return  Scaffold(
          appBar: AppBar(backgroundColor: Colors.teal,
            toolbarHeight: 8,),

          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.teal,
                  Colors.black,
                  Colors.teal.withOpacity(.4).withBlue(1)
                ],
                stops: const [0.1, 0.6, 1.0],
              ),
            ),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Image(height: 100,
                      image: AssetImage('assets/images/logo.png'),
                      filterQuality: FilterQuality.high,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(

                      padding: const EdgeInsets.symmetric(
                          vertical: 94, horizontal: 28),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(220),
                          bottomRight: Radius.circular(220),
                        ),
                      ),
                      child: Column(
                        children: [
                          DefaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'User Name is required';
                              }
                              return null;
                            },
                            label: 'User Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            prefix: Icons.person,
                            obscure: false,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          DefaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Email Address is required';
                              }
                              return null;
                            },
                            label: 'Email Address',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            prefix: Icons.email_rounded,
                            obscure: false,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          DefaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Password is required';
                              }
                              return null;
                            },
                            label: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            prefix: Icons.lock,
                             obscure: RegisterCubit.get(context).isPassword,

                            onPressed: () {
                               RegisterCubit.get(context).changeObscure();
                            },
                             suffix: RegisterCubit.get(context).suffix
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          DefaultFormField(
                            controller: phoneController,
                            type: TextInputType.number,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Mobile Number is required';
                              }
                              return null;
                            },
                            label: 'Mobile Number',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            prefix: Icons.lock,
                            // obscure: LoginCubit.get(context).isPassword,
                            obscure: false,
                            onPressed: () {
                              // LoginCubit.get(context).changeObscure();
                            },
                            // suffix: LoginCubit.get(context).suffix
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          ConditionalBuilder(
                            condition:  state is! RegisterLoadingState,
                            builder: (context) => defaultTextButton(
                                text: 'REGISTER',
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    RegisterCubit.get(context).usersRegister(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        phone: phoneController.text,
                                        name: nameController.text
                                    );

                                  }
                                  emailController.clear();
                                  passwordController.clear();
                                }),
                            fallback: (context) => const Center(
                                child: CircularProgressIndicator()),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );} ,

      ),
    );
  }
}
