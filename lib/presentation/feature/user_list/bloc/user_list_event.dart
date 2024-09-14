import 'package:equatable/equatable.dart';

abstract class UserListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchUsers extends UserListEvent {}

class RefreshUsers extends UserListEvent {}
