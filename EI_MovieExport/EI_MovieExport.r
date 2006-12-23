/*
	File:		EI_MovieExport.r
	
	Description: Resources for QuickTime movie export component sample

	Author:		QuickTime Engineering

	Copyright: 	� Copyright 1999 - 2003 Apple Computer, Inc. All rights reserved.
	
	Disclaimer:	IMPORTANT:  This Apple software is supplied to you by Apple Computer, Inc.
				("Apple") in consideration of your agreement to the following terms, and your
				use, installation, modification or redistribution of this Apple software
				constitutes acceptance of these terms.  If you do not agree with these terms,
				please do not use, install, modify or redistribute this Apple software.

				In consideration of your agreement to abide by the following terms, and subject
				to these terms, Apple grants you a personal, non-exclusive license, under Apple�s
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
				
	Change History (most recent first):	
		<2>	 	03/29/03	era		updated and initial release
		<1>	 	11/28/99	QTE		first file
*/

/*
    thng_RezTemplateVersion:
        0 - original 'thng' template    <-- default
        1 - extended 'thng' template	<-- used for multiplatform things
        2 - extended 'thng' template including resource map id
*/
#define thng_RezTemplateVersion 2

/*
    cfrg_RezTemplateVersion:
        0 - original					<-- default
        1 - extended
*/
#define cfrg_RezTemplateVersion 1

#if TARGET_REZ_CARBON_MACHO
    #include <Carbon/Carbon.r>
    #include <QuickTime/QuickTime.r>
	#undef __CARBON_R__
	#undef __CORESERVICES_R__
	#undef __CARBONCORE_R__
	#undef __COMPONENTS_R__
#else
    #include "ConditionalMacros.r"
    #include "Components.r"
    #include "QuickTimeComponents.r"
    #include "Types.r"
    #include "MacTypes.r"
    #include "Components.r"
    #include "CodeFragments.r"
	#undef __COMPONENTS_R__
#endif

#include "EI_IDs.h"

#define	kEI_MovieExport_256Colors_12fps			 kEI_MovieExportID
#define	kEI_MovieExport_256Colors_30fps			(kEI_MovieExportID+1)
#define	kEI_MovieExport_ThousandsColors_12fps	(kEI_MovieExportID+2)
#define	kEI_MovieExport_ThousandsColors_30fps	(kEI_MovieExportID+3)
#define	kEI_MovieExport_MillionsColors_12fps	(kEI_MovieExportID+4)
#define	kEI_MovieExport_MillionsColors_30fps	(kEI_MovieExportID+5)

#define kEI_MovieExportFlags \
	(canMovieExportFiles | canMovieExportFromProcedures | movieExportMustGetSourceMediaType \
	| hasMovieExportUserInterface | canMovieExportValidateMovie)

// Component Manager Thing
resource 'thng' (kEI_MovieExportID,"EI Movie Export",locked) {
	'spit',									// Type
	kEI_Sig,								// SubType
	'appl',									// Manufacturer
#if TARGET_REZ_MAC_68K
	kEI_MovieExportFlags,					// Component flags
	0,										// Component flags Mask
	'spit', kEI_MovieExportID,              // Code ID
#else
	0,										// - use componentHasMultiplePlatforms
	0,
	0, 0,
#endif
	'STR ', kEI_MovieExportID,              // Name ID
	'STR ', kEI_MovieExportID+1,            // Info ID
	0, 0,									// Icon ID
	kEI_ComponentVersion,
	componentHasMultiplePlatforms | componentDoAutoVersion, // Registration Flags
	0,										// Resource ID of Icon Family
	{
#if TARGET_OS_MAC							// COMPONENT PLATFORM INFORMATION ----------------------
	#if TARGET_REZ_CARBON_CFM
		kEI_MovieExportFlags,				// Component Flags
		'cfrg',								// Special Case: data-fork based code fragment
		kEI_MovieExportID, /* Code ID usage for CFM components:
							0 (kCFragResourceID) - This means the first member in the code fragment;
								Should only be used when building a single component per file. When doing so
								using kCFragResourceID simplifies things because a custom 'cfrg' resource is not required
							n - This value must match the special 'cpnt' qualifier 1 in the custom 'cfrg' resource */
		platformPowerPCNativeEntryPoint,	// Platform Type (response from gestaltComponentPlatform or failing that, gestaltSysArchitecture)
	#endif
	#if TARGET_REZ_CARBON_MACHO
		kEI_MovieExportFlags, 
		'dlle',								// Code Resource type - Entry point found by symbol name 'dlle' resource
		kEI_MovieExportID,					// ID of 'dlle' resource
		platformPowerPCNativeEntryPoint,
	#endif
	#if TARGET_REZ_CARBON_MACHO_X86
		kEI_MovieExportFlags, 
		'dlle',
		kEI_MovieExportID,
		platformIA32NativeEntryPoint,
	#endif
	#if TARGET_REZ_MAC_PPC
		kEI_MovieExportFlags, 
		'spit', kEI_MovieExportID,			// Code ID
		platformPowerPC,
	#endif
	#if TARGET_REZ_MAC_68K
		kEI_MovieExportFlags,
		'spit', kEI_MovieExportID,
		platform68k,
	#endif
#endif
#if TARGET_OS_WIN32
	kEI_MovieExportFlags, 
	'dlle', kEI_MovieExportID,
	platformWin32,
#endif
	},
	'thnr', kEI_MovieExportID				// Component public resource identifier
};

