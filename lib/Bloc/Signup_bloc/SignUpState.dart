import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpFailure extends SignUpState {
  final String error;

 const SignUpFailure({this.error});

  @override
  List<Object> get props => [this.error];
}
class SignLoaded extends SignUpState {}