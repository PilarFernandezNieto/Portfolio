<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ProjectResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id'           => $this->id,
            'title'        => $this->title,
            'description'  => $this->description,
            'image'        => $this->image,
            'url'          => $this->url,
            'technologies' => $this->technologies,
            'order'        => $this->order,
            'visible'      => $this->visible,
            'images'       => $this->whenLoaded('images', function () {
                return $this->images->map(fn($img) => [
                    'id'    => $img->id,
                    'path'  => $img->path,
                    'order' => $img->order,
                ])->values();
            }, []),
        ];
    }
}
