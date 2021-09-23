import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/home_screen/cubit/states.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/login_screen/cubit/states.dart';
import 'package:shop_app/shared/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);
  ShopLoginModel loginModel;
  void getUserLogin({
    @required String email,
    @required String password,
  }) {
     emit(LoginLoadingState());
     DioHelper.postData(url: LOGIN, data: {
        'email' : email,
        'password' : password,
     }).then((value) {
        print(value.data);
        loginModel = ShopLoginModel.fromJson(value.data);
        emit(LoginSuccessState(loginModel));
     }).catchError((error){
        emit(LoginErrorState());
     });
  }
  IconData suffix = Icons.visibility_outlined;
  bool isPassword= true;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginChangePasswordVisibilityState());
  }

}
