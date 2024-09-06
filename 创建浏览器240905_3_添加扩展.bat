@echo off
rem 加入了自动添加扩展的功能.
rem 后来证实，添加的扩展功能没有用，每次重新打开就要重新配置shocks代理.
rem 加入了命名并且自动添加快捷方式.
rem 注意这里需要另存为 utf8格式.
rem 注意，所有中文任何时候都要用英文的句号结束。否则，会有乱码问题.
rem 假设你选择了使用 GB2312 编码并保存为 ANSI 编码的文件对应的就是：chcp 936 >nul  UTF-8 对应的就是：chcp 65001 >nul
chcp 65001 >nul

setlocal enabledelayedexpansion
set "CHROME_PATH=C:\Program Files\Google\Chrome\Application\chrome.exe"
rem Profile 后面是有一个空格的，这是格式需求
set "PROFILE_DIR=Profile "
set "start_index=134"
set "maxmum_need_created=1"
set "user_choice=2"
set "extension_path=abcpathtest"

rem 获取用户输入
set /p start_index=请输入已经在你电脑上存在的最大内部序号（如果不懂，可以在最新创建的浏览器-》副键-》属性-》目标的文字最后面有一个数字，输入这个数字便可）： 
set "now_index=%start_index%"

set /p maxmum_need_created=请输入你希望创建的谷歌浏览器数量(最大值为100，最小值为0)： 

rem 检查输入的浏览器数量是否在有效范围内.
if %maxmum_need_created% gtr 100 set maxmum_need_created=100
if %maxmum_need_created% lss 0 set maxmum_need_created=0

echo 已知上一个已经创建的谷歌浏览器内部序号是：!now_index! ，(注意这里的内部序号和你的gmail序号不一样).
echo 同时得知你希望一次性创建 !maxmum_need_created! 个浏览器.



rem 获取扩展所在的文件夹路径.
set /p extension_path=请输入扩展所在的文件夹路径（支持中文路径）： 



rem 去除扩展路径的引号.
set "extension_path=!extension_path:"=!"

rem 初始化扩展路径参数.
set "extensions="

rem 检索扩展所在文件夹内的所有扩展文件夹.
for /d %%i in ("!extension_path!\*") do (
    set "extensions=!extensions!,%%i"
)

rem 移除最前面的逗号.
set "extensions=!extensions:~1!"

echo 继续请按“1”，返回请按“2”.
set /p user_choice=选择:

if "%user_choice%"=="2" goto end

:new_roop
rem 创建谷歌浏览器实例.
for /l %%x in (1, 1, %maxmum_need_created%) do (
    set /a now_index=now_index+1
    echo [%date% !time!] 开始创建内部序号是第 !now_index! 个谷歌浏览器.
    
    rem 添加随机延迟，延迟时间在 1 到 3 秒之间
    set /a delay=%random% %% 3 + 1
    timeout /t !delay! >nul
    
    start "" "%CHROME_PATH%" --profile-directory="%PROFILE_DIR%!now_index!" --load-extension="!extensions!"
    
    rem 再次添加随机延迟以模拟页面加载时间.
    set /a delay=%random% %% 3 + 2
    timeout /t !delay! >nul

    echo [%date% !time!] 创建了第 !now_index! 个浏览器 >> log.txt
)

echo 继续重复循环请按“1”，返回请按“2”（这样是为了操作方便）.
set /p user_choice=选择:

if "%user_choice%"=="1" goto new_roop

:end
echo 完成，按任意键结束.
pause >nul
