<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\ProjectRequest;
use App\Http\Resources\ProjectResource;
use App\Models\Project;
use Illuminate\Support\Facades\Storage;

class ProjectController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return response()->json([
            'data' => ProjectResource::collection(
                Project::where('visible', true)->orderBy('order')->get()
            ),
        ], 200);
    }

    /**
     * Store a newly created resource in storage.
     */
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
            'data'    => new ProjectResource($project),
        ], 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(Project $project)
    {
        return response()->json([
            'data' => new ProjectResource($project),
        ], 200);
    }

    /**
     * Update the specified resource in storage.
     */
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
            'data'    => new ProjectResource($project),
        ], 200);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Project $project)
    {
        if ($project->image) {
            Storage::disk('public')->delete($project->image);
        }

        $project->delete();

        return response()->json([
            'message' => 'Proyecto eliminado correctamente',
        ], 200);
    }
}
