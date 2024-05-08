import 'tv_series_model.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';

class TvSeriesTable extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  const TvSeriesTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview
  });

  factory TvSeriesTable.fromEntity(TvSeriesDetail tv) => TvSeriesTable(
    id: tv.id, 
    name: tv.name, 
    posterPath: tv.posterPath, 
    overview: tv.overview
  );

  TvSeries toEntity() => TvSeries.watchlist(
    id: id, 
    name: name,
    overview: overview, 
    posterPath: posterPath,
  );

  factory TvSeriesTable.fromMap(Map<String, dynamic> map) => TvSeriesTable(
    id: map['id'],
    name: map['name'],
    posterPath: map['posterPath'],
    overview: map['overview']
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'posterPath': posterPath,
    'overview': overview
  };

  factory TvSeriesTable.fromDTO(TvSeriesModel tv) => TvSeriesTable(
    id: tv.id, 
    name: tv.name, 
    posterPath: tv.posterPath, 
    overview: tv.overview
  );

  @override
  List<Object?> get props => [id, name, posterPath, overview];
}