/*
	File:		EI_GraphicsExport.r

	Description: QuickTime graphics exporter component resources

	Author:		QuickTime Engineering, era

	Copyright: 	� Copyright 2003 Apple Computer, Inc. All rights reserved.
	
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
	   <1>	 	04/20/03	era			first file
*/

/*
    thng_RezTemplateVersion:
        0 - original 'thng' template    <-- default
        1 - extended 'thng' template	<-- used for multiplatform things
        2 - extended 'thng' template including resource map id
*/
#define thng_RezTemplateVersion 1

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
    #include "MacTypes.r"
    #include "Components.r"
    #include "QuickTimeComponents.r"
    #include "ImageCompression.r"
    #include "CodeFragments.r"
	#undef __COMPONENTS_R__
#endif

#include "EI_IDs.h"

#define kEI_GraphicsExportFlags (0)

// Component Manager Thing 'thng'
resource 'thng' (kEI_GraphicsExportID,"EI Graphics Export",locked) {
	'grex',									// Type
	kEI_Sig,								// Subtype
	'appl',									// Manufacturer
#if TARGET_REZ_MAC_68K
	kEI_GraphicsExportFlags,				// Component flags
	0,										// Component flags Mask
	'grex', kEI_GraphicsExportID,			// Code ID
#else
	0,										// - use componentHasMultiplePlatforms
	0,
	0, 0,
#endif
	'STR ', kEI_GraphicsExportID,			// Name ID
	'STR ', kEI_GraphicsExportID+1,			// Info ID
	0, 0,									// Icon ID
	kEI_ComponentVersion,
	componentHasMultiplePlatforms | componentDoAutoVersion,
	0,										// Resource ID of Icon Family
	{
#if TARGET_OS_MAC							// COMPONENT PLATFORM INFORMATION ----------------------
	#if TARGET_REZ_CARBON_CFM
		kEI_GraphicsExportFlags,				// Component Flags
		'cfrg',								// Special Case: data-fork based code fragment
		kEI_GraphicsExportID, /* Code ID usage for CFM components:
							0 (kCFragResourceID) - This means the first member in the code fragment;
								Should only be used when building a single component per file. When doing so
								using kCFragResourceID simplifies things because a custom 'cfrg' resource is not required
							n - This value must match the special 'cpnt' qualifier 1 in the custom 'cfrg' resource */
		platformPowerPCNativeEntryPoint,	// Platform Type (response from gestaltComponentPlatform or failing that, gestaltSysArchitecture)
	#endif
	#if TARGET_REZ_CARBON_MACHO
		kEI_GraphicsExportFlags, 
		'dlle',								// Code Resource type - Entry point found by symbol name 'dlle' resource
		kEI_GraphicsExportID,					// ID of 'dlle' resource
		platformPowerPCNativeEntryPoint,
	#endif
	#if TARGET_REZ_CARBON_MACHO_X86
		kEI_GraphicsExportFlags, 
		'dlle',
		kEI_GraphicsExportID,
		platformIA32NativeEntryPoint,
	#endif
	#if TARGET_REZ_MAC_PPC
		kEI_GraphicsExportFlags, 
		'grex', kEI_GraphicsExportID,			// Code ID
		platformPowerPC,
	#endif
	#if TARGET_REZ_MAC_68K
		kEI_GraphicsExportFlags,
		'grex', kEI_GraphicsExportID,
		platform68k,
	#endif
#endif
#if TARGET_OS_WIN32
	kEI_GraphicsExportFlags, 
	'dlle', kEI_GraphicsExportID,
	platformWin32,
#endif
	}
};

resource 'STR ' (kEI_GraphicsExportID) {
	"Electric Image"
};

resource 'STR ' (kEI_GraphicsExportID+1) {
	"Exports a Still Image to an Electric Image file."
};

/* 
 * This is an example of how to build an atom container resource to hold mime types.
 * This component's GetMIMETypeList implementation simply loads this resource and returns it.
 * Please note that atoms of the same type MUST be grouped together within an atom container.
 * (Also note that "image/electric-image" may not have been registered with the IETF.)
 */
resource 'mime' (kEI_GraphicsExportID) {
	{
		kMimeInfoMimeTypeTag,      1, "image/electric-image";
		kMimeInfoMimeTypeTag,      2, "image/x-electric-image";
		kMimeInfoFileExtensionTag, 1, kEI_ExtString;
		kMimeInfoFileExtensionTag, 2, kEI_ExtString;
		kMimeInfoDescriptionTag,   1, "Electric Image";
		kMimeInfoDescriptionTag,   2, "Electric Image";
	};
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
			"EI Graphics Exporter",				// member name
			
			// Start of extended info.
			
			'cpnt',								// libKind (not kFragComponentMgrComponent == 'comp' as you might expect)
			$$Format("%c%c",kEI_GraphicsExportID >> 8,kEI_GraphicsExportID), // qualifier 1 - matches Code ID in 'thng'
			"",									// qualifier 2
			"",									// qualifier 3
			"Electric Image Graphics Exporter",	// intlName, localised
		};
	};
};
#endif

#if	TARGET_REZ_CARBON_MACHO || TARGET_REZ_CARBON_MACHO_X86 || TARGET_REZ_WIN32
// Code Entry Point for Mach-O and Windows
	resource 'dlle' (kEI_GraphicsExportID) {
		"EI_GraphicsExportComponentDispatch"
	};
#endif
