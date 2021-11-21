import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:smile_engage/config/constants.dart';
import 'package:smile_engage/pages/chat/group_chat/channel_info_page.dart';
import 'package:smile_engage/pages/chat/group_chat/channel_page.dart';
import 'package:smile_engage/routes/ui_routes.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../chat_info_page.dart';
import '../pinned_message_page.dart';

/*
Option Tile Widgets for info screen of channels and private chats.
Generalised and Modular Tiles implemented
*/

class PinOptionTile extends StatelessWidget {
  const PinOptionTile({
    Key? key,
    required this.context,
    this.channelWidget,
    this.chatWidget,
  }) : super(key: key);

  final BuildContext context;
  final ChannelInfoPage? channelWidget;
  final ChatInfoPage? chatWidget;

  @override
  Widget build(BuildContext context) {
    return OptionListTile(
      title: 'Pinned Messages',
      tileColor: StreamChatTheme.of(context).colorTheme.appBg,
      titleTextStyle: StreamChatTheme.of(context).textTheme.body,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0),
        child: StreamSvgIcon.pin(
          size: 24.0,
          color: appAccentIconColor,
        ),
      ),
      trailing: StreamSvgIcon.right(
          color: StreamChatTheme.of(context).colorTheme.textHighEmphasis.withOpacity(0.5)),
      onTap: () {
        final channel = StreamChannel.of(context).channel;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StreamChannel(
              channel: channel,
              child: MessageSearchBloc(
                child: PinnedMessagesPage(
                  messageTheme: chatWidget == null
                      ? channelWidget!.messageTheme
                      : chatWidget!.messageTheme,
                  sortOptions: [
                    SortOption(
                      'created_at',
                      direction: SortOption.ASC,
                    ),
                  ],
                  paginationParams: PaginationParams(limit: 20),
                  onShowMessage: (m, c) async {
                    final client = StreamChat.of(context).client;
                    final message = m;
                    final channel = client.channel(
                      c.type,
                      id: c.id,
                    );
                    if (channel.state == null) {
                      await channel.watch();
                    }
                    Navigator.pushNamed(
                      context,
                      Routes.channel_page,
                      arguments: ChannelPageArgs(
                        channel: channel,
                        initialMessage: message,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}