<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\AboutRequest;
use App\Http\Resources\AboutResource;
use App\Models\About;
use Illuminate\Support\Facades\Storage;

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
        $data = $request->validated();

        if ($request->hasFile('image')) {
            $data['image'] = $request->file('image')->store('about', 'public');
        }

        $about = About::create($data);



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
        $data = $request->validated();

        if ($request->hasFile('image')) {
            if ($about->image) {
                Storage::disk('public')->delete($about->image);
            }
            $data['image'] = $request->file('image')->store('about', 'public');
        }

        $about->update($data);

        return response()->json([
            'message' => 'Información actualizada correctamente',
            'data'    => new AboutResource($about),
        ], 200);
    }

    public function destroy(About $about)
    {

        if ($about->image) {
            Storage::disk('public')->delete($about->image);
        }
        $about->delete();

        return response()->json([
            'message' => 'Información eliminada correctamente',
        ], 200);
    }
}