// Component Name used in Movie Export Dialog
resource 'STR ' (kEI_MovieExportID) {
	"Electric Image Movie"
};

// Component Information
resource 'STR ' (kEI_MovieExportID+1) {
	"Exports a QuickTime Movie file to an Electric Image file."
};

// Component public resource
resource 'thnr' (kEI_MovieExportID) {
	{
		'src#', 1, 0,
		'src#', kEI_MovieExportID, 0,

		'src#', 2, 0,
		'trk#', kEI_MovieExportID, 0,

		'stg#', 1, 0,
		'stg#', kEI_MovieExportID, 0,
		
		'STR#', 1, 0,
		'STR#', kEI_MovieExportID, 0,

		'sttg', 1, 0,
		'sttg', kEI_MovieExport_256Colors_12fps, 0,
		
		'sttg', 2, 0,
		'sttg', kEI_MovieExport_256Colors_30fps, 0,

		'sttg', 3, 0,
		'sttg', kEI_MovieExport_ThousandsColors_12fps, 0,
		
		'sttg', 4, 0,
		'sttg', kEI_MovieExport_ThousandsColors_30fps, 0,
		
		'sttg', 5, 0,
		'sttg', kEI_MovieExport_MillionsColors_12fps, 0,
		
		'sttg', 6, 0,
		'sttg', kEI_MovieExport_MillionsColors_30fps, 0,
	}
};

// http://developer.apple.com/techpubs/quicktime/qtdevdocs/REF/refDataExchange.23.htm#pgfId=13688

// Lists a movie exporter component's supported media types and the minimum and maximum number of sources for each.
//
// A'src#' resource may be associated with export components that implement MovieExportFromProceduresToDataRef. The
// resource is used to indicate the types of data sources the export component can support. Moreover, for each type,
// it also indicates the minimum and maximum number of data sources of that type. Clients can use this information to
// determine if the number of data sources they want to export can be handled directly by the exporter. If the data
// source type is supported by fewer sources are allowed, the client application must either export a fewer number of
// sources or combine the data from its candidate sources itself to meet the limitation imposed by the exporter. 
resource 'src#' (kEI_MovieExportID) {
	{
		'vide', 1, 1, isSourceType
	}
};

// Whereas 'src#' is meant to describe the number of data sources supported for use with MovieExportFromProceduresToDataRef,
// the 'trk#' resource is meant to indicate the number of tracks of the given types that can be exported. The resource is
// identical to the resource for data sources. The difference is that the flags will have one of two values: 
// 		isSourceType  - A media type such as 'vide' for video tracks, 'soun' for sound tracks, or 'musi' for QuickTime music tracks.
//      isMediaCharacteristic - Indicates that mediaType corresponds to a media characteristic such a 'eyes' for visual tracks or
//								'ears' for tracks with sound.
resource 'trk#' (kEI_MovieExportID) {
	{
		'eyes', 1, 65535, isMediaCharacteristic
	}
};

