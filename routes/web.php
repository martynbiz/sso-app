<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| This file is where you may define all of the routes that are handled
| by your application. Just tell Laravel the URIs it should respond
| to using a Closure or controller method. Build something great!
|
*/

// Route::get('/', function () {
//     $value = session('key');
//     if (is_null($value)) {
//         Session::put('key', md5(rand()));
//     }
//     Session::save();
//     // dd(session('key'));
//
//     return view('welcome');
// });

Route::get('/', 'HomeController@index')->name('home');
Route::get('/login', 'HomeController@login')->name('login');
