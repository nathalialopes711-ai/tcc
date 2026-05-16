<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes - TCC: Localizador de Eventos Locais
|--------------------------------------------------------------------------
*/

Route::get('/status', function () {
    return response()->json([
        'status' => 'online',
        'message' => 'API de Eventos Localizze funcionando!',
        'timestamp' => now()->toIso8601String()
    ]);
});

Route::get('/eventos', function () {
    return response()->json([
        [
            'id' => 1,
            'nome' => 'Festival de Inverno',
            'categoria' => 'Cultura',
            'local' => 'Parque Municipal',
            'distancia' => '2.5km'
        ],
        [
            'id' => 2,
            'nome' => 'Maratona Noturna',
            'categoria' => 'Esporte',
            'local' => 'Av. Central',
            'distancia' => '1.2km'
        ]
    ]);
});

Route::get('/categorias', function () {
    return response()->json([
        ['id' => 1, 'nome' => 'Música', 'slug' => 'musica'],
        ['id' => 2, 'nome' => 'Esporte', 'slug' => 'esporte'],
        ['id' => 3, 'nome' => 'Gastronomia', 'slug' => 'gastronomia'],
        ['id' => 4, 'nome' => 'Cultura', 'slug' => 'cultura']
    ]);
});

Route::get('/eventos/busca', function (Request $request) {
    $tipo = $request->query('tipo', 'todos');
    return response()->json([
        'busca' => $tipo,
        'resultados' => [
            [
                'id' => 3,
                'nome' => 'Feira de Artesanato',
                'categoria' => 'Cultura',
                'local' => 'Praça da Matriz'
            ]
        ]
    ]);
});
