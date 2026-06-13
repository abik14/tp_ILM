#ifndef __STDIO_H__
#define __STDIO_H__

#include "stdarg.h"
int printf(const char *__format, ...) __attribute__((format (printf, 1, 2)));
int putchar(int c);
#endif /* __STDIO_H__ */
