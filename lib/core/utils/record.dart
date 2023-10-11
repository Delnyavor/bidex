import 'package:bidex/core/error/failures.dart';

class DataRecord<T> {
  final ({T? data, Failure? error}) dataRecord;

  DataRecord(this.dataRecord) : assert(dataRecord.data != dataRecord.error);
}
