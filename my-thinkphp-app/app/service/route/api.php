<?php
use think\facade\Route;

Route::rule('smscode', 'sms/code','post');
Route::rule('checkUsername', 'User/checkUsername','post');