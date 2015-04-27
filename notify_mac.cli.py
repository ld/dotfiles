# -*- coding:utf-8 -*-
import objc
import sys


NSUserNotification = objc.lookUpClass('NSUserNotification')
NSUserNotificationCenter = objc.lookUpClass('NSUserNotificationCenter')


def notify(title, subtitle, info_text, delay=0, sound=True):
    notification = NSUserNotification.alloc().init()
    notification.setTitle_(title)
    notification.setSubtitle_(subtitle)
    notification.setInformativeText_(info_text)
    # notification.setUserInfo_(userInfo)
    if sound:
        notification.setSoundName_("NSUserNotificationDefaultSoundName")
    NSUserNotificationCenter.\
        defaultUserNotificationCenter().\
        scheduleNotification_(notification)


notify("Test message", "Subtitle",
       "This message should appear instantly, with a sound", sound=True)
sys.stdout.write("Notification sent...\n")
