% Close model and clear workspace
bdclose all
clear all
clc

% Delete code generation folders and files
if exist('slprj', 'dir'), rmdir('slprj', 's'); end
if exist('test_ert_rtw', 'dir'), rmdir('test_ert_rtw', 's'); end

% Delete model cache and build metadata
delete test.slxc
delete test_settings.mat
delete test_faultInfo.xml
delete test.bin
delete test.elf
delete test.pmpx
delete testConfig.mex
