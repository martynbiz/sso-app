<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class HomeController extends Controller
{
    //
    public function index(Request $request)
    {
        return view('welcome');
    }

    //
    public function login(Request $request)
    {
        // initiate login
        // $storage = new \MartynBiz\Sso\Storage\LaravelSession($request->session(), 'phpsso__');
        $storage = new \MartynBiz\Sso\Storage\Session('phpsso__');
        $authClient = new \MartynBiz\Sso\Client($storage, array(
            'client_id' => 'oeco',
            'client_secret' => 'qwertyuiop1234567890',
            'server_url' => 'http://sso.vagrant',
        ));
        $returnTo = $request->input('returnTo', $request->url());
        $authClient->login([
            'returnTo' => $returnTo,
        ]);

        return redirect('/');
    }
}
