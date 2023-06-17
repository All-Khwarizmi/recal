import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:recal_mobile2/domain/core/errors.dart';
import 'package:recal_mobile2/domain/core/failures.dart';

@immutable
abstract class ValueObject<T> {
  const ValueObject();
  Either<ValueFailure<T>, T> get value;

  bool isValid() => value.isRight();

  T getOrCrash() {
    return value.fold(
      (l) => throw UnexpectedValueError(l),
      id,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ValueObject<T> && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Value($value)';
}
