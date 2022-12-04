import 'package:dartz/dartz.dart';

import '../error/failures.dart';

class InputConverter {
  Either<Failure, int>? stringToUnsignedInteger(String str) {
    try {
      int result = int.parse(str);

      if (result < 0) {
        throw const FormatException();
      } else {
        return Right(result);
      }
    } on FormatException {
      return const Left(InvalidInputFailure(message: ''));
    }
  }
}
