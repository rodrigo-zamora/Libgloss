part of 'details_bloc.dart';

@immutable
abstract class DetailsState {
  const DetailsState();

  Map<String, dynamic> get props => {};
}

class DetailsInitial extends DetailsState {}

class DetailsLoadingState extends DetailsState {}

class DetailsLoadedState extends DetailsState {
  @override
  final Map<String, dynamic> list;

  DetailsLoadedState({required this.list});

  @override
  Map<String, dynamic> get props => list;

  @override
  String toString() => 'DetailsLoaded { list: $list }';
}
