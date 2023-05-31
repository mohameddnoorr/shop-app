import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout/shop_layout.dart';
import 'package:shop_app/modules/shop_screens/login_screens/login_cubit.dart';
import 'package:shop_app/modules/shop_screens/login_screens/login_states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import '../register_screen/register_screen.dart';

class ShopLoginScreen extends StatelessWidget {
  ShopLoginScreen({Key? key}) : super(key: key);

  final textController = TextEditingController();

  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
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
        builder: (context, state) {
          return Scaffold(
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
                          vertical: 64, horizontal: 18),
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
                          const SizedBox(
                            height: 84,
                          ),
                          DefaultFormField(
                            controller: textController,
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
                              obscure: LoginCubit.get(context).isPassword,
                              onPressed: () {
                                LoginCubit.get(context).changeObscure();
                              },
                              suffix: LoginCubit.get(context).suffix),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {},
                                  child: const Text('Forget Password?'))
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ConditionalBuilder(
                            condition: state is! LoginLoadingState,
                            builder: (context) => Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: defaultTextButton(
                                  text: 'LOGIN',
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      LoginCubit.get(context).usersLogin(
                                          email: textController.text,
                                          password:
                                              passwordController.text);
                                      if (kDebugMode) {
                                        print(textController.text);
                                      }
                                      if (kDebugMode) {
                                        print(passwordController.text);
                                      }
                                    }
                                    textController.clear();
                                    passwordController.clear();
                                  }),
                            ),
                            fallback: (context) => const Center(
                                child: CircularProgressIndicator()),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Center(
                            child: Text(
                              '- Sign In with - ',
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: const Image(
                                  height: 40,
                                  image: AssetImage(
                                      'assets/images/pngaaa.com-206454.png'),
                                ),
                              ),
                              const SizedBox(
                                width: 40,
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Image(
                                  height: 40,
                                  image: AssetImage(
                                      'assets/images/105-1055517_google-chrome-icon-google-logo-round-png.png'),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Don\'t have an Account?'),
                              TextButton(
                                  onPressed: () {
                                    navigateTo(context,  RegisterScreen());
                                  },
                                  child: const Text(
                                    'Sign-Up',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.teal,
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
                ),
              ),
          );
        },
      ),
    );
  }
}
