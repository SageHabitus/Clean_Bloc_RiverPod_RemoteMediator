import 'package:equatable/equatable.dart';
import 'repo_item_state.dart';

abstract class RepoListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Init extends RepoListState {}

class Loading extends RepoListState {}

class Success extends RepoListState {
  final List<RepoItemState> repos;

  Success({required this.repos});

  Success copyWith({
    List<RepoItemState>? repos,
  }) {
    return Success(
      repos: repos ?? this.repos,
    );
  }

  @override
  List<Object?> get props => [repos];
}

class Error extends RepoListState {
  final String message;

  Error({required this.message});

  @override
  List<Object?> get props => [message];
}
