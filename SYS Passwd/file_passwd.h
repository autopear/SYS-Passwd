/*
 * Copyright (c) 1999 Apple Computer, Inc. All rights reserved.
 *
 * @APPLE_LICENSE_HEADER_START@
 * 
 * "Portions Copyright (c) 1999 Apple Computer, Inc.  All Rights
 * Reserved.  This file contains Original Code and/or Modifications of
 * Original Code as defined in and that are subject to the Apple Public
 * Source License Version 1.0 (the 'License').  You may not use this file
 * except in compliance with the License.  Please obtain a copy of the
 * License at http://www.apple.com/publicsource and read it before using
 * this file.
 * 
 * The Original Code and all software distributed under the License are
 * distributed on an 'AS IS' basis, WITHOUT WARRANTY OF ANY KIND, EITHER
 * EXPRESS OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES,
 * INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE OR NON-INFRINGEMENT.  Please see the
 * License for the specific language governing rights and limitations
 * under the License."
 * 
 * @APPLE_LICENSE_HEADER_END@
 */

#ifndef PASSWD_H
#define PASSWD_H

#define ERR_USER_NO_EXIST	(1)
#define ERR_USER_PERMISSON	(2)
#define ERR_OLD_PW_WRONG	(3)
#define ERR_TEMP_CREATE		(4)
#define ERR_TEMP_PERMISSON	(5)
#define ERR_TEMP_WRITE		(6)
#define ERR_COMPAT_FILE_NO_EXIST	(7)
#define ERR_COMPAT_FILE_WRITE		(8)
#define ERR_COMPAT_FILE_PERMISSON	(9)
#define ERR_PASSWD_FILE_NO_EXIST	(10)
#define ERR_PASSWD_FILE_WRITE		(11)
#define ERR_PASSWD_FILE_PERMISSON	(12)

int file_passwd(char *uname, int isroot, const char *old_pw, const char *new_pw);


#endif /*PASSWD_H*/
