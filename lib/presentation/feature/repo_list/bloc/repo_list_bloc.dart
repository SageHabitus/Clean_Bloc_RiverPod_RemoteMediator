import 'package:flutter_bloc/flutter_bloc.dart';
import 'repo_item_state.dart';
import 'repo_list_event.dart';
import 'repo_list_state.dart';
import '../../../../domain/github/get_github_user_repos_usecase.dart';
import '../../../resource/alert_message.dart';

class RepoListBloc extends Bloc<RepoListEvent, RepoListState> {
  final GetUserReposUseCase getUserReposUseCase;
  int _currentPage = 1;
  bool _isFetching = false;

  RepoListBloc({required this.getUserReposUseCase}) : super(Init()) {
    on<FetchRepos>(_onFetchRepos);
    on<FetchMoreRepos>(_onFetchMoreRepos);
    on<RefreshRepos>(_onRefreshRepos);
  }

  Future<void> _onFetchRepos(
      FetchRepos event, Emitter<RepoListState> emit) async {
    if (_isFetching) return;
    _isFetching = true;

    emit(Loading());

    try {
      final repos = await getUserReposUseCase.call(Params(
        username: event.username,
        page: _currentPage,
      ));

      final repoStates = repos
          .map((repo) => RepoItemState.toState(repo))
          .toList();

      emit(Success(repos: repoStates));

      _currentPage++;
    } catch (e) {
      emit(Error(message: AlertMessage.errorFetchingRepos));
    } finally {
      _isFetching = false;
    }
  }

  Future<void> _onFetchMoreRepos(
      FetchMoreRepos event, Emitter<RepoListState> emit) async {
    if (_isFetching) return;
    _isFetching = true;

    try {
      final repos = await getUserReposUseCase.call(Params(
        username: event.username,
        page: _currentPage,
      ));

      final repoStates = repos
          .map((repo) => RepoItemState.toState(repo))
          .toList();

      if (state is Success) {
        final currentRepos = (state as Success).repos;
        emit(Success(repos: currentRepos + repoStates));
      } else {
        emit(Success(repos: repoStates));
      }

      _currentPage++;
    } catch (e) {
      emit(Error(message: AlertMessage.errorFetchingRepos));
    } finally {
      _isFetching = false;
    }
  }

  Future<void> _onRefreshRepos(
      RefreshRepos event, Emitter<RepoListState> emit) async {
    _currentPage = 1;
    emit(Loading());
    try {
      final repos = await getUserReposUseCase.call(Params(
        username: event.username,
        page: _currentPage,
      ));

      final repoStates = repos
          .map((repo) => RepoItemState.toState(repo))
          .toList();

      emit(Success(repos: repoStates));

      _currentPage++;
    } catch (e) {
      emit(Error(message: AlertMessage.errorFetchingRepos));
    }
  }
}