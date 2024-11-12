import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvmaze/blocs/movies/movies_event.dart';
import 'package:tvmaze/blocs/movies/movies_state.dart';
import 'package:tvmaze/data/providers/movies_api_provider.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesBloc() : super(MoviesInitial()) {
    on<FetchMoviesEvent>(_onFetchMoviesEvent);
  }

  void _onFetchMoviesEvent(FetchMoviesEvent event, Emitter<MoviesState> emit) async {
    emit(MoviesLoading());

    bool isLoaded = false;

    try {
      final movies = await MoviesApiProvider().fetchMovies();
      isLoaded = true;
      emit(MoviesLoaded(movies, isLoaded));
    } catch (e) {
      emit(MoviesError(error: e.toString()));
    }
  }
}
