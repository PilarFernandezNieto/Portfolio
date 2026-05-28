<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\AboutRequest;
use App\Http\Resources\AboutResource;
use App\Models\About;

class AboutController extends Controller
{
    public function index()
    {
        return response()->json([
            'data' => new AboutResource(About::first()),
        ], 200);
    }

    public function store(AboutRequest $request)
    {
        $about = About::create($request->validated());

        return response()->json([
            'message' => 'Información creada correctamente',
            'data'    => new AboutResource($about),
        ], 201);
    }

    public function show(About $about)
    {
        return response()->json([
            'data' => new AboutResource($about),
        ], 200);
    }

    public function update(AboutRequest $request, About $about)
    {
        $about->update($request->validated());

        return response()->json([
            'message' => 'Información actualizada correctamente',
            'data'    => new AboutResource($about),
        ], 200);
    }

    public function destroy(About $about)
    {
        $about->delete();

        return response()->json([
            'message' => 'Información eliminada correctamente',
        ], 200);
    }
}
