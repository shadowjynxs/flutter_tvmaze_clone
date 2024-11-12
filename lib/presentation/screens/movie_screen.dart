import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tvmaze/data/models/movies_model.dart';

class MovieScreen extends StatefulWidget {
  final MoviesModel movie;
  const MovieScreen({
    super.key,
    required this.movie,
  });

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 0, 0, 1),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height: 30.h,
                  width: double.infinity,
                  child: widget.movie.imageUrlMedium != null && widget.movie.imageUrlMedium!.isNotEmpty
                      ? Image.network(
                          widget.movie.imageUrlMedium!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        )
                      : Center(child: Icon(Icons.movie, size: 50))),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText(widget.movie.name, 22.sp, FontWeight.w500),
                  if (widget.movie.averageRating != null)
                    RatingBar.readOnly(
                      filledIcon: Icons.star,
                      emptyIcon: Icons.star_border,
                      initialRating: widget.movie.averageRating! / 2,
                      size: 28,
                    )
                ],
              ),
              Row(
                children: [
                  if (widget.movie.premiered != null && widget.movie.premiered!.isNotEmpty) Text(widget.movie.premiered!.split('-')[0]),
                  const SizedBox(width: 10),
                  if (widget.movie.language.isNotEmpty) Text(widget.movie.language),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.play_arrow,
                      color: Colors.black,
                    ),
                    Text(
                      "Play",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(widget.movie.summary),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  customFooter("My List", Icons.add_outlined),
                  customFooter("Rate", Icons.thumb_up_alt_outlined),
                  customFooter("Share", Icons.share_outlined),
                  customFooter("Download", Icons.download_outlined),
                ],
              ),
              const SizedBox(height: 20),
              Divider(),
              const SizedBox(height: 10),
              customText("More Info", 22.sp, FontWeight.w500),
              const SizedBox(height: 10),
              if (widget.movie.networkName != null) Text("Network: ${widget.movie.networkName}"),
              if (widget.movie.scheduleDays.isNotEmpty)
                Text(
                  "Schedule: ${widget.movie.scheduleDays[0]} at ${widget.movie.scheduleTime} (${widget.movie.averageRuntime} min)",
                ),
              if (widget.movie.type.isNotEmpty) Text("Show Type: ${widget.movie.type}"),
              if (widget.movie.genres.isNotEmpty) Text("Genres: ${widget.movie.genres.join(" | ")}"),
              if (widget.movie.officialSite != null) Text("Official Site: ${widget.movie.officialSite}"),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  Widget customFooter(String text, IconData icons) {
    return Column(
      children: [
        Icon(icons),
        Text(text),
      ],
    );
  }

  Widget customText(
    String text,
    double size,
    FontWeight weight,
  ) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
      ),
    );
  }
}
