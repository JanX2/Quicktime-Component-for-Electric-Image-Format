/*
VERSION HISTORY

12-Apr-2004: 1.4b1
13-Apr-2004: 1.4b2 - changed package extension to ".qtx" [1],
					 build OS 9 version, many other cleanups
14-Apr-2004: 1.4b3 - minor fix movie export extension IMG -> img
14-Apr-2004: 1.4b4 - fix Export presets menu (OS X)
17-Apr-2004: 1.4b4 - Windows release (VC6 build)
20-Apr-2004: 1.4b5 - new Win build with VC6SP6, code gen for "Blend"
01-May-2004:       - source release to EI, with fixed VS6 build settings
27-Feb-2005: 1.4b6 - public source release
28-Feb-2005: 1.4b7 - fix Manufacturer field in MovieExport - should be 'appl'
21-Dec-2006: 1.5b1 - Universal (PPC/Intel) version
23-Dec-2006: 1.5b2 - fix resource compilation ('thng' templates)
*/

/*	Code resource IDs, when building for PPC (not CFM).
	For CodeWarrior, these IDs are set in the Project Settings->PPC Target panel of each subproject.
	Not applicable to Mach-O or CFM builds, as code resources are not used. */
#define kEI_GraphicsImportID	0x0100
#define kEI_GraphicsExportID	0x0200
#define kEI_MovieImportID		0x0300
#define kEI_MovieExportID		0x0400
#define kEI_ImageCodecID		0x0500

/* software version */
#define kEI_VersionShort		"1.5b2"
#define kEI_VersionNum			1,0x50,beta,2 // used in 'vers' resource
#define kEI_VersionHex			0x1502
/* remember to update Xcode/Project Builder project settings, too! */

/* formatted for Win32 VERSIONINFO resource */
#define VI_VERS_NUM 1,5,0,2
#ifdef _DEBUG
	#define VI_FLAGS	VS_FF_PRERELEASE|VS_FF_DEBUG
#else
	#define VI_FLAGS	VS_FF_PRERELEASE /* 0 for final, or any of VS_FF_DEBUG,VS_FF_PATCHED,VS_FF_PRERELEASE,VS_FF_PRIVATEBUILD,VS_FF_SPECIALBUILD */
#endif
#define VI_COMMENTS	"Electric Image (EIAS) Component originally written by Apple. Large file support and other enhancements by Telegraphics Pty Ltd.\r\n\r\nPlease contact support@telegraphics.com.au with any bug reports, suggestions or comments.\0"	/* null terminated Comments field */

#define kEI_ComponentVersion			(0x00010000|kEI_VersionHex)
#define kEI_CodecVersion				(0x00020000|kEI_VersionHex)
#define kEI_CodecVersionPPC				(0x00020000|kEI_VersionHex)
#define kEI_MovieImportVersion			kEI_ComponentVersion
#define kEI_MovieImportVersionPPC		kEI_ComponentVersion
#define kEI_MovieExportVersion			kEI_ComponentVersion
#define kEI_MovieExportVersionPPC		kEI_ComponentVersion
#define kEI_GraphicsExportVersion 		kEI_ComponentVersion
#define kEI_GraphicsExportVersionPPC 	kEI_ComponentVersion
#define kEI_GraphicsImportVersion		kEI_ComponentVersion
#define kEI_GraphicsImportVersionPPC	kEI_ComponentVersion

/* See http://developer.apple.com/documentation/QuickTime/RM/Fundamentals/ComponentMgr/index.html
 "Use the high-order 16 bits to represent the major version
 and the low-order 16 bits to represent the minor version. 
 The major version should represent the component specification level;
 the minor version should represent your implementation's 
 version number." */

//#define kEI_CFMImplVersion 0x01406003
/* 3rd byte of CFM version:
0x20	development	Prealpha file
0x40	alpha	Alpha file
0x60	beta	Beta file
0x80	release	Released file
*/

// standard Electric Image Mac file type
#define kEI_Sig			'EIDI'
#define kEI_SigString	"EIDI"

// standard Electric Image file extension is .img
// (*NOT* .eim, that is reserved for Electric Image Modeller project files)
#define kEI_ExtSig		'IMG ' // must be upper case
#define kEI_ExtSigLC	'img ' // lower case version
#define kEI_ExtString	"img"  // comma delimited if more than one

#define sigMoviePlayer	'TVOD' // from "FileTypesAndCreators.h"
