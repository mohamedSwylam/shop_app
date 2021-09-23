import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layouts/home_screen/home_screen.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/login_screen/cubit/cubit.dart';
import 'package:shop_app/modules/login_screen/cubit/states.dart';
import 'package:shop_app/modules/sign_up_screen/sign_up_screen.dart';
import 'package:shop_app/shared/components.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.loginModel.status) {
              print(state.loginModel.message);
              print(state.loginModel.data.token);

              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data.token,
              ).then((value) {
                token = state.loginModel.data.token;

                navigateAndFinish(
                  context,
                  HomeScreen(),

                );
              });
            } else {
              print(state.loginModel.message);

              showToast(
                text: state.loginModel.message,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
            ),
            body: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        child: Image(
                          image: AssetImage('assets/images/login.png'),
                        ),
                      ),
                      Text(
                        'Salla Market',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: defaultFormField(
                          type: TextInputType.text,
                          controller: emailController,
                          paddingContent: 15,
                          labelText: 'E-mail address',
                          onTap: () {},
                          borderRaduis: 50,
                          borderColor: Colors.deepOrange,
                          errorBorderRaduis: 50,
                          focusedBorderRaduis: 50,
                          focusdborderColor: Colors.deepOrange,
                          cursorColor: Colors.deepOrange,
                          errorBorderColor: Colors.deepOrange,
                          enabledBorderRaduis: 50,
                          enabledBorderColor: Colors.deepOrange,
                          focusColor: Colors.deepOrange,
                          fillcolor: Colors.deepOrange,
                          iconColor: Colors.deepOrange,
                          prefix: Icons.email,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'email address must not be empty';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: defaultFormField(
                          type: TextInputType.visiblePassword,
                          controller: passwordController,
                          labelText: 'Password',
                          paddingContent: 15,
                          isPassword: LoginCubit
                              .get(context)
                              .isPassword,
                          suffix: LoginCubit
                              .get(context)
                              .suffix,
                          suffixPressed: () {
                            LoginCubit.get(context).changePasswordVisibility();
                          },
                          borderRaduis: 50,
                          borderColor: Colors.deepOrange,
                          errorBorderRaduis: 50,
                          focusedBorderRaduis: 50,
                          focusdborderColor: Colors.deepOrange,
                          cursorColor: Colors.deepOrange,
                          errorBorderColor: Colors.deepOrange,
                          enabledBorderRaduis: 50,
                          enabledBorderColor: Colors.deepOrange,
                          focusColor: Colors.deepOrange,
                          fillcolor: Colors.deepOrange,
                          iconColor: Colors.deepOrange,
                          prefix: Icons.lock,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Password is too short';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      ConditionalBuilder(
                        condition: state is! LoginLoadingState,
                        builder: (context) =>
                            Container(
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colors.deepOrange,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(50),
                                  topRight: Radius.circular(50),
                                  topLeft: Radius.circular(50),
                                  bottomLeft: Radius.circular(50),
                                ),
                              ),
                              child: defaultButton(
                                  function: () {
                                    if (formKey.currentState.validate()) {
                                      LoginCubit.get(context).getUserLogin(
                                          email: emailController.text,
                                          password: passwordController.text);
                                    }
                                  },
                                  text: 'Login'),
                            ),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'don\'have an account',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              navigateTo(context, SignUpScreen());
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
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
