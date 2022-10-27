part of 'device_cubit.dart';

class DeviceState extends Equatable {
  const DeviceState({
    required this.errorText,
    required this.devices,
    required this.status,
  });

  final String errorText;
  final List<DeviceItem> devices;
  final MyStatus status;

  DeviceState copyWith({String? errorText, List<DeviceItem>? devices, MyStatus? status}) {
    return DeviceState(
      errorText: errorText ?? this.errorText,
      devices: devices ?? this.devices,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [errorText, devices, status];
}
