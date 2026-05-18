import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pinput/pinput.dart';
import 'package:storex/features/auth/controllers/forgot_pass_controller.dart';
import 'package:storex/widgets/back_button.dart';
import 'package:storex/widgets/primary_button.dart';

class verifyCode extends StatelessWidget{
  const verifyCode({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final media = MediaQuery.of(context);
    final darkMode = theme.brightness == Brightness.dark;
    final String backgroundImage = 'assets/photos/forgot_pass.png';
    final controller = Get.find<ForgotPassController>();
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: theme.textTheme.headlineMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: theme.primaryColor,
      ),
      decoration: BoxDecoration(
        // color: ,
        border: Border.all(color: theme.primaryColor),
        borderRadius: BorderRadius.circular(8),
      ),
    );
    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: theme.primaryColor, width: 2),
      ),
    );
    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: theme.colorScheme.error.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.error),
      ),
    );

  return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: SafeArea(
              child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),

              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: media.size.width * 0.05, vertical: media.size.height * 0.02),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  CustomBackButton(),
                  Center(
                    child: ClipRRect(
                      child: Image.asset(backgroundImage,
                      height:media.size.height * 0.3,
                      fit: BoxFit.contain,),
                      
                    ),
                  ),
                  Text(
                    "Verification Code".tr,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                     SizedBox(height: media.size.height * 0.01),
                        Text(
                          "Please enter the 4-digit code sent to your email.".tr,
                          style: theme.textTheme.bodyMedium,
                        ),
                        
                        SizedBox(height: media.size.height * 0.06),
                        
                        // 4. THE DIGIT RECTANGLES (Pinput Widget)
                        Center(
                          child: Pinput(
                            length: 4, // Set to 4 or 6 depending on your backend requirements
                            controller: controller.codeController, // Connected to shared controller
                            defaultPinTheme: defaultPinTheme,
                            focusedPinTheme: focusedPinTheme,
                            errorPinTheme: errorPinTheme,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.length < 4) {
                                return "Please enter the complete code".tr;
                              }
                              return null;
                            },
                            // Triggers automatically when the user fills the final box
                            onCompleted: (pin) {
                              // Optional: automatically trigger verification when code is typed
                            },
                          ),
                        ),
                        SizedBox(height: media.size.height *0.21,),
                        PrimaryButton(text: "Confirm Code", onPressed: (){})]),
               
                  
              ),
            
      ),
       
    )
    ),
    ]),
    );
  }
}