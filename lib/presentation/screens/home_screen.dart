import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tvmaze/blocs/movies/movies_bloc.dart';
import 'package:tvmaze/blocs/movies/movies_event.dart';
import 'package:tvmaze/blocs/movies/movies_state.dart';
import 'package:tvmaze/data/models/movies_model.dart';
import 'package:tvmaze/presentation/screens/search_screen.dart';
import 'package:tvmaze/presentation/widgets/movie_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _tabController = PersistentTabController();
  @override
  void initState() {
    super.initState();
    context.read<MoviesBloc>().add(FetchMoviesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 0, 0, 1),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Image.asset('lib/assets/logo.png'),
        ),
        leadingWidth: 100,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.download_outlined),
          ),
          GestureDetector(
            onTap: () {
              _tabController.jumpToTab(1);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.search_outlined),
            ),
          ),
        ],
      ),
      body: PersistentTabView(
        controller: _tabController,
        tabs: [
          PersistentTabConfig(
            screen: homeScreen(),
            item: ItemConfig(
              icon: Icon(Icons.home),
              title: "Home",
              activeForegroundColor: Colors.white,
              inactiveForegroundColor: Colors.grey.shade800,
            ),
          ),
          PersistentTabConfig(
            screen: SearchScreen(),
            item: ItemConfig(
              icon: Icon(Icons.search_outlined),
              title: "Search",
              activeForegroundColor: Colors.white,
              inactiveForegroundColor: Colors.grey.shade800,
            ),
          ),
          PersistentTabConfig(
            screen: settingScreen(),
            item: ItemConfig(
              icon: Icon(Icons.person),
              title: "My TVMAZE",
              activeForegroundColor: Colors.white,
              inactiveForegroundColor: Colors.grey.shade800,
            ),
          ),
        ],
        navBarBuilder: (navBarConfig) => Style7BottomNavBar(
          navBarConfig: navBarConfig,
          navBarDecoration: NavBarDecoration(color: Color.fromRGBO(0, 0, 0, 1)),
        ),
      ),
    );
  }

  Widget homeScreen() {
    return Scaffold(
      body: BlocBuilder<MoviesBloc, MoviesState>(
        builder: (context, state) {
          if (state is MoviesLoading) {
            return Skeletonizer(
              child: GridView.builder(
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                ),
                itemCount: 10,
                itemBuilder: (context, index) => MovieCard(movie: MoviesModel.placeholder()),
              ),
            );
          }
          if (state is MoviesLoaded) {
            final movies = state.movies;
            if (movies.isEmpty) {
              return Center(child: Text("No movies found"));
            }
            return GridView.builder(
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return MovieCard(movie: movie);
              },
            );
          } else if (state is MoviesError) {
            return Center(child: Text("Error: ${state.error}"));
          } else {
            return Center(child: Text("No movies found"));
          }
        },
      ),
    );
  }

  Widget settingScreen() {
    return Scaffold(
      body: Center(
        child: Text("Setting Screen"),
      ),
    );
  }
}
