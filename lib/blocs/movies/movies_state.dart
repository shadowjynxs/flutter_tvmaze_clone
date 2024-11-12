import 'package:equatable/equatable.dart';
import 'package:tvmaze/data/models/movies_model.dart';

abstract class MoviesState extends Equatable {
  @override
  List<Object> get props => [];
}

class MoviesInitial extends MoviesState {}

class MoviesLoading extends MoviesState {}

class MoviesLoaded extends MoviesState {
  final List<MoviesModel> movies;
  final bool isLoaded;

  MoviesLoaded(this.movies, this.isLoaded);

  @override
  List<Object> get props => [movies];
}

class MoviesError extends MoviesState {
  final String error;

  MoviesError({required this.error});

  @override
  List<Object> get props => [error];
}
