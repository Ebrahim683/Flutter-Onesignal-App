import '../../core/constrains/enum/result_status_enum.dart';

class Result<T> {
  final ResultStatusEnum status;
  final T? data;
  final String? error;

  Result._({required this.status, this.data, this.error});

  factory Result.success(T? data) =>
      Result._(status: ResultStatusEnum.success, data: data);

  factory Result.error(String? error) =>
      Result._(status: ResultStatusEnum.error, error: error);
}
