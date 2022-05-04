part of coming_soon_view;

class _ComingSoonDesktop extends StatelessWidget {
  final ComingSoonViewModel viewModel;

  const _ComingSoonDesktop(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1512, 1075.2),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_) => Scaffold(
        body: Column(
          children: [
            const TopBar(),
            Column(
              children: [
                const SubLongText(),
                SizedBox(
                  height: 72.h,
                ),
                const LaunchingSoonWidget(),
                SizedBox(
                  height: 72.h,
                ),
                const CountDownTimer(),
              ],
            ),
            Expanded(
              child: Stack(
                children: [
                  TextFieldAndSubmitButton(viewModel: viewModel),
                  const BottomBar(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LaunchingSoonWidget extends StatelessWidget {
  const LaunchingSoonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SelectableText(
      'We are launching soon, join the waitlist to get notified',
      textAlign: TextAlign.center,
      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 36.sp),
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 300.h,
                  child: Image.asset(
                    'assets/images/png/Ellipse 78.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 22.h, left: 41),
                  child: Image.asset(
                    'assets/images/png/Mind-Spa-Logo-Green.png',
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover,
                    height: 172.h,
                    width: 196.67.h,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 22.h, right: 74.46.w),
              child: Image.asset(
                'assets/images/png/Frame 665.png',
                fit: BoxFit.contain,
                width: 201.3.w,
                height: 223.41.h,
              ),
            ),
          ],
        ),
        Positioned(
          top: 161.h,
          left: 311.w,
          right: 311.w,
          child: SelectableText(
            'Mind-Spa is a platform for the rejuvenation of the mind',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36.sp),
          ),
        ),
      ],
    );
  }
}

class TextFieldAndSubmitButton extends StatefulWidget {
  const TextFieldAndSubmitButton({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final ComingSoonViewModel viewModel;

  @override
  State<TextFieldAndSubmitButton> createState() =>
      _TextFieldAndSubmitButtonState();
}

class _TextFieldAndSubmitButtonState extends State<TextFieldAndSubmitButton> {
  final _formKey = GlobalKey<FormState>();
  final emailAddressController = TextEditingController();
  final OutlineInputBorder textFieldStyling = OutlineInputBorder(
    borderRadius: BorderRadius.circular(15.r),
    borderSide: BorderSide(
      color: const Color(0XFF516D61),
      width: 2.0.w,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 339.w,
      right: 339.w,
      top: 56.97.h,
      child: Form(
        key: _formKey,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.60,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.blueGrey.shade100,
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 10,
                child: TextFormField(
                  showCursor: true,
                  validator: context.validateEmailAddress,
                  controller: emailAddressController,
                  cursorColor: const Color(0XFF516D61),
                  cursorRadius: const Radius.circular(10),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    border: textFieldStyling,
                    enabledBorder: textFieldStyling.copyWith(
                        borderSide: BorderSide(width: 1.w)),
                    focusedBorder: textFieldStyling,
                    errorBorder: textFieldStyling.copyWith(
                        borderSide: const BorderSide(
                      color: Colors.red,
                    )),
                    filled: true,
                    hintText: ' johndoe@gmail.com',
                    hintStyle: const TextStyle(
                        fontSize: 18,
                        decorationStyle: TextDecorationStyle.wavy),
                    alignLabelWithHint: true,
                    contentPadding: EdgeInsets.only(left: 33.w),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () => widget.viewModel.subscribeUserToMailingList(
                    email: emailAddressController.text,
                  ),
                  child: AnimatedContainer(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    duration: const Duration(seconds: 10),
                    decoration: BoxDecoration(
                      color: const Color(0XFF516D61),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    constraints: BoxConstraints.tightFor(
                      height: 50,
                      width: MediaQuery.of(context)
                          .size
                          .width
                          .clamp(240.0.w, 560.0.w),
                    ),
                    child: FittedBox(
                      child: widget.viewModel.isBusy
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            )
                          : widget.viewModel.subscriptionSuccessful
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                )
                              : const Text(
                                  'Join Waitlist',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CountDownTimer extends ViewModelWidget<ComingSoonViewModel> {
  const CountDownTimer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ComingSoonViewModel viewModel) {
    final countDownText = [
      viewModel.days,
      viewModel.hours,
      viewModel.minutes,
      viewModel.seconds,
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i <= 3; i++)
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 50.w),
                margin: EdgeInsets.symmetric(horizontal: 35.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0XFF516D61),
                  ),
                ),
                child: SelectableText(
                  countDownText[i] ?? '',
                  style: TextStyle(
                    fontSize: 28.22.sp,
                    fontWeight: FontWeight.w900,
                    color: const Color(0XFF516D61),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              SelectableText(
                countDownDays[i],
                style: TextStyle(
                  fontSize: 18.62.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0XFF516D61),
                ),
              ),
            ],
          ),
      ],
    );
  }
}

class SubLongText extends StatelessWidget {
  const SubLongText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 257.w,
      ),
      child: SelectableText(
        'We are creating an avenue to provide access to holistic health and promote mental wellbeing towards the eradication of mental health problems in Africa by connecting users to the most relevant resources tailored to their mental health needs.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24.sp,
          height: 2,
          color: const Color(0XFF516D61),
        ),
      ),
    );
  }
}

class BottomBar extends ViewModelWidget<ComingSoonViewModel> {
  const BottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ComingSoonViewModel viewModel) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 50.w),
          child: Image.asset(
            'assets/images/png/Frame 662.png',
            fit: BoxFit.cover,
          ),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/images/png/Ellipse 77.png',
              fit: BoxFit.cover,
            ),
            Positioned.fill(
              child: Align(
                alignment: const Alignment(0, 0.30),
                child: SizedBox(
                  height: 37.97.h,
                  width: 122.w,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () => viewModel.openWebUrlLink(
                            'https://instagram.com/mindspa_ng?igshid=YmMyMTA2M2Y='),
                        child: Image.asset(
                          'assets/images/png/instagram 2.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => viewModel.openWebUrlLink(
                            'https://www.facebook.com/MindSpaNG'),
                        child: Image.asset(
                          'assets/images/png/facebook_logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}

List countDownDays = ['Days', 'Hours', 'Minutes', 'Seconds'];
