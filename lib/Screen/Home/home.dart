import '../../Utils/Allimports.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final ScrollController _scrollController = ScrollController();
  List<User> list = [];
  int pagenumber = 1;
  BuildContext? Bcontext;
  homeBloc? _bloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (pagenumber < 3) {
        pagenumber++;
        setState(() {});
        Future.delayed(Durations.extralong4, () {
          // BlocProvider.of<homeBloc>(Bcontext!)
          //     .add(homeInitailEvent(pagenumber.toString(), Bcontext!));
          // BlocProvider.of<GetPharmacyProductListBloc>(
          //     blocContext)

          Bcontext?.read<homeBloc>()
              .add(homeloadmoreEvent(pagenumber.toString(), context!));
          // _bloc?.add(homeloadmoreEvent(pagenumber.toString(), Bcontext!));
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<homeBloc>(
      create: (bcontext) {
        var bloc = homeBloc();

        Future.delayed(const Duration(seconds: 2), () {
          _bloc = bloc;
          bloc.add(homeInitailEvent(pagenumber.toString(), context));
        });
        return bloc;
      },
      child: BlocListener<homeBloc, homeState>(
        listener: (context, state) {
          Bcontext = context;
          if (state is homeStateLoadedState) {
            for (var data in state.data['data']) {
              list.add(User.fromJson(data));
            }

            setState(() {});
          }
          if (state is homeStatemoreLoadedState) {
            for (var data in state.data['data']) {
              list.add(User.fromJson(data));
            }
          }
        },
        child: BlocBuilder<homeBloc, homeState>(
          builder: (bloccontext, state) {
            _bloc = BlocProvider.of<homeBloc>(bloccontext);
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: CommonUI().text(
                    text: "Home Screen",
                    fontSize: 22,
                    fontWeight: FontWeight.w700),
              ),
              body: state is homeStateInitialState
                  ? CommonUI().buildShimmerEffect()
                  : state is homeStateLoadedState ||
                          state is homeStatemoreLoadedState
                      ? SizedBox(
                          height: list.length > 10 ? 100.h : 50.h,
                          child: Center(
                              child: ListView.builder(
                            controller: _scrollController,
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              final user = list.elementAt(index);
                              return Card(
                                margin: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              userScreen(id: user.id)),
                                    );
                                  },
                                  leading: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(user.avatar),
                                  ),
                                  title: CommonUI().text(
                                      text:
                                          '${user.firstName} ${user.lastName}',
                                      fontSize: 18),
                                  subtitle: CommonUI().text(
                                      text: user.email,
                                      fontSize: 15,
                                      lineHeight: 2),
                                ),
                              );
                            },
                          )),
                        )
                      : CommonUI().buildShimmerEffect(),
            );
          },
        ),
      ),
    );
  }
}
