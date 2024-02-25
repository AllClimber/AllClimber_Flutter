import 'package:flutter/material.dart';

typedef SuccessBuilder<T> = Widget Function(BuildContext context, T data);
typedef FailureBuilder = Widget Function(BuildContext context);
typedef EmptyBuilder = Widget Function(BuildContext context);
typedef LoadingBuilder = Widget Function(BuildContext context);

class CustomFutureBuilder<T> extends StatelessWidget {
  const CustomFutureBuilder({
    super.key,
    required this.future,
    required this.successBuilder,
    this.failureBuilder,
    this.emptyBuilder,
    this.loadingBuilder,
  });
  final Future<T>? future;
  final SuccessBuilder<T> successBuilder;
  final FailureBuilder? failureBuilder;
  final EmptyBuilder? emptyBuilder;
  final LoadingBuilder? loadingBuilder;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        final status = snapshot.connectionState;
        final data = snapshot.data;

        // Loading
        if (status == ConnectionState.waiting) {
          return loadingBuilder?.call(context) ??
              const Center(child: CircularProgressIndicator());
        }

        // Failure
        if (snapshot.hasError) {
          return failureBuilder?.call(context) ??
              const DefaultMessageBox(text: "Error");
        }

        // Empty
        if (!snapshot.hasData || (data is List && data.isEmpty)) {
          return emptyBuilder?.call(context) ??
              const DefaultMessageBox(text: "Empty");
        }

        // Success
        return successBuilder.call(context, data as T);
      },
    );
  }
}

class DefaultMessageBox extends StatelessWidget {
  const DefaultMessageBox({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
    );
  }
}
