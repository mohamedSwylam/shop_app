import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/home_screen/home_screen.dart';
import 'package:shop_app/modules/sign_up_screen/cubit/cubit.dart';
import 'package:shop_app/modules/sign_up_screen/cubit/states.dart';
import 'package:shop_app/shared/components.dart';
import 'package:shop_app/shared/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class SignUpScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpStates>(
        listener: (context, state) {
          if (state is SignUpSuccessState) {
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
            body: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Form(
                  key: formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                  Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Container(
                    height: 100,
                    child: Image(
                      image: AssetImage('assets/images/login.png'),
                    ),
                  ),
                ),
                Text(
                  'Salla Market',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: defaultFormField(
                    type: TextInputType.text,
                    controller: nameController,
                    labelText: 'User name',
                    paddingContent: 15,
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
                    prefix: Icons.person,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'name must not be empty ';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultFormField(
                    type: TextInputType.emailAddress,
                    controller: emailController,
                    labelText: 'E-mail address',
                    onTap: () {},
                    paddingContent: 15,
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
                    prefix: Icons.lock,
                    isPassword: SignUpCubit.get(context).isPassword,
                    suffix: SignUpCubit.get(context).suffix,
                    suffixPressed: (){
                      SignUpCubit.get(context).changePasswordVisibility();
                    },
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
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: defaultFormField(
                    type: TextInputType.phone,
                    controller: phoneController,
                    paddingContent: 15,
                    labelText: 'Phone Number',
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
                    prefix: Icons.phone,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'Phone Number must not be empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                ConditionalBuilder(
                  condition: state is! SignUpLoadingState,
                  builder: (context) {
                    return Container(
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
                      child:
                      defaultButton(
                          function: (){if (formKey.currentState.validate()) {
                        SignUpCubit.get(context).userSignUp(
                            email: emailController.text,
                            name: nameController.text,
                            phone: phoneController.text,
                            password: passwordController.text);
                      }},
                          text: 'Sign Up'),
                    );
                  },
                  fallback: (context) =>
                      Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
          ),)
          ,
          )
          ,
          );
        },
      ),
    );
  }
}
