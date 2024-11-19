<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Middleware\JwtMiddleware;
use App\Http\Controllers\JWTAuthController;
use App\Http\Controllers\ConversationController;
use App\Http\Controllers\MessageController;

// Route::get('/user', function (Request $request) {
//     return $request->user();
// })->middleware('auth:sanctum');


 
// use Illuminate\Support\Facades\Route;
Route::prefix('auth')->group(function () {
    Route::post('register', [JWTAuthController::class, 'register']);
    Route::post('login', [JWTAuthController::class, 'login']);

    Route::middleware([JwtMiddleware::class])->group(function () {
        Route::get('user', [JWTAuthController::class, 'getUser']);
        Route::post('verify', [JWTAuthController::class, 'verifyEmail']);
        Route::get('moreVerify', [JWTAuthController::class, 'requestVerifyEmail']);


        Route::post('logout', [JWTAuthController::class, 'logout']);
    });
});


Route::prefix('chats')->group(function () {
    Route::middleware([JwtMiddleware::class])->group(function () {
        Route::get('/', [ConversationController::class, 'index']);
        Route::get('/{id}', [ConversationController::class, 'show']);

        // Route::post('logout', [ConversationController::class, 'logout']);
    });
});


Route::prefix('messeges')->group(function () {
    Route::middleware([JwtMiddleware::class])->group(function () {
        Route::get('/{id}', [MessageController::class, 'show']);
        Route::post('send', [MessageController::class, 'send']);
    });
});















// Route::group([
//     'middleware' => 'api',
//     'prefix' => 'auth'
// ], function ($router) {
//     Route::post('/register', [JWTAuthController::class, 'register'])->name('register');
//     Route::post('/login', [JWTAuthController::class, 'login'])->name('login');
//     Route::post('/logout', [JWTAuthController::class, 'logout'])->middleware('auth:api')->name('logout');
//     // Route::post('/refresh', [JWTAuthController::class, 'refresh'])->middleware('auth:api')->name('refresh');
//     // Route::post('/me', [JWTAuthController::class, 'me'])->middleware('auth:api')->name('me');
// });