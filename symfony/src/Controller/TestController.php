<?php

declare(strict_types=1);

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;

final class TestController extends AbstractController
{
    /**
     * @Route("/", name = "index", format = "json")
     */
    public function index(): JsonResponse
    {
        return new JsonResponse(['response' => 'ok']);
    }
}
