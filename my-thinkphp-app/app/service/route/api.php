<?php
use think\facade\Route;

Route::rule('smscode', 'sms/code','get|post');
Route::rule('checkSmscode', 'sms/checkSmsCode','post');
Route::rule('checkUsername', 'User/checkUsername','post');
Route::rule('saveUserReg', 'User/saveUserReg','post');
Route::rule('checkIdCardExists', 'User/checkIdCardExists','post');
Route::rule('checkPhoneExists', 'User/checkPhoneExists','post');
Route::rule('getPositions', 'User/getPositions','post');