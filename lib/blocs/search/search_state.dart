import 'package:equatable/equatable.dart';
import 'package:tvmaze/data/models/movies_model.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<MoviesModel> searchResults;

  const SearchLoaded(this.searchResults);

  @override
  List<Object> get props => [searchResults];
}

class SearchError extends SearchState {
  final String error;

  const SearchError({required this.error});

  @override
  List<Object> get props => [error];
}
