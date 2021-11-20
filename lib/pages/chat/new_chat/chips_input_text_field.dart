import 'package:microsoft_teams_clone/config/constants.dart';
import 'package:microsoft_teams_clone/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:smile_engage/routes/ui_routes.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../chats/group_chat/channel_page.dart';

class UserMentionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = StreamChat.of(context).user!;
    return MessageSearchBloc(
      child: MessageSearchListView(
        filters: Filter.in_('members', [user.id]),
        messageFilters: Filter.custom(
          operator: r'$contains',
          key: 'mentioned_users.id',
          value: user.id,
        ),
        sortOptions: [
          SortOption(
            'created_at',
            direction: SortOption.ASC,
          ),
        ],
        paginationParams: PaginationParams(limit: 20),
        showResultCount: false,
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
                          child: StreamSvgIcon.mentions(
                            size: 96,
                            color: StreamChatTheme.of(context)
                                .colorTheme
                                .greyGainsboro,
                          ),
                        ),
                        Text(
                          'No mentions exist yet...',
                          style: StreamChatTheme.of(context)
                              .textTheme
                              .body
                              .copyWith(
                            color: appLightColor,
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
        onItemTap: (messageResponse) async {
          final client = StreamChat.of(context).client;
          final message = messageResponse.message;
          final channel = client.channel(
            messageResponse.channel!.type,
            id: messageResponse.channel!.id,
          );
          if (channel.state == null) {
            await channel.watch();
          }
          Navigator.pushNamed(
            context,
            Routes.CHANNEL_PAGE,
            arguments: ChannelPageArgs(
              channel: channel,
              initialMessage: message,
            ),
          );
        },
      ),
    );
  }
}