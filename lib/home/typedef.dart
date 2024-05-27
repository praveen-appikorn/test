import 'package:fpdart/fpdart.dart';
import 'package:test/home/models/failure.dart';

typedef FutureMake<T> = Future<Either<Failure, T>>;