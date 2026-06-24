<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\ProjectRequest;
use App\Http\Resources\ProjectResource;
use App\Models\Project;
use Illuminate\Support\Facades\Storage;

class ProjectController extends Controller
{
    public function index()
    {
        return response()->json([
            'data' => ProjectResource::collection(
                Project::where('visible', true)->orderBy('order')->get()
            ),
        ], 200);
    }

    public function store(ProjectRequest $request)
    {
        $data = $request->validated();

        if ($request->hasFile('image')) {
            $data['image'] = $request->file('image')->store('projects', 'public');
        }
        $data['visible'] = filter_var($data['visible'] ?? true, FILTER_VALIDATE_BOOLEAN);



        $project = Project::create($data);




        return response()->json([
            'message' => 'Proyecto creado correctamente',
            'data'    => new ProjectResource($project->load('images')),
        ], 201);
    }

    public function show(Project $project)
    {
        return response()->json([
            'data' => new ProjectResource($project->load('images')),
        ], 200);
    }

    public function update(ProjectRequest $request, Project $project)
    {
        $data = $request->validated();

        if ($request->hasFile('image')) {
            if ($project->image) {
                Storage::disk('public')->delete($project->image);
            }
            $data['image'] = $request->file('image')->store('projects', 'public');
        }
        $data['visible'] = filter_var($data['visible'] ?? true, FILTER_VALIDATE_BOOLEAN);

        $project->update($data);

        return response()->json([
            'message' => 'Proyecto actualizado correctamente',
            'data'    => new ProjectResource($project->load('images')),
        ], 200);
    }

    public function destroy(Project $project)
    {
        if ($project->image) {
            Storage::disk('public')->delete($project->image);
        }

        foreach ($project->images as $image) {
            Storage::disk('public')->delete($image->path);
        }

        $project->delete();

        return response()->json([
            'message' => 'Proyecto eliminado correctamente',
        ], 200);
    }
}
