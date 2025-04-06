<?php
use think\facade\Route;

Route::rule('smscode', 'sms/code','post');
Route::resource('user', 'User');
Route::resource('test', 'Test');