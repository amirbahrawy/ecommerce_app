import 'package:ecommerce_app/modules/login/cubit/login_states.dart';
import 'package:ecommerce_app/shared/components/constants.dart';
import 'package:ecommerce_app/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/login_model.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);
  IconData suffix=Icons.visibility_outlined;
  bool isPassword=true;
  LoginModel? loginModel;
  void userLogin({required String email,required String password}) {
    emit(LoginLoadingState());
    DioHelper.postData(url: login, data: {
      'email': email,
      'password': password
    }
    ).then((value) {
      loginModel=LoginModel.fromJson(value.data);
      debugPrint(loginModel?.message);
      emit(LoginSuccessState(loginModel));
    }).catchError((error){
      debugPrint(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }
  void changePasswordVisibility(){
    isPassword=!isPassword;
    suffix=isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(LoginChangeVisibilityState());
  }
}
