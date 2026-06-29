<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\ContactRequest;
use App\Mail\ContactFormMail;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Mail;

class ContactController extends Controller
{
    public function store(ContactRequest $request): JsonResponse
    {
        $validated = $request->validated();

        Mail::to(config('mail.contact_address'))
            ->send(new ContactFormMail(
                senderName: $validated['name'],
                senderEmail: $validated['email'],
                body: $validated['message'],
            ));

        return response()->json(['message' => 'Mensaje enviado correctamente.']);
    }
}
