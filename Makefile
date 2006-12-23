# GNU Makefile for Universal Binary QT Component

# toby@telegraphics.com.au, 21 Dec 2006
# See: http://developer.apple.com/technotes/tn/tn2012.html

# Targets:
#     'fat'    - build a Universal binary, both Intel and PPC archs
#                (requires MacOSX10.4u.sdk)
#     'native' - build for current arch only

BUNDLE = EIComponentUB.component
BUNDLEEXEC = ElectricImage
FATBIN  = $(BUNDLE)/Contents/MacOS/$(BUNDLEEXEC)
RSRC = $(BUNDLE)/Contents/Resources/$(BUNDLEEXEC).rsrc
NIB = $(BUNDLE)/Contents/Resources/EI_Export.nib

# See: http://developer.apple.com/documentation/Porting/Conceptual/PortingUnix/compiling/chapter_4_section_3.html#//apple_ref/doc/uid/TP40002850-BAJCFEBA
fat : CFLAGS += -isysroot /Developer/SDKs/MacOSX10.4u.sdk -arch ppc -arch i386
fat : LDFLAGS += -Wl,-syslibroot,/Developer/SDKs/MacOSX10.4u.sdk -arch ppc -arch i386

CPPFLAGS = -DSTAND_ALONE -I. -IEI_FormatIncludes -IUtilities \
	-IEI_GraphicsExport -IEI_GraphicsImport -IEI_ImageCodec \
	-IEI_MovieImport -IEI_MovieExport
CFLAGS += -O2 -Wall -Wextra -Wno-parentheses

# The TARGET_REZ* flags determine which platform descriptors are
# generated in the component 'thng' resource.

REZFLAGS = -i . \
	-d TARGET_REZ_MAC_68K=0 \
	-d TARGET_REZ_MAC_PPC=0 \
	-d TARGET_REZ_CARBON_CFM=0 \
	-d TARGET_REZ_WIN32=0

fat : REZFLAGS += -d TARGET_REZ_CARBON_MACHO=1 \
				  -d TARGET_REZ_CARBON_MACHO_X86=1

# determine arch at build-time
native : REZFLAGS += -d TARGET_REZ_CARBON_MACHO=$$ARCHPPC \
					 -d TARGET_REZ_CARBON_MACHO_X86=$$ARCHX86

REZFILES = \
	EI_GraphicsExport/EI_GraphicsExport.r \
	EI_GraphicsImport/EI_GraphicsImport.r \
	EI_ImageCodec/EI_ImageCodec.r \
	EI_MovieExport/EI_MovieExport.r \
	EI_MovieImport/EI_MovieImport.r

OBJ = \
	EI_GraphicsExport/EI_GraphicsExport.o \
	EI_GraphicsImport/EI_GraphicsImport.o \
	EI_ImageCodec/EI_ImageCodec.o \
	EI_MovieExport/EI_MovieExport.o \
	EI_MovieImport/EI_MovieImport.o \
	Utilities/EI_MakeImageDescription.o \
	Utilities/EI_RLE.o

native fat : $(FATBIN)

$(FATBIN) : ExportsPB.exp $(OBJ) $(RSRC) $(BUNDLE)/Contents/Info.plist \
			$(NIB)/classes.nib $(NIB)/info.nib $(NIB)/objects.xib
	mkdir -p $(dir $@)
	/Developer/Tools/SetFile -a B $(dir $@)
	$(CC) -bundle -o $@ $(OBJ) $(LDFLAGS) -exported_symbols_list ExportsPB.exp \
		-framework Carbon -framework CoreServices -framework QuickTime
	ls -l $@
	file $@

$(NIB) : ; mkdir -p $@
$(NIB)/% : EI_MovieExport/EI_Export.nib/% $(NIB)
	cp -f $< $@

$(BUNDLE)/Contents/Info.plist : Info.plist.in EI_IDs.h
	mkdir -p $(dir $@)
	V=`sed -n -E 's/^.*kEI_VersionShort[[:blank:]]+\"([^"]*)\"/\1/p' EI_IDs.h` ;\
		sed -e s/VERSION_STR/$$V/ $< > $@

$(RSRC) : $(REZFILES) EI_IDs.h
	mkdir -p $(dir $@)
	ARCHPPC=0; test `arch` == "ppc" && ARCHPPC=1; \
	ARCHX86=0; test `arch` == "i386" && ARCHX86=1; \
	/Developer/Tools/Rez -o $@ -rd -useDF $(filter %.r,$^) \
		-i /Developer/Headers/FlatCarbon $(REZFLAGS)
	ls -l $@

clean :
	rm -fr $(BUNDLE) $(OBJ)
