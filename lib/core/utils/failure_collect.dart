import 'package:dartz/dartz.dart';
import 'package:tharad_task/core/error/exceptions.dart';
import 'package:tharad_task/core/error/failure.dart';

Future<Either<Failure, T>> failureCollect<T>(
  Future<Either<Failure, T>> Function() task, {
  Future<Failure?> Function(Exception exception)? catchException,
  Future<Failure?> Function(Object? exception)? catchError,
}) async {
  try {
    return await task();
  } catch (e) {
    if (catchException != null && e is Exception) {
      final failure = await catchException(e);
      if (failure != null) return Left(failure);
    } else if (catchError != null) {
      final failure = await catchError(e);
      if (failure != null) return Left(failure);
    }

    if (e is ApiRequestException) {
      return Left(RequestFailure(message: e.message));
    } else if (e is ServerException) {
      return Left(ServerFailure(message: e.message, errorMap: e.errorMap));
    } else if (e is UnauthorizedException) {
      return Left(UnAuthorizedFailure(message: e.message));
    } else if (e is UnExpectedException) {
      return Left(UnExpectedFailure(message: e.message));
    } else {
      return Left(UnExpectedFailure(message: e.toString()));
    }
  }
}