// List of presets
// NOTE: These presets are used in the "Recent Settings" machinery of the Export dialog
//       accessed with ConvertMovieToFile(..., showUserSettingsDialog, ... ).
resource 'stg#' (kEI_MovieExportID) {
	0,
	{
		'8c12', 0, 
		'sttg', 1, 
		1, 1, 
		0, 0,
		
		'8c30', 0, 
		'sttg', 2, 
		1, 2, 
		0, 0,

		'----', kQTPresetInfoIsDivider, 
		0, 0, 
		0, 0, 
		0, 0,

		'tc12', 0, 
		'sttg', 3, 
		1, 3, 
		0, 0,
		
		'tc30', 0, 
		'sttg', 4, 
		1, 4, 
		0, 0,
		
		'----', kQTPresetInfoIsDivider, 
		0, 0, 
		0, 0, 
		0, 0,
		
		'mc12', 0, 
		'sttg', 5, 
		1, 5, 
		0, 0,
		
		'mc30', 0, 
		'sttg', 6, 
		1, 6, 
		0, 0
	}
};

// Strings for preset menu
resource 'STR#' (kEI_MovieExportID) {
	{
		"256 Colors, 12 fps",
		"256 Colors, 30 fps",

		"Thousands of Colors, 12 fps",
		"Thousands of Colors, 30 fps",
		
		"Millions of Colors+, 12 fps",
		"Millions of Colors+, 30 fps"
	}
};

// Preset atom data
// Note: These presets can be generated for your component by writing a very simple application
//       which opens your movie export component, configures it by calling MovieExportDoUserDialog
//       then calls MovieExportGetSettingsAsAtomContainer to get back the atom container
//       and saves it. The returned Atom container is the data you place in the 'sttg'.
data 'sttg' (kEI_MovieExport_256Colors_12fps, "256Colors_12fps") {
	$"0000 0000 0000 0000 0000 0000 0000 006A"            /* ...............j */
	$"7365 616E 0000 0001 0000 0002 0000 0000"            /* sean............ */
	$"0000 002A 636F 6C72 0000 0001 0000 0001"            /* ...*colr........ */
	$"0000 0000 0000 0016 6470 7468 0000 0001"            /* ........dpth.... */
	$"0000 0000 0000 0000 0008 0000 002C 7469"            /* .............,ti */
	$"6D65 0000 0001 0000 0001 0000 0000 0000"            /* me.............. */
	$"0018 6670 7320 0000 0001 0000 0000 0000"            /* ..fps .......... */
	$"0000 000C 0000"                                     /* ...... */
};

data 'sttg' (kEI_MovieExport_256Colors_30fps, "256Colors_30fps") {
	$"0000 0000 0000 0000 0000 0000 0000 006A"            /* ...............j */
	$"7365 616E 0000 0001 0000 0002 0000 0000"            /* sean............ */
	$"0000 002A 636F 6C72 0000 0001 0000 0001"            /* ...*colr........ */
	$"0000 0000 0000 0016 6470 7468 0000 0001"            /* ........dpth.... */
	$"0000 0000 0000 0000 0008 0000 002C 7469"            /* .............,ti */
	$"6D65 0000 0001 0000 0001 0000 0000 0000"            /* me.............. */
	$"0018 6670 7320 0000 0001 0000 0000 0000"            /* ..fps .......... */
	$"0000 001E 0000"                                     /* ...... */
};

data 'sttg' (kEI_MovieExport_ThousandsColors_12fps, "ThousandsColors_12fps") {
	$"0000 0000 0000 0000 0000 0000 0000 006A"            /* ...............j */
	$"7365 616E 0000 0001 0000 0002 0000 0000"            /* sean............ */
	$"0000 002A 636F 6C72 0000 0001 0000 0001"            /* ...*colr........ */
	$"0000 0000 0000 0016 6470 7468 0000 0001"            /* ........dpth.... */
	$"0000 0000 0000 0000 0010 0000 002C 7469"            /* .............,ti */
	$"6D65 0000 0001 0000 0001 0000 0000 0000"            /* me.............. */
	$"0018 6670 7320 0000 0001 0000 0000 0000"            /* ..fps .......... */
	$"0000 000C 0000"                                     /* ...... */
};

