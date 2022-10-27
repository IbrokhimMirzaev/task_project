part of 'users_cubit.dart';

class UserState extends Equatable {
  const UserState({
    required this.errorText,
    required this.users,
    required this.status,
  });

  final String errorText;
  final List<UserItem> users;
  final MyStatus status;

  UserState copyWith({String? errorText, List<UserItem>? users, MyStatus? status}) {
    return UserState(
      errorText: errorText ?? this.errorText,
      users: users ?? this.users,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [errorText, users, status];
}
