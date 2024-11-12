import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvmaze/blocs/movies/movies_bloc.dart';
import 'package:tvmaze/blocs/search/search_bloc.dart';

class AppProviders {
  List<BlocProvider> get providers {
    return [
      //admin
      BlocProvider<MoviesBloc>(create: (context) => MoviesBloc()),
      BlocProvider<SearchBloc>(create: (context) => SearchBloc()),
    ];
  }
}
