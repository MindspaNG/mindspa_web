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
        body: Stack(
          children: [
            const TopBar(),
            Column(
              children: [
                // TopBar

                // Heading Text
                SelectableText(
                  'Mind-Spa is a platform for the rejuvenation of the mind',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 36.sp),
                ),
                SizedBox(
                  height: 58.h,
                ),
                // Sub Text
                const SubLongText(),
                SizedBox(
                  height: 72.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 300.w),
                  child: SelectableText(
                    'We are launching soon, join the waitlist to get notified',
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 36.sp),
                  ),
                ),
                SizedBox(
                  height: 72.h,
                ),
                const CountDownTimer(),

                SizedBox(
                  height: 56.97.h,
                ),
                TextFieldAndSubmitButton(viewModel: viewModel),
                const BottomBar(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TextFieldAndSubmitButton extends StatefulWidget {
  TextFieldAndSubmitButton({
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

  @override
  Widget build(BuildContext context) {
    return Form(
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
              child: AnimatedContainer(
                duration: const Duration(seconds: 10),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: const Color(0XFF516D61),
                    width: 1.5,
                  ),
                ),
                child: TextFormField(
                  validator: context.validateEmailAddress,
                  controller: emailAddressController,
                  cursorHeight: 25,
                  cursorColor: const Color(0XFF516D61),
                  cursorRadius: const Radius.circular(10),
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: ' johndoe@gmail.com',
                    hintStyle: TextStyle(fontSize: 18),
                    alignLabelWithHint: true,
                    contentPadding: EdgeInsets.zero,
                  ),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  duration: const Duration(seconds: 10),
                  decoration: BoxDecoration(
                    color: const Color(0XFF516D61),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  constraints: BoxConstraints.tightFor(
                    height: 50,
                    width:
                        MediaQuery.of(context).size.width.clamp(240.0, 560.0),
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
                margin: const EdgeInsets.symmetric(horizontal: 35),
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
                    fontWeight: FontWeight.normal,
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
        horizontal: MediaQuery.of(context).size.width * 0.15.w,
      ),
      child: SelectableText(
        'We are creating an avenue to provide access to holistic health and promote mental wellbeing towards the eradication of mental health problems in Africa by connecting users to the most relevant resources tailored to their mental health needs.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24.sp,
          height: 2,
          color: Color(0XFF516D61),
        ),
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
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
          SvgPicture.asset(
            'assets/images/svg/Ellipse 77.svg',
            fit: BoxFit.cover,
            height: 100.h,
          )
        ],
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 22.h, left: 41),
            child: Image.asset(
              'assets/images/png/Mind-Spa-Logo-Green.png',
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover,
              height: 172.h,
              width: 172.h,
            ),
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
    );
  }
}

List countDownDays = ['Days', 'Hours', 'Minutes', 'Seconds'];
