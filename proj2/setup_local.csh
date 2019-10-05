# Source this file prior to running simulations.

#The following command sets all the Cadence tools to run in 64-bit
#
setenv CDS_AUTO_64BIT ALL

#-------------------------------------------------------------------
#Update the following paths, based on the local installations.
setenv AMSKITHOME /CMC/kits/AMSKIT616_GPDK
setenv SOURCEDIR $AMSKITHOME/source
setenv PDKDIR $AMSKITHOME/tech

source /CMC/scripts/cadence.ic06.16.090.csh
#source /CMC/scripts/cadence.ic06.16.110.csh
source /CMC/scripts/cadence.incisiv14.10.015.csh
source /CMC/scripts/cadence.mmsim13.11.292.csh
source /CMC/scripts/cadence.edi14.13.000.csh
source /CMC/scripts/cadence.conformal14.20.100.csh
#source /CMC/scripts/cadence.pvs14.13.419.csh
source /CMC/scripts/cadence.pvs14.12.000.csh
source /CMC/scripts/cadence.ext13.20.451.csh
source /CMC/scripts/cadence.rc14.13.000.csh
source /CMC/scripts/cadence.assura04.14.119-616.csh

setenv CDSHOME $CMC_CDS_IC_HOME
setenv INCISIVE_HOME $CMC_CDS_INCISIV_HOME 
setenv MMSIM_INST_DIR $CMC_CDS_INCISIV_HOME
setenv ENCOUNTER $CMC_CDS_EDI_HOME
setenv VERPLEX_HOME $CMC_CDS_CFML_HOME
setenv PVS_HOME $CMC_CDS_PVS_HOME
setenv EXT_HOME $QRC_HOME
setenv RC_HOME $CMC_CDS_RC_HOME
setenv ASSURAHOME $ASSURAHOME


#-------------------------------------------------------------------
#general functions
setenv  WORKDIR `pwd`
setenv  PROJDIR $AMSKITHOME
setenv  MANPATH $AMSKITHOME/docs
setenv  DIGITALHOME $WORKDIR/design/digital

alias   prpath  'set path = (\!* $path)'
alias   prpathm 'set MANPATH = (\!* $MANPATH)'
alias   appath  'set path = ($path \!*)'
alias   appathm 'set MANPATH = ($MANPATH \!*)'
alias   rmpath  'set path = (`echo $path | sed -e "s@[^ ]*\!:1[^ ]*@@g"`)'
alias   cdwa    'cd $WORKDIR'
#-------------------------------------------------------------------

#-------------------------------------------------------------------
#-------------------------------------------------------------------

#-------------------------------------------------------------------
# IC616  (11 Nov 2014  IC06.16.090, Version:IC6.1.6.500.9)
# appath      $CDSHOME/tools/bin
# appath      $CDSHOME/tools/dfII/bin
appath      $CDSHOME/tools/dracula/bin
appathm     $CDSHOME/share/man
setenv      DD_DONT_DO_OS_LOCKS set
setenv      DRCTEMPDIR /tmp
setenv      DD_USE_LIBDEFS no
setenv      CDS_Netlisting_Mode Analog
setenv      CDS_USE_PALETTE true
#-------------------------------------------------------------------

#-------------------------------------------------------------------
# INCISIV141  (03 Oct 2014  INCISIV14.10.007)
setenv      AMS_HOME $INCISIVE_HOME
appath      $INCISIVE_HOME/bin
# appath      $INCISIVE_HOME/tools/bin
appath      $INCISIVE_HOME/tools/systemc/gcc/bin
setenv      AMS_UNL  YES
#-------------------------------------------------------------------

#-------------------------------------------------------------------
#module-whatis    MMSIM131  (12 Sep 2014  MMSIM13.11.292, Version: 13.11.292)
setenv     CELHOME $MMSIM_INST_DIR
setenv     USIMHOME $MMSIM_INST_DIR
# appath     $MMSIM_INST_DIR/tools/bin
#-------------------------------------------------------------------

#-------------------------------------------------------------------
#module-whatis    EDI141  (21 Aug 2013  EDI14.13.000, Version: EDI14.13-s036_1)
# appath     $ENCOUNTER/tools/bin
appath     $ENCOUNTER/tools/ccopt/bin
#-------------------------------------------------------------------

#-------------------------------------------------------------------
#module-whatis    CONFRML131  (28 Feb 2014  CONFRML13.10.220, Version: CFM13.1-s220)
appath     $VERPLEX_HOME/bin
appath     $VERPLEX_HOME/tools/bin
#-------------------------------------------------------------------

#-------------------------------------------------------------------
#module-whatis    RC141  (24 Nov 2014  RC14.13.000, Version: RC14.10-s027)
appath     $RC_HOME/bin
appathm    $RC_HOME/share/synth/man
#-------------------------------------------------------------------

#-------------------------------------------------------------------
#module-whatis    10 Sep 2014 ASSURA04.14.116, Version: ASSURA_41USR4HF16_OA-616
setenv     SNAROOT $ASSURAHOME
setenv     SUBSTRATESTORMHOME $ASSURAHOME
setenv     ASSURA_NO_NMRD 1
appath     $ASSURAHOME/tools/bin
appath     $ASSURAHOME/tools/assura/bin
appathm    $ASSURAHOME/man
#-------------------------------------------------------------------

#-------------------------------------------------------------------
#module-whatis    02 Aug 2014EXT13.20.451, Version: EXT_13.2_HF4
appath     $EXT_HOME/tools/bin
#-------------------------------------------------------------------

#-------------------------------------------------------------------
#module-whatis    PVS141  (05 Dec 2014  PVS14.12.000, Version: PVS14.12-s293)
appath     $PVS_HOME/bin
#-------------------------------------------------------------------

echo "* You can now start by going to cds folder and  running:>  virtuoso  -l  myvirt.log & "
