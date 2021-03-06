/*
	File:		EI_Codec.r
	
	Description: Decompressor component resources

	Author:		QuickTime Engineering, JSAM

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
		<3>		06/12/01	ERA		rezability for MAC and Win
		<2>	 	11/17/00	ERA		updating for PPC and X	
		<1>	 	11/28/99	QTE		first file
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
        1 - extended					<-- we use the extended version
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
    #include "ImageCodec.r"
    #include "CodeFragments.r"
	#undef __COMPONENTS_R__
#endif

#include "EI_IDs.h"

#define	kEI_CodecFormatType	kEI_Sig
#define	kEI_CodecFormatName	"Electric Image"

// These flags specify information about the capabilities of the component
// Works with 1-bit, 8-bit, 16-bit and 32-bit Pixel Maps
#define kEI_DecoFlags ( codecInfoDoes32 | codecInfoDoes16 | codecInfoDoes8 \
	| codecInfoDoes1 | codecInfoDoesSpool )

// These flags specify the possible format of compressed data produced by the component
// and the format of compressed files that the component can handle during decompression
// The component can decompress from files at 1-bit, 8-bit, 16-bit, 24-bit and 32-bit depths
#define kEI_FormatFlags	( codecInfoDepth32 | codecInfoDepth24 | codecInfoDepth16 \
	| codecInfoDepth8 | codecInfoDepth1 | codecInfoStoresClut | codecInfoDoesLossless )

// Component Description
resource 'cdci' (kEI_ImageCodecID) {
	kEI_CodecFormatName,	// Type
	1,						// Version
	1,						// Revision level
	'appl',					// Manufacturer
	kEI_DecoFlags,			// Decompression Flags
	0,						// Compression Flags
	kEI_FormatFlags,		// Format Flags
	128,					// Compression Accuracy
	128,					// Decompression Accuracy
	200,					// Compression Speed
	200,					// Decompression Speed
	128,					// Compression Level
	0,						// Reserved
	1,						// Minimum Height
	1,						// Minimum Width
	0,						// Decompression Pipeline Latency
	0,						// Compression Pipeline Latency
	0						// Private Data
};

resource 'thng' (kEI_ImageCodecID,"EI Image Codec",locked) {
	decompressorComponentType,				// Type			
	kEI_CodecFormatType,					// SubType
	'appl',									// Manufacturer
#if TARGET_REZ_MAC_68K
	kEI_DecoFlags,							// Component flags
	0,										// Component flags Mask
	'cdec', kEI_ImageCodecID,				// Code ID
#else
	0,										// - use componentHasMultiplePlatforms
	0,
	0, 0,
#endif
	'STR ', kEI_ImageCodecID,				// Name ID
	'STR ', kEI_ImageCodecID+1,				// Info ID
	0, 0,									// Icon ID
#if TARGET_REZ_MAC_68K || TARGET_REZ_WIN32	// Version
	kEI_CodecVersion,
#else
	kEI_CodecVersionPPC,
#endif
	componentHasMultiplePlatforms | componentDoAutoVersion, // Registration Flags 
	0,										// Resource ID of Icon Family
	{
#if TARGET_OS_MAC
	#if TARGET_REZ_CARBON_CFM
		kEI_DecoFlags,				// Component Flags
		'cfrg',								// Special Case: data-fork based code fragment
		kEI_ImageCodecID, /* Code ID usage for CFM components:
							0 (kCFragResourceID) - This means the first member in the code fragment;
								Should only be used when building a single component per file. When doing so
								using kCFragResourceID simplifies things because a custom 'cfrg' resource is not required
							n - This value must match the special 'cpnt' qualifier 1 in the custom 'cfrg' resource */
		platformPowerPCNativeEntryPoint,	// Platform Type (response from gestaltComponentPlatform or failing that, gestaltSysArchitecture)
	#endif
	#if TARGET_REZ_CARBON_MACHO
		kEI_DecoFlags, 
		'dlle',								// Code Resource type - Entry point found by symbol name 'dlle' resource
		kEI_ImageCodecID,					// ID of 'dlle' resource
		platformPowerPCNativeEntryPoint,
	#endif
	#if TARGET_REZ_CARBON_MACHO_X86
		kEI_DecoFlags, 
		'dlle',
		kEI_ImageCodecID,
		platformIA32NativeEntryPoint,
	#endif
	#if TARGET_REZ_MAC_PPC
		kEI_DecoFlags, 
		'cdek', kEI_ImageCodecID, // TODO: confirm if this type code is correct (s/be 'cdec'?)
		platformPowerPC,
	#endif
	#if TARGET_REZ_MAC_68K
		kEI_DecoFlags,
		'cdec', kEI_ImageCodecID,
		platform68k,
	#endif
#endif
#if TARGET_OS_WIN32
	kEI_DecoFlags, 
	'dlle', kEI_ImageCodecID,
	platformWin32,
#endif
	};
};

// Component Name
resource 'STR ' (kEI_ImageCodecID) {
	"Electric Image Codec"
};

// Component Information
resource 'STR ' (kEI_ImageCodecID+1) {
	"Decompresses images stored in the Electric Image format."
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
			"EI Codec",							// member name
			
			// Start of extended info.
			
			'cpnt',								// libKind (not kFragComponentMgrComponent == 'comp' as you might expect)
			$$Format("%c%c",kEI_ImageCodecID >> 8,kEI_ImageCodecID), // qualifier 1 - matches Code ID in 'thng'
			"",									// qualifier 2
			"",									// qualifier 3
			"Electric Image Codec",				// intlName, localised
		};
	};
};
#endif

#if	TARGET_REZ_CARBON_MACHO || TARGET_REZ_CARBON_MACHO_X86 || TARGET_REZ_WIN32
// Code Entry Point for Mach-O and Windows
	resource 'dlle' (kEI_ImageCodecID) {
		"EI_ImageCodecComponentDispatch"
	};
#endif
