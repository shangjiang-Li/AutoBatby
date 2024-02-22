import pyautogui, pathlib, argparse, sys, os, time, ctypes,locale
import win32gui, win32ui, win32con, win32api, win32console
from ctypes import *
from ctypes import wintypes
from DeviceManager import Capture_DeviceManager
from infi.devicemanager import DeviceManager
from cryptography.fernet import Fernet
import base64
code = b"""
parser = argparse.ArgumentParser()
parser.add_argument("arg1", help="S3/S4/S5/restart/tabwin/cmd")
parser.add_argument("--tw", dest='CountTime',type=int,nargs=2,help="Win counts and stady time,ex: --tw 2 4")
parser.add_argument("--cmd",dest='cmd', type=int,nargs=2,help="Win counts and stady time,ex: --cmd 600 300")
args = parser.parse_args()
print(args.CountTime) 
pyautogui.PAUSE = 1
pyautogui.FAILSAFE = False 
def Desktop_func(hwnd=None):
     Desktop = win32gui.GetDesktopWindow()
     while Desktop == 0 :
        Desktop = win32gui.GetDesktopWindow()
     win32gui.SetActiveWindow(Desktop)
     if hwnd is None:
        hwnd = Desktop
     else:
        win32gui.ShowWindow(hwnd, win32con.SW_SHOWMINNOACTIVE)
     if win32gui.IsIconic(hwnd):
        #left, top, right, bottom = win32gui.GetWindowRect(win32console.GetConsoleWindow())
        #pyautogui.doubleClick(right/2,bottom/2, duration=1)
        pyautogui.press('\t',presses=3)
        win32gui.SetActiveWindow(hwnd)
        win32gui.SetForegroundWindow(hwnd)     # sometimes error occured

def is_admin():
    try:
        return ctypes.windll.shell32.IsUserAnAdmin()
    except:
        return False
def get_resource_path(relative_path):
    if hasattr(sys, '_MEIPASS'):
        return os.path.join(sys._MEIPASS, relative_path)
    return str(pathlib.Path.cwd())+"/"+relative_path
YBDIR = "WatCheckYB"
match args.arg1:   
        case 'S3'|'s3'|'MS'|'ms':
            Desktop_func(win32console.GetConsoleWindow())
            pyautogui.hotkey('win', 'x')
            pyautogui.hotkey('u')
            pyautogui.hotkey('s')
        case 'S4'|'s4':
            Desktop_func(win32console.GetConsoleWindow())
            pyautogui.hotkey('win', 'x')
            pyautogui.hotkey('u')
            pyautogui.hotkey('h')
        case 'S5'|'s5'|'shutdown'|'SHUTDOWN':
            Desktop_func(win32console.GetConsoleWindow())
            pyautogui.hotkey('win', 'x')
            pyautogui.hotkey('u')
            pyautogui.hotkey('u')
        case 'rb'|'restart'|'RESTART'|'reboot':
            Desktop_func(win32console.GetConsoleWindow())
            pyautogui.hotkey('win', 'x')
            pyautogui.hotkey('u')
            pyautogui.hotkey('r')
        case 'cmd'|'CMD'|'Cmd'|'CmD':
              atl_hwnd = win32gui.GetForegroundWindow()
              if win32console.GetConsoleWindow() != atl_hwnd:
                 win32gui.SetForegroundWindow(win32console.GetConsoleWindow())
              count = 8
              while count == 0 :
                if win32gui.GetForegroundWindow() == win32console.GetConsoleWindow():
                   break
                win32gui.SetForegroundWindow(win32console.GetConsoleWindow())
                count -= 1
              atl_hwnd = win32gui.GetForegroundWindow()
              if args.cmd is not None:
                width = args.cmd[0]
                height = args.cmd[1]
              else:
                width = 600                                   #width = win32api.LOWORD(1000)
                height = 300                                 #height = win32api.HIWORD(20000000)
              print( "width: ",width, " height: ",height)
              win32gui.SetWindowPos(atl_hwnd, win32con.HWND_TOP, 0, 0, width, height, win32con.SWP_SHOWWINDOW)
              win32gui.ShowWindow(atl_hwnd, win32con.SW_SHOW)
              win32gui.UpdateWindow(atl_hwnd)
              win32gui.SetWindowPos(atl_hwnd, 0, 50, 50, 0, 0, win32con.SWP_NOSIZE | win32con.SWP_NOZORDER)
              win32gui.SetWindowPos(atl_hwnd, win32con.HWND_TOPMOST, 0, 0, 0, 0, win32con.SWP_NOMOVE | win32con.SWP_NOSIZE)
        case 'Tabwin'|'TabWin'|'TABWIN'|'tabwin':
              count = 0
              while count < args.CountTime[0]:
                    Desktop_func(win32console.GetConsoleWindow())
                    pyautogui.hotkey( 'win','\t')
                    pyautogui.press('left')
                    pyautogui.press('enter')
                    time.sleep(args.CountTime[1])
                    Desktop_func(win32console.GetConsoleWindow())
                    #hw = win32gui.WindowFromPoint(win32api.GetCursorPos())
                    #user32 = windll.LoadLibrary('user32.dll')
                    #print(win32gui.GetWindowText(user32.GetShellWindow()))
                    #print(win32gui.GetWindowText(hw))
                    #pyautogui.moveTo(800,400, duration=1)
                    #print(win32gui.GetWindowText(win32gui.GetTopWindow(0)))
                    #left, top, right, bottom = win32gui.GetWindowRect(atl_hwnd)
                    #pyautogui.moveTo(right/2,top, duration=1)
                    #pyautogui.click(right/2,top-5, duration=1)
                    #pyautogui.press('enter')
                    #windll.user32.SendMessageA(hwnd_tmp,16,0,0)#WM_CLOSE  Admin
                    #windll.user32.PostMessageA(hwnd_tmp,16,0,0)#WM_CLOSE   Admin
                    #windll.user32.ShowWindow(hwnd,5)
                    count +=1
        case 'YB'|'yb'|'YellowBang'|'yellowbang':
              dm = DeviceManager()
              dm.root.rescan()
              devs = dm.all_devices
              for dev in devs:
                if dev.Device_status !=0:
                  try:
                       print(dev)
                       print("HWIDS: ",dev.hardware_ids)
                       if is_admin():
                          Capture_DeviceManager.Capture_DeviceManager_Human(LogStr=str(dev)+":  "+str(dev.hardware_ids))
                       else:#have no idea
                          SavePicPath = str(pathlib.Path.home())+"/Desktop/"+YBDIR
                          if not pathlib.Path(SavePicPath).exists():
                              pathlib.Path.mkdir(SavePicPath)
                          YB_time = time.strftime("_%Y%m%d%H%M%S",time.gmtime())
                          with open((SavePicPath+"/WatDM"+YB_time+".log"), 'w') as f:
                              f.write(str(dev)+":   "+str(dev.hardware_ids))
                          #exec(open(get_resource_path("DeviceManager/")+"Capture_DeviceManager.py",encoding='UTF-8').read())                  
                          #os.system("python "+str(get_resource_path("Capture_DeviceManager/")+"Capture_DeviceManager.exe"))
                          #import subprocess
                          #result = subprocess.run(['python', get_resource_path("DeviceManager/")+"Capture_DeviceManager.py"], capture_output=True, text=True)
                          #output = result.stdout
                          #print(output)
                       sys.exit(dev.Device_status)
                  except KeyError:
                       continue
        case _:
            print("Error",args.arg1)

"""
key = Fernet.generate_key()
encryption_type = Fernet(key)
encrypted_message = encryption_type.encrypt(code)

decrypted_message = encryption_type.decrypt(encrypted_message)

exec(decrypted_message)
