import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohammed_ashraf/core/widgets/toast.dart';
import 'package:mohammed_ashraf/features/auth/domain/repositories/auth_repo.dart';
import 'package:mohammed_ashraf/features/auth/domain/usecases/login_use_case.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginUseCase loginUseCase;
  LoginCubit({required this.loginUseCase}) : super(LoginInitial());

  Future<void> loginEvent(
      {required String email, required String password}) async {
    emit(LoginLoading());
    final result =
        await loginUseCase.call(LoginParams(email: email, password: password));
    result.fold((failure) => emit(LoginError(message: failure.message)),
        (user) {
      showSucessToast("Login Successfully");
      emit(LoginSuccess());
    });
  }
}
