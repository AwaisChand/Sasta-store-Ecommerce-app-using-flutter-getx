import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sasta_store/Controllers/ChatController/chat_controller.dart';
import 'package:sasta_store/Controllers/ProfileController/profile_controller.dart';
import 'package:sasta_store/Utils/text_style.dart';
import 'package:sasta_store/Widget/custom_loader.dart';
import 'package:sasta_store/Widget/custom_text_field.dart';
import 'package:sasta_store/menu/custom_bottom_navigation.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatController chatController = Get.put(ChatController());
  final ProfileController profileController = Get.put(ProfileController());
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    profileController.getProfileApi();
  }

  void _sendMessage() {
    if (messageController.text.isNotEmpty) {
      chatController.sendMessageApi(messageController.text);
      messageController.clear();
    }
  }

  void launchWhatsApp({required String phone, required String message}) async {
    final whatsappUrl = 'https://wa.me/$phone?text=${Uri.encodeComponent(message)}';
    print("Trying to launch: $whatsappUrl");
    try {
      final canLaunchResult = await canLaunch(whatsappUrl);
      print("Can launch: $canLaunchResult");
      if (canLaunchResult) {
        await launch(whatsappUrl);
      } else {
        print('Could not launch $whatsappUrl');
        // Optionally show a dialog or toast here
      }
    } catch (e) {
      print('Error launching WhatsApp: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(currentIndex: 3),
      resizeToAvoidBottomInset: false,
      body: Obx(() {
        if (chatController.isLoading.value ||
            profileController.isLoading.value) {
          return CustomLoader();
        } else {
          return Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, top: 50),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "${profileController.profileModel.value.data?.name}",
                      style: CustomTextStyles.l16_SemiBold_PrimaryColor
                          .copyWith(fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        launchWhatsApp(
                            phone: "+923016986399",
                            message: "Salam"
                        );
                      },
                      icon: const FaIcon(FontAwesomeIcons.whatsapp), // WhatsApp icon
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                if (chatController.isListNull.value)
                  const Center(child: Text('Start Messaging')),
                CustomTextField(
                  controller: messageController,
                  validation: (val) {
                    return;
                  },
                  isPass: false,
                  passwordvisibility: false,
                  maxLines: 1,
                  hint: "Enter message here...",
                  suffixIcon: GestureDetector(
                    onTap: _sendMessage,
                    child: const Icon(
                      Icons.send_rounded,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Flexible(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ListView.builder(
                      controller: scrollController,
                      reverse: true,
                      itemCount:
                      chatController.getAllMessageModel.value.data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        final reverseIndex = chatController
                            .getAllMessageModel.value.data!.length -
                            index -
                            1;
                        final message = chatController
                            .getAllMessageModel.value.data![reverseIndex];
                        final isUserMessage = message.msgType == 'user';
                        return Align(
                          alignment: isUserMessage
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color:
                              isUserMessage ? Colors.blue : Colors.yellow,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              message.message ?? '',
                              style: TextStyle(
                                color:
                                isUserMessage ? Colors.white : Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
