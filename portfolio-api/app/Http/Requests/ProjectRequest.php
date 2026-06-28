<?php

namespace App\Http\Requests;


use Illuminate\Foundation\Http\FormRequest;

class ProjectRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }


    public function rules(): array
    {

        $required = $this->isMethod('POST') ? 'required' : 'sometimes';
        return [
            'title' => "$required|string|max:255",
            'intro' => 'nullable|string|max:500',
            'description' => "$required|string",
            'image' => 'nullable|image|mimes:jpeg,png,jpg,webp|max:2048',
            'url' => 'nullable|url',
            'technologies' => "$required|array",
            'order' => 'integer',
            'visible' => 'boolean'
        ];
    }
}
