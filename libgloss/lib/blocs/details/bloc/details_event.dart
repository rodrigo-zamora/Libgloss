part of 'details_bloc.dart';

@immutable
abstract class DetailsEvent {
  const DetailsEvent();

  List<Object?> get props => [];
}

class DetailsMoveEvent extends DetailsEvent {
  final dynamic list;

  DetailsMoveEvent({required this.list});

  @override
  List<Object?> get props => [list];
}
