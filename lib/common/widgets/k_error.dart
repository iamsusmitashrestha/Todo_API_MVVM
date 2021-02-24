import 'package:Todo_API_MVVM/common/widgets/ui_helpers.dart';
import 'package:flutter/material.dart';

import 'k_outline_button.dart';

class KError extends StatelessWidget {
  final String error;
  final Function onRetry;

  KError({this.error, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              error,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  .copyWith(color: Colors.redAccent),
            ),
            sHeightSpan,
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: KOutlineButton(
                onPressed: onRetry,
                text: "Try Again!",
              ),
            )
          ],
        ));
  }
}
