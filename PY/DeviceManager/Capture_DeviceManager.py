import pyautogui, pathlib, argparse, sys, os, time, ctypes, locale
import win32gui, win32ui, win32con, win32api

default_locale = locale.getdefaultlocale()
print("默认语言设置：", default_locale[0])
print("默认编码设置：", default_locale[1])

def is_admin():
    try:
        return ctypes.windll.shell32.IsUserAnAdmin()
    except:
        return False

def Capture_DeviceManager_Human(YBDIR="WatCheckYB",LogStr=None):
    
    match default_locale[0]:
        case 'zh_CN':
  	      DM_name = "设备管理器"
        case 'en_US':
  	      DM_name = "Device Manager"
        case _:
            print("默认语言：",default_locale[0])
            return 3
    DM = pyautogui.getWindowsWithTitle(DM_name)
    i_count = 0
    while len(DM) <= 0 :
        pDM = os.popen("devmgmt.msc")
        time.sleep(2)
        DM = pyautogui.getWindowsWithTitle(DM_name)
        i_count = i_count+1
        if len(DM) > 0 or i_count > 5 :
           break
    DM[0].activate()
    hwnd = DM[0]._hWnd
    left, top, right, bottom = win32gui.GetWindowRect(hwnd)
    win32gui.SetWindowPos(hwnd, win32con.HWND_TOPMOST, 0, 0, 0, 0, win32con.SWP_NOMOVE | win32con.SWP_NOSIZE)  #Admin
    win32gui.SendMessage(hwnd, win32con.WM_SYSCOMMAND, win32con.SC_RESTORE, 0)
    win32gui.SetForegroundWindow(hwnd) 
    pyautogui.click(left + (right-left) / 2, top + (bottom-top)/2, duration=1)
    win32gui.ShowWindow(hwnd,win32con.SW_MAXIMIZE)
    time.sleep(1)
    pyautogui.scroll(-999999999,right, bottom)
    left_MAX, top_MAX, right_MAX, bottom_MAX = win32gui.GetWindowRect(hwnd)
    text_image = pyautogui.screenshot(region=(left_MAX, top_MAX, right_MAX-left_MAX, bottom_MAX-top_MAX))
    win32gui.MoveWindow(hwnd, left, top, right, bottom, True)  #Admin
    SavePicPath = str(pathlib.Path.home())+"/Desktop/"+YBDIR
    if not pathlib.Path(SavePicPath).exists():
           pathlib.Path.mkdir(SavePicPath)
    YB_time = time.strftime("_%Y%m%d%H%M%S",time.gmtime())
    if LogStr is not None:
        print(LogStr)
        with open((SavePicPath+"/WatDM"+YB_time+".log"), 'w') as f:
                f.write(LogStr)
    print(SavePicPath+"/WatDM"+YB_time+".png")
    text_image.save((SavePicPath+"/WatDM"+YB_time+".png"))
    print("Device Mananager Capurtes")
    win32gui.PostMessage(hwnd,win32con.WM_CLOSE,0,0)
if __name__=='__main__':
   if is_admin():
      Capture_DeviceManager_Human()
   elif sys.version_info[0] == 3:
         ctypes.windll.shell32.ShellExecuteW(None, "runas", sys.executable, __file__, None, 0)#0--->1
   else:#in python2.x
         ctypes.windll.shell32.ShellExecuteW(None, u"runas", unicode(sys.executable),unicode(__file__), None, 0)#0--->1
