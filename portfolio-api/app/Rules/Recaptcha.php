<?php

namespace App\Rules;

use Closure;
use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Http\Client\ConnectionException;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class Recaptcha implements ValidationRule
{
    private const VERIFY_URL = 'https://www.google.com/recaptcha/api/siteverify';

    public function __construct(private readonly string $action) {}

    public function validate(string $attribute, mixed $value, Closure $fail): void
    {
        $secret = config('services.recaptcha.secret_key');

        if (empty($secret)) {
            Log::error('reCAPTCHA: falta RECAPTCHA_SECRET_KEY en el .env');
            $fail('No se ha podido verificar el reCAPTCHA. Inténtalo más tarde.');

            return;
        }

        try {
            $response = Http::asForm()
                ->timeout(5)
                ->post(self::VERIFY_URL, [
                    'secret' => $secret,
                    'response' => $value,
                    'remoteip' => request()->ip(),
                ]);
        } catch (ConnectionException $e) {
            Log::warning('reCAPTCHA: no se pudo contactar con Google', ['error' => $e->getMessage()]);
            $fail('No se ha podido verificar el reCAPTCHA. Inténtalo de nuevo.');

            return;
        }

        if ($response->failed()) {
            Log::warning('reCAPTCHA: respuesta inesperada de Google', ['status' => $response->status()]);
            $fail('No se ha podido verificar el reCAPTCHA. Inténtalo de nuevo.');

            return;
        }

        $result = $response->json();
        $minScore = (float) config('services.recaptcha.min_score');

        $valid = ($result['success'] ?? false) === true
            && ($result['action'] ?? null) === $this->action
            && (float) ($result['score'] ?? 0) >= $minScore;

        if (! $valid) {
            Log::info('reCAPTCHA rechazado', [
                'score' => $result['score'] ?? null,
                'action' => $result['action'] ?? null,
                'errors' => $result['error-codes'] ?? [],
            ]);
            $fail('No hemos podido verificar que eres una persona. Inténtalo de nuevo.');
        }
    }
}
