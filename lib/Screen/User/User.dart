import '../../Utils/Allimports.dart';

class userScreen extends StatefulWidget {
  final id;
  const userScreen({super.key, required this.id});

  @override
  State<userScreen> createState() => _userScreenState();
}

class _userScreenState extends State<userScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  User? userData;
  BuildContext? Bcontext;
  userBloc? _bloc;
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    _fadeInAnimation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _controller, curve: Curves.bounceOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 5), end: const Offset(0, 0))
            .animate(
      CurvedAnimation(parent: _controller, curve: Curves.decelerate),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<userBloc>(
      create: (bcontext) {
        var bloc = userBloc();

        Future.delayed(const Duration(seconds: 2), () {
          Bcontext = context;
          _bloc = bloc;
          bloc.add(userInitailEvent(widget.id.toString(), context));
        });
        return bloc;
      },
      child: BlocListener<userBloc, userState>(
        listener: (context, state) {
          if (state is userStateLoadedState) {
            state.data;
            userData = User.fromJson(state.data['data']);
          }
        },
        child: BlocBuilder<userBloc, userState>(
          builder: (bloccontext, state) {
            _bloc = BlocProvider.of<userBloc>(bloccontext);
            return Scaffold(
              appBar: AppBar(
                elevation: 2,
                centerTitle: true,
                title: CommonUI().text(
                    text: "User Screen",
                    fontSize: 22,
                    fontWeight: FontWeight.w700),
              ),
              body: state is userStateInitialState
                  ? CommonUI().buildShimmerEffect()
                  : state is userStateLoadedState
                      ? Container(
                          width: 100.w,
                          margin: const EdgeInsets.fromLTRB(8, 8, 8, 20),
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: (Colors.grey[200])!, spreadRadius: 3)
                              ],
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(height: 3.h),
                              FadeTransition(
                                opacity: _fadeInAnimation,
                                child: CircleAvatar(
                                  radius: 12.h,
                                  backgroundImage:
                                      NetworkImage(userData!.avatar),
                                ),
                              ),
                              SizedBox(height: 3.h),
                              const Divider(
                                thickness: 2,
                                color: Colors.black12,
                              ),
                              Row(
                                children: [
                                  SizedBox(width: 3.w),
                                  SlideTransition(
                                    position: _slideAnimation,
                                    child: SizedBox(
                                      width: 25.w,
                                      child: CommonUI().text(
                                        text: 'Name :',
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SlideTransition(
                                    position: _slideAnimation,
                                    child: CommonUI().text(
                                      text:
                                          "${userData!.firstName} ${userData!.lastName}",
                                      fontSize: 21,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 3.h),
                              const Divider(
                                thickness: 2,
                                color: Colors.black12,
                              ),
                              Row(
                                children: [
                                  SizedBox(width: 3.w),
                                  SlideTransition(
                                    position: _slideAnimation,
                                    child: SizedBox(
                                      width: 25.w,
                                      child: CommonUI().text(
                                        text: 'E-mail :',
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SlideTransition(
                                    position: _slideAnimation,
                                    child: SizedBox(
                                      width: 60.w,
                                      child: CommonUI().text(
                                        text: userData!.email,
                                        fontSize: 21,
                                        fontWeight: FontWeight.normal,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 3.h),
                              const Divider(
                                thickness: 2,
                                color: Colors.black12,
                              ),
                            ],
                          ),
                        )
                      : CommonUI().buildShimmerEffect(),
            );
          },
        ),
      ),
    );
  }
}
