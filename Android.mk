LOCAL_PATH:= $(call my-dir)

AXTLS_SRC_FILES := \
	crypto/aes.c \
	crypto/bigint.c \
	crypto/crypto_misc.c \
	crypto/hmac.c \
	crypto/md2.c \
	crypto/md5.c \
	crypto/rc4.c \
	crypto/rsa.c \
	crypto/sha1.c

AXTLS_SRC_FILES += \
	ssl/asn1.c \
	ssl/gen_cert.c \
	ssl/loader.c \
	ssl/openssl.c \
	ssl/os_port.c \
	ssl/p12.c \
	ssl/tls1.c \
	ssl/tls1_svr.c \
	ssl/tls1_clnt.c \
	ssl/x509.c

AXTLS_CFLAGS := -fvisibility=hidden ## -fomit-frame-pointer

include $(CLEAR_VARS)

LOCAL_MODULE:= libyahoo_axtls
LOCAL_MODULE_TAGS := optional

LOCAL_C_INCLUDES += $(LOCAL_PATH)/config
LOCAL_C_INCLUDES += $(LOCAL_PATH)/crypto
LOCAL_C_INCLUDES += $(LOCAL_PATH)/ssl

LOCAL_SRC_FILES := $(AXTLS_SRC_FILES)
LOCAL_CFLAGS := $(AXTLS_CFLAGS)
LOCAL_PRELINK_MODULE := false

# Force enabling PIC so static library can be wrapped into shared
# library later
LOCAL_CFLAGS += -fPIC -DPIC

ifneq ($(NDK_ROOT),)
LOCAL_LDLIBS += -fuse-ld=gold
endif
include $(BUILD_STATIC_LIBRARY)


include $(CLEAR_VARS)
LOCAL_MODULE := axssl
LOCAL_MODULE_TAGS := optional

LOCAL_C_INCLUDES += $(LOCAL_PATH)/config
LOCAL_C_INCLUDES += $(LOCAL_PATH)/crypto
LOCAL_C_INCLUDES += $(LOCAL_PATH)/ssl

#LOCAL_CFLAGS := -Wall -Werror

LOCAL_SRC_FILES := samples/c/axssl.c

LOCAL_STATIC_LIBRARIES += libyahoo_axtls

include $(BUILD_EXECUTABLE)
