import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../helpers/storage_helper.dart';
import '../../helpers/storage_keys.dart';
import '../../models/user_model.dart';
import 'authentication_repository.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationRepository _repository = AuthenticationRepository();
  AuthenticationCubit() : super(AuthenticationInitial());
  void createUser(UserModel userModel)async{
    emit(AuthenticationLoading());
    try {
      UserCredential user = await _repository.createUser(
          userModel.email, userModel.password ?? "");
      String token = await user.user!.getIdToken();
      String uid = user.user!.uid;
      StorageHelper.writeData(StorageKeys.token.name, token);
      StorageHelper.writeData(StorageKeys.uid.name, uid);
      userModel.id = uid;
      _repository.storeUserData(userModel);
      emit(AuthenticationSuccess());
    }catch(ex){
      emit(AuthenticationFailure("error"));
    }
  }
  loginUser(String email,String password) async{
    emit(AuthenticationLoading());
    try{
      UserCredential user = await _repository.loginUser(email, password);
      String token = await user.user!.getIdToken();
      String uid = user.user!.uid;
      emit(AuthenticationSuccess());
    }catch(ex){
      emit(AuthenticationFailure("error"));
    }
  }

}
