import 'package:equatable/equatable.dart';


abstract class ChatState extends Equatable{
  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {}

class ChatSuccess extends ChatState{}

class ChatError extends ChatState{
  final String error;

  ChatError(this.error);
}


