This version of the QuickTime component for Import/Export of ElectricImage files, 
based on Apple's sample code v1.3*, has been updated to provide support for
importing and exporting large (>4GB) IMG movies. This capability requires QuickTime 4 or later.[2]

The default Electric Image file extension has also been changed to .img (Apple's version used .eim, 
which is reserved for EI Modeller projects).

This is a beta test release, please make any bug reports to support@telegraphics.com.au


HOW TO INSTALL
--------------

MacOS X:
Put "ElectricImage.qtx" package (folder) into the /Library/QuickTime folder
(the QuickTime folder inside the Library folder at the top level of your OS X boot disk).

MacOS 8/9/Classic:
Install the file "ElectricImageComponentPPC" in the QuickTime Extensions folder in the Macintosh System Folder's Extension folder.

Mac 68K: Same as above, but use the "ElectricImage Component 68K" file.

Windows:
Put the "ElectricImageWindows.qtx" file in the QuickTime folder inside
the Windows System folder (typically "c:\System32\QuickTime" for Windows NT/2000,
"c:\System\QuickTime" for Windows 95/98/ME, "c:\windows\system32\quicktime" for XP).


REFERENCES
----------

[1] http://developer.apple.com/documentation/QuickTime/WhatsNewQT5/QT5NewChapt1/chapter_1_section_15.html#//apple_ref/doc/uid/TP40000936-DontLinkChapterID_1-TPXREF159
[2] 64-bit File Offset Support in QuickTime (4): http://developer.apple.com/quicktime/icefloe/dispatch022.html

TN1004: re building PowerPC components for QT 1.6 & Component Mgr 3.0:
http://developer.apple.com/technotes/tn/pdf/tn1004.pdf
a.k.a. TN QT05: http://developer.apple.com/technotes/qt/qt_05.html

TN2012: building CFM and Mach-O QuickTime components for Mac OS X
http://developer.apple.com/technotes/tn/tn2012.html

PowerPC-Native Component Manager Support (QT 2.5):
http://developer.apple.com/documentation/QuickTime/REF/refComponentMgr.4.htm

"What's new in QuickTime 5.0.2": 
http://developer.apple.com/documentation/QuickTime/PDF/quicktime502.pdf


*LEGAL NOTICE (terms of use of Apple sample source code)
 ------------

Copyright: 	© Copyright 2001 - 2003 Apple Computer, Inc. All rights reserved.

Disclaimer:	IMPORTANT:  This Apple software is supplied to you by Apple Computer, Inc.
("Apple") in consideration of your agreement to the following terms, and your
use, installation, modification or redistribution of this Apple software
constitutes acceptance of these terms.  If you do not agree with these terms,
please do not use, install, modify or redistribute this Apple software.

In consideration of your agreement to abide by the following terms, and subject
to these terms, Apple grants you a personal, non-exclusive license, under Apple’s
copyrights in this original Apple software (the "Apple Software"), to use,
reproduce, modify and redistribute the Apple Software, with or without
modifications, in source and/or binary forms; provided that if you redistribute
the Apple Software in its entirety and without modifications, you must retain
this notice and the following text and disclaimers in all such redistributions of
the Apple Software.  Neither the name, trademarks, service marks or logos of
Apple Computer, Inc. may be used to endorse or promote products derived from the
Apple Software without specific prior written permission from Apple.  Except as
expressly stated in this notice, no other rights or licenses, express or implied,
are granted by Apple herein, including but not limited to any patent rights that
may be infringed by your derivative works or by other works in which the Apple
Software may be incorporated.

The Apple Software is provided by Apple on an "AS IS" basis.  APPLE MAKES NO
WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION THE IMPLIED
WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A PARTICULAR
PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND OPERATION ALONE OR IN
COMBINATION WITH YOUR PRODUCTS.

IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION, MODIFICATION AND/OR DISTRIBUTION
OF THE APPLE SOFTWARE, HOWEVER CAUSED AND WHETHER UNDER THEORY OF CONTRACT, TORT
(INCLUDING NEGLIGENCE), STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN
ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
