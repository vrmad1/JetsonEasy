#!/bin/bash
# Copyright (C) 2018, Raffaello Bonghi <raffaello@rnext.it>
# All rights reserved
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
# 1. Redistributions of source code must retain the above copyright 
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 3. Neither the name of the copyright holder nor the names of its 
#    contributors may be used to endorse or promote products derived 
#    from this software without specific prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND 
# CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, 
# BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS 
# FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; 
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, 
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE 
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, 
# EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

# Load environment variables:
# - JETSON_BOARD
# - JETSON_L4T (JETSON_L4T_RELEASE, JETSON_L4T_REVISION)
# - JETSON_DESCRIPTION
# - JETSON_CUDA
# - JETSON_OPENCV and JETSON_OPENCV_CUDA
source /etc/jetson_easy/jetson_variables
# Load NVP model status
if [ "$JETSON_BOARD" = "Xavier" ] || [ "$JETSON_BOARD" = "TX2i" ] || [ "$JETSON_BOARD" = "TX2" ] ; then
	NVPModel="$(nvpmodel -q 2>/dev/null | head -n 1)"
	NVPModel_type="$(nvpmodel -q 2>/dev/null | sed -n 2p)"
fi

#Print Jetson version
echo " - $JETSON_DESCRIPTION"
# Print Jetpack and kernel
echo "   * Jetpack $JETSON_JETPACK [L4T $JETSON_L4T]"
# Print CUDA GPU architecture
echo "   * CUDA GPU architecture $JETSON_CUDA_ARCH_BIN"
#Print status NVPModel
if [ "$JETSON_BOARD" = "Xavier" ] || [ "$JETSON_BOARD" = "TX2i" ] || [ "$JETSON_BOARD" = "TX2" ] ; then
	echo "   * $NVPModel - Type: $NVPModel_type"
fi

# Libraries
echo " - Libraries:"
#Print Cuda version
echo "   * CUDA $JETSON_CUDA"
#Print OpenCv version and cuda compiled
if [ $JETSON_OPENCV_CUDA = "YES" ] ; then
    echo "   * OpenCV $JETSON_OPENCV compiled CUDA: ${green}$JETSON_OPENCV_CUDA${reset}"
else
	echo "   * OpenCV $JETSON_OPENCV compiled CUDA: ${red}$JETSON_OPENCV_CUDA${reset}"
fi
#Print status Jetson Performance service
JE_PERFOMANCE_STATUS="$(systemctl is-active jetson_performance.service)"
if [ $JE_PERFOMANCE_STATUS = "active" ] ; then
	echo " - Jetson Performance: ${green}$JE_PERFOMANCE_STATUS${reset}"
else
	echo " - Jetson Performance: ${red}$JE_PERFOMANCE_STATUS${reset}"
fi
#Print Jetson easy version
echo " - Jetson Easy v$JETSON_EASY_VERSION"

exit 0


