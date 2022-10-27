part of 'chat_cubit.dart';

class ChatState extends Equatable {
  const ChatState({
    required this.errorText,
    required this.messages,
    required this.status,
  });

  final String errorText;
  final List<MessageItem> messages;
  final MyStatus status;

  ChatState copyWith({String? errorText, List<MessageItem>? messages, MyStatus? status}) {
    return ChatState(
      errorText: errorText ?? this.errorText,
      messages: messages ?? this.messages,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [errorText, messages, status];
}
