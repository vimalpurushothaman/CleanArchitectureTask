import 'Allimports.dart';

class AppAlertController {
  var _isLoaderShowing = false;
  static final AppAlertController _inst = AppAlertController._internal();

  AppAlertController._internal();

  factory AppAlertController() => _inst;
  BuildContext? _indicatorContext = AppDataHelper.rootContext;

  void showAlert(
      {String title = 'UDS ',
      required String message,
      String? cancelTitle,
      String? otherTitle,
      VoidCallback? otherAction,
      required BuildContext inContext}) async {
    this.hideProgressIndicator(inContext);

    var alertTitle = Center(
      child: Text(
        title,
      ),
    );

    var alertContent = SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          Center(
            child: Text(
              message.startsWith('Exception:')
                  ? message.toString().split('Exception:')[1]
                  : message,
            ),
          ),
        ],
      ),
    );

    List<Widget> _alertButtons = [];
    var cancelButton = TextButton(
      child: Text(
        cancelTitle ?? 'OK',
      ),
      onPressed: () {
        Navigator.of(inContext, rootNavigator: true).pop('dialog');
      },
    );

    _alertButtons.add(cancelButton);

    if (otherTitle != null) {
      var otherButton = TextButton(
        child: Text(
          otherTitle,
        ),
        onPressed: () {
          if (otherAction != null) {
            otherAction();
          }
        },
      );

      _alertButtons.add(otherButton);
    }

    var _alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      title: alertTitle,
      content: alertContent,
      actions: _alertButtons,
    );

    return showGeneralDialog<void>(
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 300),
      context: inContext,
      pageBuilder: (context, animation, secondaryAnimation) => _alert,
    );
  }

  void hideProgressIndicator(BuildContext context) {
    if (!_isLoaderShowing) return;
    Navigator.pop(context);
    _isLoaderShowing = false;
  }

  Future<void> showProgressIndicator({BuildContext? inContext}) async {
    if (_isLoaderShowing) return;
    _isLoaderShowing = true;

    _indicatorContext = inContext ?? AppDataHelper.rootContext;
    return showGeneralDialog<void>(
        barrierDismissible: false,
        transitionDuration: Duration(milliseconds: 300),
        barrierColor: AppTheme.LightGrey.withAlpha(100),
        context: inContext ?? AppDataHelper.rootContext!,
        pageBuilder: (context, animation, secondaryAnimation) {
          return WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: loaderWidget(inContext: _indicatorContext!));
        },
        transitionBuilder: _transitionBuilder);
  }

  Widget _transitionBuilder(context, animation, secondaryAnimation, child) =>
      Transform.scale(
        scale: animation.value,
        child: Opacity(
          opacity: animation.value,
          child: child,
        ),
      );

  Widget loaderWidget({BuildContext? inContext}) {
    double loaderSize =
        MediaQuery.of(inContext ?? AppDataHelper.rootContext!).size.width * 0.1;

    var loader = Container(
      width: loaderSize,
      height: loaderSize,
      child: const CircularProgressIndicator(
        backgroundColor: AppTheme.primaryColor1,
        color: Colors.grey,
      ),
    );

    var loaderWithBG = Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      width: loaderSize * 2,
      height: loaderSize * 2,
      child: Center(child: loader),
    );

    return Container(
      child: Center(
        child: loaderWithBG,
      ),
    );
  }
}
