<?php

use App\Kernel;
use Xhgui\Profiler\Profiler;

require_once dirname(__DIR__).'/vendor/autoload_runtime.php';

return function (array $context) {
    $profiler = new Profiler([
        'save.handler' => Profiler::SAVER_UPLOAD,
        'save.handler.upload' => [
            'url' => $context['PROFILER_UPLOAD_URL'],
            'token' => $context['PROFILER_UPLOAD_TOKEN'],
        ],
    ]);
    $profiler->start();

    return new Kernel($context['APP_ENV'], (bool) $context['APP_DEBUG']);
};
