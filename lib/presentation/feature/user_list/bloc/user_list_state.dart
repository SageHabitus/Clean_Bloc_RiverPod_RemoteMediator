import 'package:equatable/equatable.dart';
import 'ad_item_state.dart';
import 'user_item_state.dart';

abstract class UserListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Init extends UserListState {}

class Loading extends UserListState {}

class Success extends UserListState {
  final List<UserItemState> users;
  final AdItemState ad;

  Success({required this.users, required this.ad});

  Success copyWith({
    List<UserItemState>? users,
    AdItemState? ad,
  }) {
    return Success(
      users: users ?? this.users,
      ad: ad ?? this.ad,
    );
  }

  @override
  List<Object?> get props => [users, ad];
}

class Error extends UserListState {
  final String message;

  Error({required this.message});

  @override
  List<Object?> get props => [message];
}
