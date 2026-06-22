<?php

use App\Http\Controllers\Api\AboutController;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\ProjectController;
use App\Http\Controllers\Api\ProjectImageController;
use Illuminate\Support\Facades\Route;

Route::post('/login', [AuthController::class, 'login']);

Route::get('/projects', [ProjectController::class, 'index']);
Route::get('/projects/{project}', [ProjectController::class, 'show']);
Route::get('/about', [AboutController::class, 'index']);

Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::apiResource('projects', ProjectController::class)->except(['index']);
    Route::post('/projects/{project}/images', [ProjectImageController::class, 'store']);
    Route::delete('/projects/{project}/images/{projectImage}', [ProjectImageController::class, 'destroy']);
    Route::put('/projects/{project}/images/reorder', [ProjectImageController::class, 'reorder']);
    Route::apiResource('about', AboutController::class)->except(['index']);
});
