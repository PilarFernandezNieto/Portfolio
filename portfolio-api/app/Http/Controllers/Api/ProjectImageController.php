<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Project;
use App\Models\ProjectImage;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class ProjectImageController extends Controller
{
    public function store(Request $request, Project $project)
    {
        $request->validate([
            'images'   => 'required|array',
            'images.*' => 'required|image|max:5000',
        ]);

        $order = $project->images()->count();
        $created = [];

        foreach ($request->file('images') as $file) {
            $path = $file->store('projects', 'public');
            $created[] = $project->images()->create([
                'path'  => $path,
                'order' => $order++,
            ]);
        }

        return response()->json([
            'message' => 'Imágenes subidas correctamente',
            'data'    => collect($created)->map(fn($img) => [
                'id'    => $img->id,
                'path'  => $img->path,
                'order' => $img->order,
            ])->values(),
        ], 201);
    }

    public function destroy(Project $project, ProjectImage $projectImage)
    {
        Storage::disk('public')->delete($projectImage->path);
        $projectImage->delete();

        return response()->json([
            'message' => 'Imagen eliminada correctamente',
        ], 200);
    }

    public function reorder(Request $request, Project $project)
    {
        $request->validate([
            'images'          => 'required|array',
            'images.*.id'     => 'required|integer|exists:project_images,id',
            'images.*.order'  => 'required|integer|min:0',
        ]);

        foreach ($request->input('images') as $item) {
            $project->images()->where('id', $item['id'])->update(['order' => $item['order']]);
        }

        return response()->json([
            'message' => 'Orden actualizado correctamente',
        ], 200);
    }
}
