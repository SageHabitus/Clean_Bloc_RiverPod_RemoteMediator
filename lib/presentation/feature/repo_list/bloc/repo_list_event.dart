import 'package:equatable/equatable.dart';

abstract class RepoListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchRepos extends RepoListEvent {
  final String username;

  FetchRepos(this.username);

  @override
  List<Object?> get props => [username];
}

class FetchMoreRepos extends RepoListEvent {
  final String username;

  FetchMoreRepos(this.username);

  @override
  List<Object?> get props => [username];
}

class RefreshRepos extends RepoListEvent {
  final String username;

  RefreshRepos(this.username);

  @override
  List<Object?> get props => [username];
}