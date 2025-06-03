import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohammed_ashraf/features/auth/domain/repositories/auth_repo.dart';
import 'package:mohammed_ashraf/features/auth/domain/usecases/register_use_case.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterUseCase registerUseCase;
  RegisterCubit({required this.registerUseCase}) : super(RegisterInitial());

  Future<void> registerEvent(RegisterParams params) async {
    emit(RegisterLoading());
    final result = await registerUseCase.call(params);
    result.fold((failure) => emit(RegisterError(message: failure.message)),
        (user) => emit(RegisterSuccess()));
  }
}
