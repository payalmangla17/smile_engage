import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:smile_engage/config/constants.dart';
import 'package:smile_engage/pages/ui/search_text_field.dart';
import 'package:smile_engage/routes/ui_routes.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import '../../models/globals.dart' as globals;

class AddChannelMembersPage extends StatefulWidget {
  @override
  _AddChannelMembersPageState createState() => _AddChannelMembersPageState();
}

class _AddChannelMembersPageState extends State<AddChannelMembersPage> {
  TextEditingController? _controller;

  String _userNameQuery = '';

  final _selectedUsers = <User>{};

  bool _isSearchActive = false;

  Timer? _debounce;

  void _userNameListener() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () {
      if (mounted) {
        setState(() {
          _userNameQuery = _controller!.text;
          _isSearchActive = _userNameQuery.isNotEmpty;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController()..addListener(_userNameListener);
  }

  @override
  void dispose() {
    _controller?.clear();
    _controller?.removeListener(_userNameListener);
    _controller?.dispose();
    super.dispose();
  }
  int getCount(){
    Map? data;
    FirebaseDatabase.instance.reference().child('users').once().then((onValue) {
       data = onValue.value;

    });
    int cnt = data!.length;
    return cnt<25?cnt:25;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StreamChatTheme.of(context).colorTheme.appBg,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: appBlueColor,
        leading: const StreamBackButton(),
        title: Text(
          'Add Group Members',
          style: TextStyle(
            color: StreamChatTheme.of(context).colorTheme.textHighEmphasis,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        actions: [
          // if (_selectedUsers.isNotEmpty)
          IconButton(
            icon: StreamSvgIcon.arrowRight(
              color: StreamChatTheme.of(context).colorTheme.textHighEmphasis,
            ),
            onPressed: () async {
              final updatedList = await Navigator.pushNamed(
                context,
                Routes.new_channel_details,
                arguments: _selectedUsers.toList(growable: false),
              );
              if (updatedList != null) {
                setState(() {
                  _selectedUsers
                    ..clear()
                    ..addAll(updatedList as Iterable<User>);
                });
              }
            },
          )
        ],
      ),
      body: ConnectionStatusBuilder(
        /*
          Sets the Connection Status on the basis of the state of the server
          * */
        statusBuilder: (context, status) {
          String statusString = '';
          bool showStatus = true;

          switch (status) {
            case ConnectionStatus.connected:
              statusString = 'Connected';
              showStatus = false;
              break;
            case ConnectionStatus.connecting:
              statusString = 'Reconnecting...';
              break;
            case ConnectionStatus.disconnected:
              statusString = 'Disconnected';
              break;
          }
          return InfoTile(
            showMessage: showStatus,
            tileAnchor: Alignment.topCenter,
            childAnchor: Alignment.topCenter,
            message: statusString,
            child: NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverToBoxAdapter(
                    child: SearchTextField(
                      controller: _controller,
                    ),
                  ),
                  if (_selectedUsers.isNotEmpty)
                    SliverToBoxAdapter(
                      child: Container(
                        height: 104,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: _selectedUsers.length,
                          padding: const EdgeInsets.all(8),
                          separatorBuilder: (_, __) => SizedBox(width: 16),
                          itemBuilder: (_, index) {
                            final user = _selectedUsers.elementAt(index);
                            return Column(
                              children: [
                                Stack(
                                  children: [
                                    UserAvatar(
                                      onlineIndicatorAlignment:
                                      Alignment(0.9, 0.9),
                                      user: user,
                                      showOnlineStatus: true,
                                      borderRadius: BorderRadius.circular(32),
                                      constraints: BoxConstraints.tightFor(
                                        height: 64,
                                        width: 64,
                                      ),
                                    ),
                                    Positioned(
                                      top: -4,
                                      right: -4,
                                      child: GestureDetector(
                                        onTap: () {
                                          if (_selectedUsers.contains(user)) {
                                            setState(() =>
                                                _selectedUsers.remove(user));
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: StreamChatTheme.of(context)
                                                .colorTheme
                                                .barsBg,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: StreamChatTheme.of(context)
                                                  .colorTheme
                                                  .appBg,
                                            ),
                                          ),
                                          child: StreamSvgIcon.close(
                                            color: StreamChatTheme.of(context)
                                                .colorTheme
                                                .textHighEmphasis,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 4),
                                Text(
                                  user.name.split(' ')[0],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _HeaderDelegate(
                      height: 30,
                      child: Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          gradient:
                          StreamChatTheme.of(context).colorTheme.bgGradient,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 8,
                          ),
                          child: Text(
                            _isSearchActive
                                ? 'Matches for \"$_userNameQuery\"'
                                : 'On the platform',
                            style: TextStyle(
                              color: appLightColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onPanDown: (_) => FocusScope.of(context).unfocus(),
                child: UsersBloc(
                  child: UserListView(
                    selectedUsers: _selectedUsers,
                    pullToRefresh: false,
                    groupAlphabetically: _isSearchActive ? false : true,
                    onUserTap: (user, _) {
                      if (!_selectedUsers.contains(user)) {
                        setState(() {
                          _selectedUsers.add(user);
                        });
                      } else {
                        setState(() {
                          _selectedUsers.remove(user);
                        });
                      }
                    },
                    limit: 20,
                    filter: Filter.and([
                      if (_userNameQuery.isNotEmpty)
                        Filter.autoComplete('name', _userNameQuery),
                      Filter.equal('orgCode', globals.organisationCode),
                      Filter.notEqual('id', StreamChat.of(context).currentUser!.id),
                    ]),
                    sort: [
                      SortOption(
                        'name',
                        direction: 1,
                      ),
                    ],
                    emptyBuilder: (_) {
                      return LayoutBuilder(
                        builder: (context, viewportConstraints) {
                          return SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: viewportConstraints.maxHeight,
                              ),
                              child: Center(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(24),
                                      child: StreamSvgIcon.search(
                                        size: 96,
                                        color: StreamChatTheme.of(context)
                                            .colorTheme
                                            .textLowEmphasis,
                                      ),
                                    ),
                                    Text(
                                      'No user matches these keywords...',
                                      style: StreamChatTheme.of(context)
                                          .textTheme
                                          .footnote
                                          .copyWith(
                                        color: StreamChatTheme.of(context)
                                            .colorTheme
                                            .textLowEmphasis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  
}

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  const _HeaderDelegate({
    required this.child,
    required this.height,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: StreamChatTheme.of(context).colorTheme.barsBg,
      child: child,
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(_HeaderDelegate oldDelegate) => true;
}