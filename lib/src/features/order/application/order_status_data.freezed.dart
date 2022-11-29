// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'order_status_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$OrderStatusData {
  String get orderId => throw _privateConstructorUsedError;
  OrderStatus get status => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OrderStatusDataCopyWith<OrderStatusData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderStatusDataCopyWith<$Res> {
  factory $OrderStatusDataCopyWith(
          OrderStatusData value, $Res Function(OrderStatusData) then) =
      _$OrderStatusDataCopyWithImpl<$Res>;
  $Res call({String orderId, OrderStatus status});
}

/// @nodoc
class _$OrderStatusDataCopyWithImpl<$Res>
    implements $OrderStatusDataCopyWith<$Res> {
  _$OrderStatusDataCopyWithImpl(this._value, this._then);

  final OrderStatusData _value;
  // ignore: unused_field
  final $Res Function(OrderStatusData) _then;

  @override
  $Res call({
    Object? orderId = freezed,
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      orderId: orderId == freezed
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OrderStatus,
    ));
  }
}

/// @nodoc
abstract class _$$_OrderStatusDataCopyWith<$Res>
    implements $OrderStatusDataCopyWith<$Res> {
  factory _$$_OrderStatusDataCopyWith(
          _$_OrderStatusData value, $Res Function(_$_OrderStatusData) then) =
      __$$_OrderStatusDataCopyWithImpl<$Res>;
  @override
  $Res call({String orderId, OrderStatus status});
}

/// @nodoc
class __$$_OrderStatusDataCopyWithImpl<$Res>
    extends _$OrderStatusDataCopyWithImpl<$Res>
    implements _$$_OrderStatusDataCopyWith<$Res> {
  __$$_OrderStatusDataCopyWithImpl(
      _$_OrderStatusData _value, $Res Function(_$_OrderStatusData) _then)
      : super(_value, (v) => _then(v as _$_OrderStatusData));

  @override
  _$_OrderStatusData get _value => super._value as _$_OrderStatusData;

  @override
  $Res call({
    Object? orderId = freezed,
    Object? status = freezed,
  }) {
    return _then(_$_OrderStatusData(
      orderId: orderId == freezed
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OrderStatus,
    ));
  }
}

/// @nodoc

class _$_OrderStatusData extends _OrderStatusData {
  const _$_OrderStatusData({required this.orderId, required this.status})
      : super._();

  @override
  final String orderId;
  @override
  final OrderStatus status;

  @override
  String toString() {
    return 'OrderStatusData(orderId: $orderId, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OrderStatusData &&
            const DeepCollectionEquality().equals(other.orderId, orderId) &&
            const DeepCollectionEquality().equals(other.status, status));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(orderId),
      const DeepCollectionEquality().hash(status));

  @JsonKey(ignore: true)
  @override
  _$$_OrderStatusDataCopyWith<_$_OrderStatusData> get copyWith =>
      __$$_OrderStatusDataCopyWithImpl<_$_OrderStatusData>(this, _$identity);
}

abstract class _OrderStatusData extends OrderStatusData {
  const factory _OrderStatusData(
      {required final String orderId,
      required final OrderStatus status}) = _$_OrderStatusData;
  const _OrderStatusData._() : super._();

  @override
  String get orderId;
  @override
  OrderStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$_OrderStatusDataCopyWith<_$_OrderStatusData> get copyWith =>
      throw _privateConstructorUsedError;
}
