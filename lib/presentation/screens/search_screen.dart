import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvmaze/blocs/search/search_bloc.dart';
import 'package:tvmaze/blocs/search/search_event.dart';
import 'package:tvmaze/blocs/search/search_state.dart';
import 'package:tvmaze/presentation/widgets/movie_card.dart';
import 'package:tvmaze/data/models/movies_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final movieController = TextEditingController();

  @override
  void initState() {
    super.initState();
    movieController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    movieController.removeListener(_onSearchChanged);
    movieController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = movieController.text.trim();
    if (query.isNotEmpty) {
      context.read<SearchBloc>().add(PerformSearchEvent(query));
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: movieController,
              autofocus: true,
              showCursor: true,
              cursorColor: Colors.white,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                fillColor: Colors.grey.withOpacity(0.2),
                filled: true,
                hintText: "Search",
                hintStyle: const TextStyle(color: Colors.white70),
                prefixIcon: GestureDetector(
                    onTap: () {
                      _onSearchChanged();
                    },
                    child: const Icon(Icons.search_outlined, color: Colors.white)),
                suffixIcon: const Icon(Icons.mic_outlined, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is SearchLoaded) {
                  return _buildSearchResults(state.searchResults);
                } else if (state is SearchError) {
                  return Center(
                    child: Text(
                      "Error: ${state.error}",
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else {
                  return const Center(
                    child: Text(
                      "No results found",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(List<MoviesModel> searchResults) {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final movie = searchResults[index];
        return MovieCard(movie: movie);
      },
    );
  }
}
