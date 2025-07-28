import 'package:dartz/dartz.dart';
import 'package:weather_app_assignment4/app/core/error/failures.dart';

typedef Result<T> = Future<Either<Failure, T>>;
typedef ApiResult<T> = Future<Either<Failure, T>>;
