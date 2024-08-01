#include <stdio.h>
#include <stdlib.h>

#define LOG_ERROR(message)   printf("ERROR: %s\n", message)
#define LOG_WARN(message)    printf("WARN: %s\n", message)
#define LOG_DEBUG(message)   printf("DEBUG: %s\n", message)
#define LOG_TRACE(message)   printf("TRACE: %s\n", message)
#define LOG_INFO(message)    printf("INFO: %s\n", message)

int main() {
    LOG_ERROR("This is an error message");
    LOG_WARN("This is a warning message");
    LOG_DEBUG("This is a debug message");
    LOG_TRACE("This is a trace message");
    LOG_INFO("This is an info message");

    return 0;
}

