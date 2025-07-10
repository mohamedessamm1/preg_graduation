import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

class GeminiChatScreen extends StatefulWidget {
  const GeminiChatScreen({super.key});

  @override
  State<GeminiChatScreen> createState() => _GeminiChatScreenState();
}

class _GeminiChatScreenState extends State<GeminiChatScreen>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {

  // Controllers and state variables
  late final TextEditingController _controller;
  late final ScrollController _scrollController;
  late final FocusNode _focusNode;
  late final AnimationController _sendButtonController;
  late final Animation<double> _sendButtonAnimation;

  final List<ChatMessage> _messages = [];
  bool _isLoading = false;
  bool _isTyping = false;

  // Color scheme
  static const Color primaryColor = Color(0xFFBC9F8B);
  static const Color primaryLight = Color(0xFFD4C4B0);
  static const Color primaryDark = Color(0xFF8B7355);
  static const Color backgroundColor = Color(0xFFF8F6F4);
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color textColor = Color(0xFF2D2D2D);
  static const Color hintColor = Color(0xFF9E9E9E);

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _controller = TextEditingController();
    _scrollController = ScrollController();
    _focusNode = FocusNode();

    _sendButtonController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _sendButtonAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _sendButtonController,
      curve: Curves.easeInOut,
    ));

    // Listen to text changes for send button animation
    _controller.addListener(() {
      setState(() {
        _isTyping = _controller.text.trim().isNotEmpty;
      });
    });
  }

  Future<String> generateContent(String userInput) async {
    const apiKey = 'AIzaSyAVw02CtdOJtGL3_ydsANvD-V3NihyUUu4';
    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$apiKey',
    );

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {"text": userInput}
              ]
            }
          ],
          "generationConfig": {
            "temperature": 0.7,
            "maxOutputTokens": 1000,
          }
        }),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['candidates'][0]['content']['parts'][0]['text'];
      } else {
        return "Sorry, there was an error connecting. Please try again.";
      }
    } catch (e) {
      return "Sorry, unable to connect to the service. Check your internet connection.";
    }
  }

  void _sendMessage() async {
    final input = _controller.text.trim();
    if (input.isEmpty || _isLoading) return;

    // Haptic feedback
    HapticFeedback.lightImpact();

    // Animate send button
    _sendButtonController.forward().then((_) {
      _sendButtonController.reverse();
    });

    final userMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: input,
      isUser: true,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.add(userMessage);
      _isLoading = true;
      _controller.clear();
    });

    await _scrollToBottom();

    try {
      final reply = await generateContent(input);

      final aiMessage = ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: reply,
        isUser: false,
        timestamp: DateTime.now(),
      );

      if (mounted) {
        setState(() {
          _messages.add(aiMessage);
          _isLoading = false;
        });
        await _scrollToBottom();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showDeleteChatDialog() {
    HapticFeedback.mediumImpact();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 60.w,
                  height: 60.w,
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.delete_outline_rounded,
                    size: 30.sp,
                    color: Colors.red.shade400,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  "Delete Chat",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  "Are you sure you want to delete all messages?\nThis action cannot be undone.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: hintColor,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            side: BorderSide(color: hintColor.withOpacity(0.3)),
                          ),
                        ),
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: hintColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _deleteChat();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade400,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          "Delete",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _deleteChat() {
    HapticFeedback.heavyImpact();

    setState(() {
      _messages.clear();
      _isLoading = false;
    });

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.check_circle_rounded,
              color: Colors.white,
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              "Chat deleted successfully",
              style: TextStyle(fontSize: 14.sp),
            ),
          ],
        ),
        backgroundColor: Colors.green.shade400,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        margin: EdgeInsets.all(16.w),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _scrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (_scrollController.hasClients) {
      await _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
      );
    }
  }

  Widget _buildMessage(ChatMessage message, int index) {
    // Only animate recent messages for better performance
    final shouldAnimate = index >= _messages.length - 5;

    if (!shouldAnimate) {
      return _MessageBubble(message: message);
    }

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        // Clamp the value to ensure it's within valid range
        final clampedValue = value.clamp(0.0, 1.0);

        return Transform.scale(
          scale: 0.8 + (clampedValue * 0.2), // Scale from 0.8 to 1.0
          child: Transform.translate(
            offset: Offset(
                message.isUser ? 30 * (1 - clampedValue) : -30 * (1 - clampedValue),
                10 * (1 - clampedValue)
            ),
            child: Opacity(
              opacity: clampedValue,
              child: _MessageBubble(message: message),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120.w,
            height: 120.w,
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.chat_bubble_outline_rounded,
              size: 60.sp,
              color: primaryColor,
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            "Welcome to MoM Chat Bot",
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "Start a conversation and enjoy smart chatting",
            style: TextStyle(
              fontSize: 16.sp,
              color: hintColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Container(
      margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 12.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 16.w,
                  height: 16.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                ),
                SizedBox(width: 12.w),
                Text(
                  "Typing...",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: hintColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: surfaceColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(25.r),
                border: Border.all(
                  color: _focusNode.hasFocus ? primaryColor : Colors.transparent,
                  width: 2,
                ),
              ),
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                onSubmitted: (_) => _sendMessage(),
                maxLines: null,
                textInputAction: TextInputAction.send,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: textColor,
                ),
                decoration: InputDecoration(
                  hintText: "Type your message here...",
                  hintStyle: TextStyle(
                    color: hintColor,
                    fontSize: 16.sp,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 12.h,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          AnimatedBuilder(
            animation: _sendButtonAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _sendButtonAnimation.value,
                child: Container(
                  width: 50.w,
                  height: 50.w,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: _isTyping
                          ? [primaryColor, primaryDark]
                          : [hintColor.withOpacity(0.3), hintColor.withOpacity(0.2)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: _isTyping ? [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ] : [],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(25.r),
                      onTap: _isTyping ? _sendMessage : null,
                      child: Icon(
                        Icons.send_rounded,
                        color: _isTyping ? Colors.white : hintColor,
                        size: 24.sp,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (_, __) => Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, primaryDark],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.smart_toy_rounded,
                  color: Colors.white,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "MoM Chat Bot",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Your Smart Assistant",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: hintColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            if (_messages.isNotEmpty)
              IconButton(
                onPressed: _showDeleteChatDialog,
                icon: Icon(
                  Icons.delete_outline_rounded,
                  color: Colors.red.shade400,
                ),
                tooltip: "Delete Chat",
              ),
            IconButton(
              onPressed: () {
                // Add settings or menu functionality
              },
              icon: Icon(
                Icons.more_vert_rounded,
                color: primaryColor,
              ),
              tooltip: "More",
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: _messages.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                controller: _scrollController,
                itemCount: _messages.length,
                padding: EdgeInsets.symmetric(vertical: 8.h),
                itemBuilder: (context, index) {
                  return _buildMessage(_messages[index], index);
                },
              ),
            ),
            if (_isLoading) _buildLoadingIndicator(),
            _buildInputArea(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    _sendButtonController.dispose();
    super.dispose();
  }
}

class ChatMessage {
  final String id;
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

class _MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      child: Row(
        mainAxisAlignment: message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!message.isUser) ...[
            Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFBC9F8B), Color(0xFF8B7355)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.smart_toy_rounded,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
            SizedBox(width: 8.w),
          ],
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
              decoration: BoxDecoration(
                gradient: message.isUser
                  ? const LinearGradient(
                      colors: [Color(0xFFBC9F8B), Color(0xFF8B7355)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
                color: message.isUser ? null : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                  bottomLeft: Radius.circular(message.isUser ? 20.r : 4.r),
                  bottomRight: Radius.circular(message.isUser ? 4.r : 20.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: message.isUser ? Colors.white : const Color(0xFF2D2D2D),
                  height: 1.4,
                ),
              ),
            ),
          ),
          if (message.isUser) ...[
            SizedBox(width: 8.w),
            Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: const Color(0xFFBC9F8B).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person_rounded,
                color: const Color(0xFFBC9F8B),
                size: 18.sp,
              ),
            ),
          ],
        ],
      ),
    );
  }
}