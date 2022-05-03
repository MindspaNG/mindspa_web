import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../utilities/enums/app_enums.dart';

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final builders = {
    DialogType.success: (BuildContext context, DialogRequest request,
            Function(DialogResponse) completer) =>
        SuccessDialog(request: request, completer: completer),
    DialogType.error: (BuildContext context, DialogRequest request,
            Function(DialogResponse) completer) =>
        ErrorDialog(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}

class SuccessDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const SuccessDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 237, 255, 248),
            borderRadius: BorderRadius.all(
              Radius.circular(24),
            )),
        height: size.height * 0.70,
        width: size.width * 0.70,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Icon(
                Icons.check_circle,
                size: 150,
                color: Color(0XFF516D61),
              ),
              Text(
                'Thank you for opting into our waitlist, you will be notified when there is an early build.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Color(0XFF516D61)),
              ),
              Text(
                'You will be redirected to our blog site.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                    color: Color(0XFF516D61)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ErrorDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const ErrorDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.all(
            Radius.circular(24),
          ),
        ),
        height: size.height * 0.70,
        width: size.width * 0.70,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.error_outline_outlined,
                size: 150,
                color: Color(0XFF516D61),
              ),
              Text(
                request.title ?? 'Something went wrong, pls try again',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Color(0XFF516D61)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 150),
                child: MaterialButton(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(24))),
                  height: 50,
                  onPressed: () => completer(DialogResponse(confirmed: true)),
                  child: const Text(
                    'Try again',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  color: const Color(0XFF516D61),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
