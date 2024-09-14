import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_sample/presentation/feature/user_list/bloc/user_item_state.dart';
import '../../../../domain/github/get_github_users_usecase.dart';
import '../../../resource/alert_message.dart';
import 'ad_item_state.dart';
import 'user_list_event.dart';
import 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final GetUsersUseCase getUsersUseCase;
  int _currentPage = 1;
  bool _isFetching = false;

  UserListBloc({required this.getUsersUseCase}) : super(Init()) {
    on<FetchUsers>(_onGetUsers);
    on<RefreshUsers>(_onRefreshUsers);
  }

  Future<void> _onGetUsers(
      FetchUsers event, Emitter<UserListState> emit) async {
    if (_isFetching) return;
    _isFetching = true;

    if (state is Init || state is Loading) {
      emit(Loading());
    }

    try {
      final userAdDataModel =
          await getUsersUseCase.call(Params(page: _currentPage));
      final users = userAdDataModel.userDataModels
          .map((user) => UserItemState.toState(user))
          .toList();
      final ad = AdItemState.toState(userAdDataModel.adDataModel);

      if (state is Success) {
        final previousUsers = (state as Success).users;
        emit(Success(users: previousUsers + users, ad: ad));
      } else {
        emit(Success(users: users, ad: ad));
      }
      _currentPage++;
    } catch (e) {
      emit(Error(message: AlertMessage.errorFetchingUsers));
    } finally {
      _isFetching = false;
    }
  }

  Future<void> _onRefreshUsers(
      RefreshUsers event, Emitter<UserListState> emit) async {
    _currentPage = 1;
    emit(Loading());
    try {
      final userAdDataModel =
          await getUsersUseCase.call(Params(page: _currentPage));
      final users = userAdDataModel.userDataModels
          .map((user) => UserItemState.toState(user))
          .toList();
      final ad = AdItemState.toState(userAdDataModel.adDataModel);
      emit(Success(users: users, ad: ad));
      _currentPage++;
    } catch (e) {
      emit(Error(message: AlertMessage.errorFetchingUsers));
    }
  }
}