data 'sttg' (kEI_MovieExport_ThousandsColors_30fps, "ThousandsColors_30fps") {
	$"0000 0000 0000 0000 0000 0000 0000 006A"            /* ...............j */
	$"7365 616E 0000 0001 0000 0002 0000 0000"            /* sean............ */
	$"0000 002A 636F 6C72 0000 0001 0000 0001"            /* ...*colr........ */
	$"0000 0000 0000 0016 6470 7468 0000 0001"            /* ........dpth.... */
	$"0000 0000 0000 0000 0010 0000 002C 7469"            /* .............,ti */
	$"6D65 0000 0001 0000 0001 0000 0000 0000"            /* me.............. */
	$"0018 6670 7320 0000 0001 0000 0000 0000"            /* ..fps .......... */
	$"0000 001E 0000"                                     /* ...... */
};

data 'sttg' (kEI_MovieExport_MillionsColors_12fps, "Millions+Colors_12fps") {
	$"0000 0000 0000 0000 0000 0000 0000 006A"            /* ...............j */
	$"7365 616E 0000 0001 0000 0002 0000 0000"            /* sean............ */
	$"0000 002A 636F 6C72 0000 0001 0000 0001"            /* ...*colr........ */
	$"0000 0000 0000 0016 6470 7468 0000 0001"            /* ........dpth.... */
	$"0000 0000 0000 0000 0020 0000 002C 7469"            /* .............,ti */
	$"6D65 0000 0001 0000 0001 0000 0000 0000"            /* me.............. */
	$"0018 6670 7320 0000 0001 0000 0000 0000"            /* ..fps .......... */
	$"0000 000C 0000"                                     /* ...... */
};

data 'sttg' (kEI_MovieExport_MillionsColors_30fps, "Millions+Colors_30fps") {
	$"0000 0000 0000 0000 0000 0000 0000 006A"            /* ...............j */
	$"7365 616E 0000 0001 0000 0002 0000 0000"            /* sean............ */
	$"0000 002A 636F 6C72 0000 0001 0000 0001"            /* ...*colr........ */
	$"0000 0000 0000 0016 6470 7468 0000 0001"            /* ........dpth.... */
	$"0000 0000 0000 0000 0020 0000 002C 7469"            /* .............,ti */
	$"6D65 0000 0001 0000 0001 0000 0000 0000"            /* me.............. */
	$"0018 6670 7320 0000 0001 0000 0000 0000"            /* ..fps .......... */
	$"0000 001E 0000"                                     /* ...... */
};

resource 'STR#' (kEI_MovieExportID+1) {
	{ kEI_SigString }
};

#if TARGET_REZ_CARBON_CFM && !defined(SKIP_CFRG)
// Custom extended code fragment resource
// CodeWarrior will correctly adjust the offset and length of each
// code fragment when building a MacOS Merge target
resource 'cfrg' (0) {
	{		
		extendedEntry {
			kPowerPCCFragArch,					// archType
			kIsCompleteCFrag,					// updateLevel
			kNoVersionNum,						// currentVersion
			kNoVersionNum,						// oldDefVersion
			kDefaultStackSize,					// appStackSize
			kNoAppSubFolder,					// appSubFolderID
			kImportLibraryCFrag,				// usage
			kDataForkCFragLocator,				// where
			kZeroOffset,						// offset
			kCFragGoesToEOF,					// length
			"EI Movie Exporter",				// member name
			
			// Start of extended info.
			
			'cpnt',								// libKind (not kFragComponentMgrComponent == 'comp' as you might expect)
			$$Format("%c%c",kEI_MovieExportID >> 8,kEI_MovieExportID), // qualifier 1 - matches Code ID in 'thng'
			"",									// qualifier 2
			"",									// qualifier 3
			"Electric Image Movie Exporter",	// intlName, localised
		};
	};
};
#endif

#if	TARGET_REZ_CARBON_MACHO || TARGET_REZ_CARBON_MACHO_X86 || TARGET_REZ_WIN32
// Code Entry Point for Mach-O and Windows
	resource 'dlle' (kEI_MovieExportID) {
		"EI_MovieExportComponentDispatch"
	};
#endif
