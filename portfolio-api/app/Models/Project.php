<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Project extends Model
{
    protected $fillable = [
        'title',
        'description',
        'image',
        'url',
        'technologies',
        'order',
        'visible'
    ];

    protected $casts = [
        'technologies' => 'array',
        'visible' => 'boolean',
        'order' => 'integer'
    ];
}
