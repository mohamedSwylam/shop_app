import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/home_screen/cubit/states.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/sign_up_screen/cubit/states.dart';
import 'package:shop_app/shared/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(SignUpInitialState());

  static SignUpCubit get(context) => BlocProvider.of(context);
  ShopLoginModel loginModel;

  void userSignUp({
    @required String name,
    @required String email,
    @required String password,
    @required String phone,
  })
  {
    emit(SignUpLoadingState());

    DioHelper.postData(
      url: SIGNUP,
      data:
      {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then((value)
    {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(SignUpSuccessState(loginModel));
    }).catchError((error)
    {
      print(error.toString());
      emit(SignUpErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;

    emit(SignUpChangePasswordVisibilityState());
  }
}
