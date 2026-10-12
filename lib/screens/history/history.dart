import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:vascular_blood/exports/modules.dart';
import 'package:vascular_blood/global/globalwidgets/dialog/logout.dart';
import 'package:vascular_blood/global/globalwidgets/snackbars.dart/warning.dart';
import 'package:vascular_blood/screens/history/filter.dart';
import 'package:vascular_blood/screens/history/internet_manage.dart';
import 'package:vascular_blood/screens/history/nohistory.dart';
import 'package:vascular_blood/screens/history/patient.dart';
import 'package:vascular_blood/services/exceptions_massage.dart';
import 'package:vascular_blood/services/model/history_model.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

// For managing page in controller and url
int nPage = 1;

class _HistoryPageState extends State<HistoryPage>
    with SingleTickerProviderStateMixin {
  // For float action button Icon animation
  late AnimationController _controller;

  // For save different field like all , parameter , diameter
  int selectedIndex = 1;

  final int all = 1;
  final int parameter = 2;
  final int diameter = 3;

  // IF internet is connect it should be false else it should become true
  bool isNotConnect = false;

  final PagingController<int, VeinModel> pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    //First of all check user internet
    checknet();
    pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });
  }

  @override
  void dispose() {
    pagingController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    double verticalPadding = screenSize.height * 0.02;
    double horizontalPadding = screenSize.width * 0.05;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              width: screenSize.width,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Stack(children: [
                Image.asset(
                  'assets/images/pattern.jpg',
                  fit: BoxFit.cover,
                  width: screenSize.width,
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: verticalPadding,
                          horizontal: horizontalPadding),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.offNamed(Routes.menu);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(60),
                                      color: Colors.white24),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "Activity History",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(color: Colors.white),
                              ),
                              SizedBox(width:35),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.all(2),
                            child: Text(
                              "Quick Access Menu",
                              style: TextStyle(
                                  color: Colors.white54, fontSize: 16),
                            ),
                          ),
                          SizedBox(height: screenSize.height * 0.009),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildMenuButton("Log out", Icons.logout, () {
                                LogOutDialog().showLogoutDialog();
                              }),
                              const SizedBox(width: 20),
                              _buildMenuButton("Home", Icons.home, () {
                                Get.offNamed(Routes.menu);
                              }),
                              const SizedBox(width: 20),
                              _buildMenuButton("Refresh", Icons.history, () {
                                pagingController.refresh();
                              }),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Container(
                        width: screenSize.width,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Flexible(
                                child: Filter(
                                  selectedIndex: selectedIndex,
                                  title: Text(
                                    "All",
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: selectedIndex == all
                                            ? FontWeight.w600
                                            : FontWeight.w500),
                                  ),
                                  index: all,
                                  onPressed: () {
                                    _onFilterChanged(all);
                                  },
                                ),
                              ),
                              Flexible(
                                child: Filter(
                                  selectedIndex: selectedIndex,
                                  title: Text(
                                    "Diameter",
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: selectedIndex == diameter
                                            ? FontWeight.w600
                                            : FontWeight.w500),
                                  ),
                                  index: diameter,
                                  onPressed: () {
                                    _onFilterChanged(diameter);
                                  },
                                ),
                              ),
                              Flexible(
                                child: Filter(
                                  selectedIndex: selectedIndex,
                                  title: Text(
                                    "Parameter",
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: selectedIndex == parameter
                                            ? FontWeight.w600
                                            : FontWeight.w500),
                                  ),
                                  index: parameter,
                                  onPressed: () {
                                    _onFilterChanged(parameter);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
            ),
            Divider(
              color: Colors.grey.shade200,
              indent: screenSize.width * 0.05,
              endIndent: screenSize.width * 0.05,
            ),
            SizedBox(height: screenSize.height * 0.01),
            Expanded(
              child: Stack(
                children: [
                  isNotConnect
                      ? InternetCheckManage(
                          onTryAgain: () {
                            setState(() {
                              checknet();
                              pagingController.refresh();
                            });
                          },
                        )
                      // InternetManagment(
                      //     onTryAgain: () {
                      //       setState(() {
                      //         checknet();
                      //         //   pagingController.refresh();
                      //       });
                      //     },
                      //     content: 'Please check your internet and try again',
                      //   )
                      : RefreshIndicator(
                          onRefresh: () =>
                              Future.sync(pagingController.refresh),
                          child: PagedListView<int, VeinModel>(
                            pagingController: pagingController,
                            builderDelegate:
                                PagedChildBuilderDelegate<VeinModel>(
                                    animateTransitions: true,
                                    itemBuilder: (context, item, index) {
                                      return Patient(
                                        data: item,
                                      );
                                    },
                                    noItemsFoundIndicatorBuilder: (context) =>
                                        const NoHistoryManage()),
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> checknet() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      setState(() {
        isNotConnect = true;
      });
    } else {
      if (isNotConnect != false) {
        setState(() {
          isNotConnect = false;
        });
      }
    }
  }

  void _onFilterChanged(int index) {
    setState(() {
      selectedIndex = index;
      pagingController.refresh();
      nPage = 1;
    });
  }

  Future<void> fetchPage(int pageKey) async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.none)) {
      const WarningSnackbar(
              title: 'No internet connection',
              content: 'Please check your connection and try again!')
          .show();
      return;
    } else {
      _controller.repeat();

      try {
        String url;
        if (selectedIndex == all) {
          url = 'history/api/all/history/list?page=$nPage';
        } else if (selectedIndex == diameter) {
          url = 'history/api/all/history/list?filter=diameter&page=$nPage';
        } else if (selectedIndex == parameter) {
          url = 'history/api/all/history/list?filter=parameter&page=$nPage';
        } else {
          url = 'history/api/all/history/list?page=$nPage';
        }
        Logger().i("request url is : $url , our page number is $pageKey");
        var response =
            await NetworkService().get(url, type: RequestType.History);
        if (response != null && response.statusCode == 200) {
          var checkEmpty = response.data["results"];
          if (checkEmpty != null && checkEmpty.isNotEmpty) {
            // Continue processing the list if it's not empty
            List<VeinModel> postList = [];
            checkEmpty.forEach((key, value) {
              if (value is List) {
                postList
                    .addAll(value.map((item) => VeinModel.fromJson(item, key)));
              } else if (value is Map) {
                postList.add(
                    VeinModel.fromJson(value as Map<String, dynamic>, key));
              }
            });
            Logger().i("${response.data["next"]}");
            final isLastPage =
                response.data['next'] == null || response.data!["data"] == '';

            if (isLastPage) {
              pagingController.appendLastPage(postList);
            } else {
              final nextPageKey = pageKey + 1;
              nPage = nextPageKey;
              pagingController.appendPage(postList, nextPageKey);
            }
          } else {}
        } else {
          Logger().e("response back null or we have a error");
        }
      } catch (error) {
        pagingController.error = error;
        Logger().e("$error");
      } finally {
        _controller.stop();
      }
    }
  }
}

Widget _buildMenuButton(String title, IconData icon, VoidCallback onPressed) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      width: MediaQuery.of(Get.context!).size.width * 0.235,
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(height: 5),
            Text(title,
                style: const TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
      ),
    ),
  );
}
