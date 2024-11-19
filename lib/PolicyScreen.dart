import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PolicyScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Privacy Policy',style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold,fontSize: 18),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'This privacy policy applies to the Random Hub app (hereby referred to as "Application") for mobile devices that was created by Arshad Technologies (hereby referred to as "Service Provider") as a Free service. This service is intended for use "AS IS".',
                style: TextStyle(color: Colors.black, fontSize: 14),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('What information does the Application obtain and how is it used?',style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold,fontSize: 18),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('The Application does not obtain any information when you download and use it. Registration is not required to use the Application.',style: TextStyle(color: Colors.black , fontSize: 14),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Does the Application collect precise real time location information of the device?',style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold,fontSize: 18),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('This Application does not collect precise information about the location of your mobile device.',style: TextStyle(color: Colors.black , fontSize: 14),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Do third parties see and/or have access to information obtained by the Application?',style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold,fontSize: 18),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Since the Application does not collect any information, no data is shared with third parties.',style: TextStyle(color: Colors.black , fontSize: 14),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('What are my opt-out rights?',style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold,fontSize: 18),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('You can stop all collection of information by the Application easily by uninstalling it. You may use the standard uninstall processes as may be available as part of your mobile device or via the mobile application marketplace or network.',style: TextStyle(color: Colors.black , fontSize: 14),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Children',style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold,fontSize: 18),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  'The Application is not used to knowingly solicit data from or market to children under the age of 13. The Service Provider does not knowingly collect personally identifiable information from children. The Service Provider encourages all children to never submit any personally identifiable information through the Application and/or Services. Parents and legal guardians are encouraged to monitor their children\'s internet usage and help enforce this policy by instructing their children never to provide personally identifiable information through the Application and/or Services without permission. If you have reason to believe that a child has provided personally identifiable information to the Service Provider through the Application and/or Services, please contact the Service Provider (arshadhabib956@gmail.com.) so that necessary actions can be taken. You must also be at least 16 years of age to consent to the processing of your personally identifiable information in your country (in some countries, your parent or guardian may be allowed to consent on your behalf).',
               style: TextStyle(color: Colors.black, fontSize: 14),
               ),
            ),
           Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Security',style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold,fontSize: 18),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('The Service Provider is concerned about safeguarding the confidentiality of your information. However, since the Application does not collect any information, there is no risk of your data being accessed by unauthorized individuals.',style: TextStyle(color: Colors.black , fontSize: 14),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Changes',style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold,fontSize: 18),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('This Privacy Policy may be updated from time to time for any reason. The Service Provider will notify you of any changes to their Privacy Policy by updating this page with the new Privacy Policy. You are advised to consult this Privacy Policy regularly for any changes, as continued use is deemed approval of all changes.\n\n\nThis privacy policy is effective as of 2024-09-27.',style: TextStyle(color: Colors.black , fontSize: 14),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Your Consent',style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold,fontSize: 18),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('By using the Application, you are consenting to the processing of your information as set forth in this Privacy Policy now and as amended by the Service Provider.',style: TextStyle(color: Colors.black , fontSize: 14),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Contact Us',style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold,fontSize: 18),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('If you have any questions regarding privacy while using the Application, or have questions about the practices, please contact the Service Provider via email at arshadhabib956@gmail.com.',style: TextStyle(color: Colors.black , fontSize: 14),),
            ),
          ],
        ),
      ),
    );
  }

}