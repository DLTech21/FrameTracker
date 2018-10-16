#
# Created on: 2016-2-16
#     Author: Wang Yang
#       Mail: admin@wysaid.org
#

MAKEFILE_PATH := $(call my-dir)

##############################

OPENCV_ROOT=$(MAKEFILE_PATH)/opencv

CVLIB_DIR=$(OPENCV_ROOT)/lib/$(TARGET_ARCH_ABI)

include $(CLEAR_VARS)
LOCAL_MODULE := opencv_core
LOCAL_SRC_FILES := $(CVLIB_DIR)/libopencv_core.a
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := opencv_imgproc
LOCAL_SRC_FILES := $(CVLIB_DIR)/libopencv_imgproc.a
include $(PREBUILT_STATIC_LIBRARY)

# include $(CLEAR_VARS)
# LOCAL_MODULE := opencv_objdetect
# LOCAL_SRC_FILES := $(CVLIB_DIR)/libopencv_objdetect.a
# include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := tbb
LOCAL_SRC_FILES := $(CVLIB_DIR)/libtbb.a
include $(PREBUILT_STATIC_LIBRARY)


include $(CLEAR_VARS)

LOCAL_MODULE    := FrameTracker

#*********************** FrameTracker Library ****************************

TRACKER_ROOT=$(MAKEFILE_PATH)
TRACKER_SOURCE=$(TRACKER_ROOT)

LOCAL_C_INCLUDES += \
					$(TRACKER_ROOT) \
					$(OPENCV_ROOT) \
					$(OPENCV_ROOT)/opencv2 \


LOCAL_SRC_FILES :=  \
			$(TRACKER_SOURCE)/android_utils.cpp \
			$(TRACKER_SOURCE)/opencv_utils.cpp \
			$(TRACKER_SOURCE)/smart_camera.cpp \

			

LOCAL_STATIC_LIBRARIES := \
			opencv_imgproc \
			opencv_core \
			tbb 

LOCAL_CPPFLAGS := -frtti -std=gnu++11
LOCAL_LDLIBS :=  -llog -ljnigraphics -lz -ldl -lm -latomic

LOCAL_CFLAGS    := -D_CGE_LOGS_ -DANDROID_NDK -DCGE_LOG_TAG=\"libCGE\" -D__STDC_CONSTANT_MACROS -O3 -ffast-math -funroll-loops

LOCAL_CPPFLAGS += -fexceptions

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_CFLAGS := $(LOCAL_CFLAGS) -march=armv7-a -mfpu=neon -mfloat-abi=softfp
LOCAL_ARM_NEON := true
endif

ifeq ($(TARGET_ARCH_ABI),armeabi)
LOCAL_CFLAGS := $(LOCAL_CFLAGS) -mfloat-abi=softfp
endif

LOCAL_ARM_MODE := arm

LOCAL_EXPORT_C_INCLUDES := $(TRACKER_ROOT)

include $(BUILD_SHARED_LIBRARY)



