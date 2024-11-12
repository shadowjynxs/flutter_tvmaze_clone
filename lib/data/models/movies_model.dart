class MoviesModel {
  final double score;
  final int id;
  final String url;
  final String name;
  final String type;
  final String language;
  final List<String> genres;
  final String status;
  final int? runtime;
  final int? averageRuntime;
  final String? premiered;
  final String? ended;
  final String? officialSite;
  final String scheduleTime;
  final List<String> scheduleDays;
  final double? averageRating;
  final String? networkName;
  final String? networkCountry;
  final String? imageUrlMedium;
  final String? imageUrlOriginal;
  final String summary;

  MoviesModel({
    required this.score,
    required this.id,
    required this.url,
    required this.name,
    required this.type,
    required this.language,
    required this.genres,
    required this.status,
    this.runtime,
    this.averageRuntime,
    this.premiered,
    this.ended,
    this.officialSite,
    required this.scheduleTime,
    required this.scheduleDays,
    this.averageRating,
    this.networkName,
    this.networkCountry,
    this.imageUrlMedium,
    this.imageUrlOriginal,
    required this.summary,
  });

  // Factory constructor for creating a new MoviesModel instance from JSON
  factory MoviesModel.fromJson(Map<String, dynamic> json) {
    final show = json['show'];

    return MoviesModel(
      score: json['score']?.toDouble() ?? 0.0,
      id: show['id'],
      url: show['url'] ?? '',
      name: show['name'] ?? 'No Title',
      type: show['type'] ?? 'Unknown',
      language: show['language'] ?? 'Unknown',
      genres: List<String>.from(show['genres'] ?? []),
      status: show['status'] ?? 'Unknown',
      runtime: show['runtime'],
      averageRuntime: show['averageRuntime'],
      premiered: show['premiered'],
      ended: show['ended'],
      officialSite: show['officialSite'],
      scheduleTime: show['schedule']?['time'] ?? '',
      scheduleDays: List<String>.from(show['schedule']?['days'] ?? []),
      averageRating: show['rating']?['average']?.toDouble(),
      networkName: show['network']?['name'],
      networkCountry: show['network']?['country']?['name'],
      imageUrlMedium: show['image']?['medium'],
      imageUrlOriginal: show['image']?['original'],
      summary: show['summary']?.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), '') ?? 'No Summary Available',
    );
  }

  factory MoviesModel.placeholder() {
    return MoviesModel(
      score: 0.0,
      id: 0,
      url: '',
      name: 'Loading...',
      type: 'N/A',
      language: 'N/A',
      genres: ['N/A'],
      status: 'N/A',
      scheduleTime: 'N/A',
      scheduleDays: ['N/A'],
      summary: 'Loading description...',
    );
  }
}
