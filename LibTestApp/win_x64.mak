#
# Copyright (c) 2017, Intel Corporation
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
#     * Redistributions of source code must retain the above copyright notice,
#       this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of Intel Corporation nor the names of its contributors
#       may be used to endorse or promote products derived from this software
#       without specific prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

APP = ipsec_MB_testapp
IPSECLIB = ..\libIPSec_MB.lib

!ifdef DEBUG
DCFLAGS = /Od /DDEBUG /Zi /Yd
!else
DCFLAGS = /O2 /Oi
!endif

CC = cl
CFLAGS = /nologo $(DCFLAGS) /Y- /W3 /WX- /Gm- /Gy  /fp:precise /EHsc /I.. /I..\include

all: $(APP)

$(APP): main.obj gcm_test.obj ctr_test.obj $(IPSECLIB)
	$(CC) /Fe$(APP) /MT main.obj gcm_test.obj ctr_test.obj $(IPSECLIB)

main.obj: main.c do_test.h
	$(CC) /c $(CFLAGS) main.c

gcm_test.obj: gcm_test.c gcm_ctr_vectors_test.h
	$(CC) /c $(CFLAGS) gcm_test.c

ctr_test.obj: ctr_test.c gcm_ctr_vectors_test.h
	$(CC) /c $(CFLAGS) ctr_test.c

clean:
	del /q main.obj ctr_test.obj gcm_test.obj $(APP)