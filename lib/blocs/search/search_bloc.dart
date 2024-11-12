import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvmaze/blocs/search/search_event.dart';
import 'package:tvmaze/blocs/search/search_state.dart';
import 'package:tvmaze/data/providers/movies_api_provider.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {

  SearchBloc() : super(SearchInitial()) {
    on<PerformSearchEvent>(_onPerformSearchEvent);
  }

  void _onPerformSearchEvent(PerformSearchEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoading());

    try {
      final searchResults = await MoviesApiProvider().searchMovies(event.query);
      emit(SearchLoaded(searchResults));
    } catch (e) {
      emit(SearchError(error: e.toString()));
    }
  }
}
