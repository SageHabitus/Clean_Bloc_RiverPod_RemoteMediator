import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_sample/presentation/feature/user_list/bloc/user_list_event.dart';
import '../../../../di/usecase_provider.dart';
import 'user_list_bloc.dart';

final userListBlocProvider = Provider<UserListBloc>((ref) {
  final getUsersUseCase = ref.read(getUsersUseCaseProvider);
  final bloc = UserListBloc(getUsersUseCase: getUsersUseCase);
  bloc.add(FetchUsers());
  return bloc;
});
